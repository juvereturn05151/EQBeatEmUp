const sharp=require('C:/Users/drago/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/sharp');
const root='C:/Users/drago/.codex/generated_images/01a0fb2a-8c99-7311-8035-10978f5cbee8/';
const sources={Idle:'exec-fddd4762-1c92-4a6d-ba34-661b467e171d.png',Walk:'exec-5e0a9202-aa95-4f5e-b376-2ecc09c12b7f.png',Attack1:'exec-c2b56126-8135-4883-b163-87b91edfd07f.png',Hurt:'exec-ffdff6ca-36f1-4c87-9f4c-b2752443051a.png',Knockdown:'exec-e92defb9-2fa8-4b16-afce-fde6894f326c.png'};
(async()=>{for(const [name,file] of Object.entries(sources)){
 const {data,info}=await sharp(root+file).ensureAlpha().raw().toBuffer({resolveWithObject:true});const w=info.width,h=info.height,seen=new Uint8Array(w*h),parts=[];
 for(let i=0;i<w*h;i++){if(seen[i]||data[i*4+3]<128)continue;const q=[i];seen[i]=1;let x0=w,y0=h,x1=0,y1=0;
 for(let k=0;k<q.length;k++){const p=q[k],x=p%w,y=Math.floor(p/w);x0=Math.min(x0,x);x1=Math.max(x1,x);y0=Math.min(y0,y);y1=Math.max(y1,y);for(const n of [x>0?p-1:-1,x<w-1?p+1:-1,y>0?p-w:-1,y<h-1?p+w:-1])if(n>=0&&!seen[n]&&data[n*4+3]>=128){seen[n]=1;q.push(n);}}
 if(q.length>2000)parts.push({x:x0,y:y0,w:x1-x0+1,h:y1-y0+1,area:q.length});}
 console.log(name,w,h,JSON.stringify(parts));
}})();
