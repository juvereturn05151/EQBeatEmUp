const fs=require('fs'),path=require('path'),crypto=require('crypto');
const sharp=require('C:/Users/drago/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/sharp');
const root='Assets/ArtAssets/Characters/NPCs/ThaiBadBoy';
const template=fs.readFileSync('Assets/ArtAssets/Characters/BlueShirtGuy/Animations/Idle2/BlueShirtGuy_Idle2_01.png.meta','utf8').replace(/\r/g,'');
const clipTemplate=fs.readFileSync('Assets/ArtAssets/Characters/BlueShirtGuy/Animations/Idle2/vvfdvfd.anim','utf8').replace(/\r/g,'');
const guid=p=>fs.existsSync(p+'.meta')?fs.readFileSync(p+'.meta','utf8').match(/^guid: (\w+)/m)[1]:crypto.createHash('md5').update(p.replaceAll('\\','/')).digest('hex');
const report=[];
(async()=>{
for(const name of ['Idle','Walk','Attack1','Hurt','Knockdown']){
 const dir=`${root}/Animations/${name}`,stem=`ThaiBadBoy_${name}`;
 const json=JSON.parse(fs.readFileSync(`${dir}/${stem}_Sheet.json`));
 const keys=[],ids=[];let t=0;const hashes=new Set();
 for(let i=0;i<json.frames.length;i++){
  const p=`${dir}/${stem}_${String(i+1).padStart(2,'0')}.png`,id=guid(p);ids.push(id);
  let meta=template.replace(/^guid: \w+/m,`guid: ${id}`).replace('filterMode: 1','filterMode: 0').replaceAll('textureCompression: 1','textureCompression: 0').replace('alignment: 0','alignment: 9').replace('spritePivot: {x: 0.5, y: 0.5}','spritePivot: {x: 0.5, y: 0.0625}').replace(/spriteID: \w+/,`spriteID: ${crypto.createHash('md5').update(id).digest('hex')}`);
  fs.writeFileSync(p+'.meta',meta);
  keys.push(`    - time: ${t.toFixed(3)}\n      value: {fileID: 21300000, guid: ${id}, type: 3}`);t+=json.frames[i].duration/1000;
  const {data,info}=await sharp(p).ensureAlpha().raw().toBuffer({resolveWithObject:true});
  if(info.width!==160||info.height!==128)throw Error('Wrong canvas '+p);
  let count=0;const colors=new Set();let bottom=0;
  for(let j=0;j<data.length;j+=4){const a=data[j+3];if(a!==0&&a!==255)throw Error('Soft alpha '+p);if(a){count++;colors.add(data.subarray(j,j+3).toString('hex'));const x=(j/4)%160,y=Math.floor(j/4/160);bottom=Math.max(bottom,y);if(x===0||x===159||y===0||y===127)throw Error('Clipping '+p);}}
  if(colors.size>48||count<100)throw Error('Bad pixels '+p);hashes.add(crypto.createHash('sha256').update(data).digest('hex'));
  report.push({animation:name,frame:i+1,colors:colors.size,opaquePixels:count,bottom});
 }
 if(hashes.size!==json.frames.length)throw Error('Duplicate frames '+name);
 keys.push(`    - time: ${t.toFixed(3)}\n      value: {fileID: 21300000, guid: ${ids.at(-1)}, type: 3}`);
 const clip=clipTemplate.replace('m_Name: vvfdvfd',`m_Name: ${stem}`).replace(/    curve:\n[\s\S]*?    attribute:/,`    curve:\n${keys.join('\n')}\n    attribute:`).replace(/    pptrCurveMapping:\n[\s\S]*?  m_AnimationClipSettings:/,`    pptrCurveMapping:\n${[...ids,ids.at(-1)].map(id=>`    - {fileID: 21300000, guid: ${id}, type: 3}`).join('\n')}\n  m_AnimationClipSettings:`).replace('m_SampleRate: 12','m_SampleRate: 100').replace(/m_StopTime: [\d.]+/,`m_StopTime: ${t.toFixed(3)}`).replace('m_LoopTime: 1',`m_LoopTime: ${['Idle','Walk'].includes(name)?1:0}`);
 const anim=`${dir}/${stem}.anim`;fs.writeFileSync(anim,clip);fs.writeFileSync(anim+'.meta',`fileFormatVersion: 2\nguid: ${guid(anim)}\nNativeFormatImporter:\n  externalObjects: {}\n  mainObjectFileID: 7400000\n  userData: \n  assetBundleName: \n  assetBundleVariant: \n`);
 const sheet=`${dir}/${stem}_Sheet.png`,sm=await sharp(sheet).metadata();
 let sheetMeta=template.replace(/^guid: \w+/m,`guid: ${guid(sheet)}`).replace('filterMode: 1','filterMode: 0').replaceAll('textureCompression: 1','textureCompression: 0').replace('spriteMode: 1','spriteMode: 2');
 const slices=json.frames.map((f,i)=>`    - serializedVersion: 2\n      name: ${stem}_${String(i+1).padStart(2,'0')}\n      rect:\n        serializedVersion: 2\n        x: ${f.frame.x}\n        y: ${sm.height-f.frame.y-f.frame.h}\n        width: 160\n        height: 128\n      alignment: 9\n      pivot: {x: 0.5, y: 0.0625}\n      border: {x: 0, y: 0, z: 0, w: 0}\n      outline: []\n      physicsShape: []\n      tessellationDetail: -1\n      bones: []\n      spriteID: ${crypto.createHash('md5').update(sheet+i).digest('hex')}\n      internalID: ${21300000+i}\n      vertices: []\n      indices: \n      edges: []\n      weights: []`);
 sheetMeta=sheetMeta.replace('    sprites: []','    sprites:\n'+slices.join('\n')).replace('    nameFileIdTable: {}','    nameFileIdTable:\n'+json.frames.map((_,i)=>`      ${stem}_${String(i+1).padStart(2,'0')}: ${21300000+i}`).join('\n'));
 fs.writeFileSync(sheet+'.meta',sheetMeta);
 console.log(`${name}: ${json.frames.length} unique frames, ${t.toFixed(2)} seconds, hard alpha, <=48 colors, no edge clipping`);
}
fs.writeFileSync('Tools/ThaiBadBoy/validation.json',JSON.stringify(report,null,2)+'\n');
})();
