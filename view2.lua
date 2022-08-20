-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local warning = display.newImage("Content/PNG/money/warning.png", display.contentWidth/2, display.contentHeight/3)
	warning.width = 200
	warning.height = 200

	local result = composer.getVariable("scoreText")
	local ending1 = display.newText("", display.contentWidth/3.7, display.contentHeight/1.7, native.systemFontBold)
	local ending2 = display.newText("", display.contentWidth/1.7, display.contentHeight/1.7, native.systemFontBold)
	ending1.size = 50
	ending2.size = 50

	ending1.text = result
	ending2.text = "원 입니다. 예산을 초과하였습니다."
	
	sceneGroup:insert (warning)
	sceneGroup:insert (ending1)
	sceneGroup:insert (ending2)
end
function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
