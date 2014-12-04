local storyboard=require ("storyboard")
local scene=storyboard.newScene()
local widget=require("widget")

function scene:createScene(event)
  storyboard.purgeOnSceneChange=true
  screenGroup =self.view
  video = native.newVideo( display.contentCenterX/2, display.contentCenterY/2, 480 ,320 )

btnS =widget.newButton{
  label = "Skip..",
  x=60,
  y=300,
  font="Arial",
  fontSize=35
}
screenGroup:insert(btnS)

local function videoListener( event )
if event.errorCode then
    native.showAlert( "Error!", event.errorMessage, { "OK" } )
  end
end
  video:load( "video.mp4", system.DocumentsDirectory )
  video:addEventListener( "video", videoListener )
  video:play()
  screenGroup:insert(video)
end

local function manageTime(event )
    if (event.count<18)then
    print("Tiempo ",event.count)
    event.count=0
  else
    result =timer.pause(fin)
    storyboard.gotoScene("game", "fade", 400)
    storyboard.removeScene("videos")
  end
end

function start(event)
  if event.phase=="began" then
    storyboard.gotoScene("game")
    end
end

function scene:enterScene(event)
   --storyboard.purgeScene("videos")
   --storyboard.removeScene("videos")
   --storyboard.recycleOnSceneChange("videos")
   --video:addEventListener("touch", start)
   btnS: addEventListener("touch", start)
   fin=timer.performWithDelay( 1000, manageTime,0)
   Runtime:addEventListener("timer", manageTime)
end

function scene:exitScene(event)
  video:removeEventListener("touch", start)
  btnS:removeEventListener("touch", start)
end

function scene:destroyScene(event)

end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene
