--print(display.contentWidth .."x".. display.contentHeight)
local storyboard=require ("storyboard")
local scene=storyboard.newScene()

  _W = display.contentWidth; -- Get the width of the screen
  _H = display.contentHeight; -- Get the height of the screen
    motionx = 0;
    motiony = 0; -- Variable used to move character along x axis
    speed = 2; -- Set Walking Speed

function scene:createScene(event)
local physics = require("physics")
physics.start()
screenGroup =self.view

local fondo = display.newImage("3.jpg")
fondo.y =display.contentHeight/2
fondo.x =display.contentWidth/2
fondo.width= 480
fondo.height= 320
screenGroup:insert(fondo)

local fondo2 = display.newImage("fondo.png")
fondo2.y =display.contentHeight/2
fondo2.x =display.contentWidth/2
fondo2.width= 480
fondo2.height= 320
screenGroup:insert(fondo2)

lime=require("lime.lime")
local mapa=lime.loadMap("campo.tmx")
local physica = lime.buildPhysical(mapa)
local visual=lime.createVisual(mapa)
screenGroup:insert(visual)

physics.addBody(visual ,"static")
visual.collision= onHit
visual:addEventListener("collision", visual)

  local opcionesLeds = {
    width = 60,
    height = 20,
    numFrames = 6
  }
 local hojaLeds = graphics.newImageSheet("ledss.png", opcionesLeds)

 local secuencia = {
    {name = "leds",
     start = 1,
     count = 6,
     time = 2000,
     loopCount = 0,
     loopDirection ="bounce"  --"bounce", --forward
     }
  }

  local spriteLeds = display.newSprite(hojaLeds, secuencia)
  spriteLeds.x = 60
  spriteLeds.y = 25
  spriteLeds:scale(1,0.7)
  spriteLeds:play()
  spriteLeds:setFrame(1)
  screenGroup:insert(spriteLeds)

local piso = display.newImage("piso.jpg")
piso.x=display.contentWidth/2
piso.y =display.contentHeight-32
screenGroup:insert(piso)

physics.addBody(piso ,"static")
piso.collision= onHit
piso:addEventListener("collision", piso)

local paredI = display.newRect(0, 0, 1, display.contentHeight*2)
screenGroup:insert(paredI)
local paredD = display.newRect(display.contentWidth,0,2, display.contentHeight*2)
screenGroup:insert(paredD)
local techo= display.newRect(0,0,display.contentWidth*2, 2)
screenGroup:insert(techo)

physics.addBody(paredI, "static")
physics.addBody(paredD, "static")
physics.addBody(techo, "static")

storyboard.purgeOnSceneChange=true

  ----------------------------samus-----------------------------
local parado = display.newImage("parad.png")
parado.y =display.contentHeight/2+110
parado.x =display.contentWidth/2
--parado.x = math_random(10,_W-10)
screenGroup:insert(parado)

  physics.addBody(parado,"dynamic",{bounce =.1,friction=.1})

-- Add left joystick button
  local  left = display.newImage ("izquierda.png")
    left.x = 30
    left.y = 250
    left:scale(0.7,0.7)
-- Add right joystick button
    local  right = display.newImage ("derecho.png")
    right.x = 115
    right.y = 250
    right:scale(0.6,0.6)
-- Add right joystick button
    local  top = display.newImage ("arriba.png")
    top.x = 75
    top.y = 205
    top:scale(0.6,0.6)
-- Add right joystick button
    local  bottom = display.newImage ("abajo.png")
    bottom.x = 75
    bottom.y = 295
    bottom:scale(0.6,0.6)
-- Add jump joystick button
  local  jump = display.newImage ("A.png")
    jump.x = 430
    jump.y = 250
    jump:scale(0.8,0.8)
-- Add fire joystick button
  local  fire = display.newImage ("B.png")
    fire.x = 350
    fire.y = 270
    fire:scale(0.8,0.8)
-- Add start joystick button
  local  start = display.newImage ("start.png")
    start.x = display.contentWidth/2
    start.y = 290

  --------------------------Metroid-------------------------
 local opcionesMetro = {
    width = 38,
    height = 44,
    numFrames = 14
  }
 local hojaMetro = graphics.newImageSheet("metro.png", opcionesMetro)

 local secuenciaMetro = {
    {name = "metro",
     start = 1,
     count = 14,
     time = 2000,
     loopCount = 0,
     loopDirection = "bounce", --forward
     }
  }

  local spriteMetro = display.newSprite(hojaMetro, secuenciaMetro)
  spriteMetro.x = display.contentWidth/2
  spriteMetro.y = display.contentHeight/2
  spriteMetro:play()
  spriteMetro:setFrame(1)
  --physics.addBody(spriteMetro, {bounce =.1,friction=.1})
  function stop (event)
    if event.phase =="ended" then
      motionx = 0;
      motiony = 0;
    end
  end

  Runtime:addEventListener("touch", stop )

  -- Move character
  function moveguy (event)
    parado.x = parado.x + motionx;
    parado.y= parado.y + motiony;
  end
  Runtime:addEventListener("enterFrame", moveguy)

  -- When left arrow is touched, move character left
  function left:touch()
    motionx = -speed;
  end
  left:addEventListener("touch",left)
  function jump:touch()
    motiony = -5*speed;
  end
  jump:addEventListener("touch", jump)

  function right:touch()
    motionx = speed;
  end
  right:addEventListener("touch",right)

  function start:touch()
    
  end
  start:addEventListener("touch",start)
end

-----------------------------audio------------------------
 local aud = {
    {channel = 1,
     loop = -1,
     }
  }
local backgroundMusic = audio.loadStream("MetroidTheme2.mp3" )
local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )

-----------------------------------------------------------
function restart(event)
  if event.phase=="began" then
    storyboard.gotoScene("restart", "fade", 400)
    end
end


  function scene:enterScene(event)
    Runtime:addEventListener("touch", stop )
    storyboard.removeScene("videos")
end


function scene:exitScene(event)
  Runtime:removeEventListener("touch", touchScreen)
	Runtime:removeEventListener("enterFrame", fondo)
	Runtime:removeEventListener("enterFrame", parado)
	Runtime:removeEventListener("enterFrame", top)
	Runtime:removeEventListener("enterFrame", rigth)
	Runtime:removeEventListener("enterFrame", left)
	Runtime:removeEventListener("enterFrame", bottom)
	Runtime:removeEventListener("enterFrame", jump)
  Runtime:removeEventListener("enterFrame", fire)
  Runtime:removeEventListener("enterFrame", start)
	Runtime:removeEventListener("collision", onCollision)
end

function scene:destroyScene(event)

end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene
