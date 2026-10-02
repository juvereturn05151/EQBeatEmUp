-- Run with Aseprite -b --script Tools/ThaiBadBoy/export.lua
local root = 'E:/EQBeatEmUp/EQBeatEmUp/Assets/ArtAssets/Characters/NPCs/ThaiBadBoy/'
local colors = {'101014','17161a','201e22','29262a','332e31','3f383a','4c4344','5c5050','70605d','85726a','a18d7e','beb09c','ded5c0','f4efdf','181c24','222935','323a45','47515b','687079','949a9c','c5c8c4','ecece1','241914','35221b','4b2d21','603727','77442e','8e5034','a7603d','be754b','d48a59','e59e68','f0b580','f8c998','ffdcad','3c332b','524538','6c5a46','887257','a58b69','c7ab7f','e5cb9a','fff0bf','30332f','43483e','5b6250','737a64','939883'}
local pal = {}
for _,hex in ipairs(colors) do pal[#pal+1]={tonumber(hex:sub(1,2),16),tonumber(hex:sub(3,4),16),tonumber(hex:sub(5,6),16)} end
local configs = {
 {name='Idle',file='Idle.png',scale=106/480,frames={{89,34,236,479},{480,29,229,484},{849,41,243,472},{1246,42,229,471},{84,539,241,468},{469,538,254,469},{849,540,244,467},{1245,546,236,461}},duration={140,140,140,140,140,140,140,140}},
 {name='Walk',file='Walk.png',scale=106/470,frames={{42,24,300,467},{455,27,241,464},{855,27,192,464},{1214,27,279,464},{36,523,320,473},{445,524,271,474},{855,523,250,475},{1232,524,270,474}},duration={100,90,100,90,100,90,100,90},anchors={198,594,980,1370,200,593,981,1370}},
 {name='Attack1',file='Attack1.png',scale=106/446,frames={{56,38,279,446},{422,38,293,446},{786,43,383,441},{1209,43,284,441},{44,541,287,437},{411,544,423,434},{790,558,338,420},{1215,539,281,439}},duration={90,110,60,90,130,70,100,140},anchors={195,570,955,1350,188,580,960,1355}},
 {name='Hurt',file='Hurt.png',scale=106/612,frames={{100,68,395,612},{610,122,427,555},{1195,163,351,516},{1749,75,333,604}},duration={60,100,110,130}},
 {name='Knockdown',file='Knockdown.png',scale=106/477,frames={{79,80,325,477},{498,102,375,456},{921,240,590,273},{22,745,463,202},{499,761,513,183},{1024,822,497,119}},duration={80,100,100,90,150,800}}
}
local cache={}
local function pixel(p)
 if app.pixelColor.rgbaA(p)<128 then return 0 end
 if cache[p] then return cache[p] end
 local r,g,b=app.pixelColor.rgbaR(p),app.pixelColor.rgbaG(p),app.pixelColor.rgbaB(p)
 local best,dist=1,1e9
 for i,c in ipairs(pal) do local d=(r-c[1])^2+(g-c[2])^2+(b-c[3])^2;if d<dist then best,dist=i,d end end
 local c=pal[best];local out=app.pixelColor.rgba(c[1],c[2],c[3],255);cache[p]=out;return out
end
for _,cfg in ipairs(configs) do
 local source=app.open(root..'Source/'..cfg.file)
 local src=source.cels[1].image
 local sprite=Sprite(160,128,ColorMode.RGB)
 sprite.layers[1].name='Character'
 local palette=Palette(#pal+1);palette:setColor(0,Color{r=0,g=0,b=0,a=0})
 for i,c in ipairs(pal) do palette:setColor(i,Color{r=c[1],g=c[2],b=c[3],a=255}) end
 sprite:setPalette(palette)
 for f,box in ipairs(cfg.frames) do
  if f>1 then sprite:newEmptyFrame() end
  sprite.frames[f].duration=cfg.duration[f]/1000
  local im=Image(160,128,ColorMode.RGB)
  -- Isolate the main connected silhouette, excluding neighboring poses
  -- whose hands or shoes intrude into this pose's bounding rectangle.
  local seen,best={},{}
  for yy=0,box[4]-1 do for xx=0,box[3]-1 do
   local key=yy*box[3]+xx
   if not seen[key] and app.pixelColor.rgbaA(src:getPixel(box[1]+xx,box[2]+yy))>=128 then
    local q={key};seen[key]=true;local k=1
    while k<=#q do
     local p=q[k];k=k+1;local px=p%box[3];local py=math.floor(p/box[3])
     local neighbors={}
     if px>0 then neighbors[#neighbors+1]=p-1 end
     if px<box[3]-1 then neighbors[#neighbors+1]=p+1 end
     if py>0 then neighbors[#neighbors+1]=p-box[3] end
     if py<box[4]-1 then neighbors[#neighbors+1]=p+box[3] end
     for _,n in ipairs(neighbors) do
      if not seen[n] and app.pixelColor.rgbaA(src:getPixel(box[1]+n%box[3],box[2]+math.floor(n/box[3])))>=128 then seen[n]=true;q[#q+1]=n end
     end
    end
    if #q>#best then best=q end
   end
  end end
  local mask={};for _,p in ipairs(best) do mask[p]=true end
  local anchor=cfg.anchors and cfg.anchors[f] or box[1]+box[3]/2
  -- Foot-level ground anchor is fixed; airborne knockdown is lifted 10 px.
  local bottom=119
  if cfg.name=='Knockdown' and f==3 then bottom=109 end
  for y=0,127 do for x=0,159 do
   local sx=math.floor(anchor+(x-80)/cfg.scale)
   local sy=math.floor(box[2]+box[4]-1+(y-bottom)/cfg.scale)
   if sx>=box[1] and sx<box[1]+box[3] and sy>=box[2] and sy<box[2]+box[4] and mask[(sy-box[2])*box[3]+sx-box[1]] then im:putPixel(x,y,pixel(src:getPixel(sx,sy))) end
  end end
  sprite:newCel(sprite.layers[1],sprite.frames[f],im,Point(0,0))
  im:saveAs(root..'Animations/'..cfg.name..'/ThaiBadBoy_'..cfg.name..'_'..string.format('%02d',f)..'.png')
 end
 local tag=sprite:newTag(1,#cfg.frames);tag.name=cfg.name
 sprite:saveAs(root..'Animations/'..cfg.name..'/ThaiBadBoy_'..cfg.name..'.aseprite')
 sprite:saveCopyAs(root..'Animations/'..cfg.name..'/ThaiBadBoy_'..cfg.name..'_Preview.gif')
 app.command.ExportSpriteSheet{ui=false,type=SpriteSheetType.ROWS,columns=4,textureFilename=root..'Animations/'..cfg.name..'/ThaiBadBoy_'..cfg.name..'_Sheet.png',dataFilename=root..'Animations/'..cfg.name..'/ThaiBadBoy_'..cfg.name..'_Sheet.json',dataFormat=SpriteSheetDataFormat.JSON_ARRAY,listTags=true}
 print(cfg.name..': '..#cfg.frames..' frames exported')
 sprite:close();source:close()
end
