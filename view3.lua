-----------------------------------------------------------------------------------------
--
-- view3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
    local background = display.newImageRect("Content/PNG/receipt/receipt2.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

    local ending = {}
    local endingGroup = display.newGroup()
	local result = composer.getVariable("scoreText")

    local cnt = 0

    ending[1] =  display.newText(endingGroup, "영수증", display.contentWidth/12, display.contentHeight/3, native.systemFontBold)
    ending[1].size = 70
    for i = 2, (6+j) do
        if (i % 2 == 0 and i < 7) then 
            ending[i] = display.newText(endingGroup, "", display.contentWidth/20, display.contentHeight/(2 - 0.2 * cnt), native.systemFontBold)
        elseif (i > 7) then
            ending[i] = display.newText(endingGroup,"", display.contentWidth/7, display.contentHeight/(2 - 0.2 * (cnt - 1)) + (i - 7) * 30, native.systemFontBold)
        else
            ending[i] = display.newText(endingGroup,"", display.contentWidth/7, display.contentHeight/(2 - 0.2 * cnt), native.systemFontBold)
            cnt = cnt + 1
        end
        ending[i].size = 25
        ending[i]:setFillColor(0)
    end
    
    ending[2].text = "구매금액: "
    ending[3].text = result.."원"
    ending[4].text = "구매수량: "
    ending[5].text = (composer.getVariable("count") - 1).."개"
    ending[6].text = "구매목록: "
    for i = 1, j do 
        ending[6 + i].text = list[i]
    end

    local back = display.newImage("Content/PNG/mart/return.png")
	back.width = 70
	back.height = 70
	back.x, back.y = 30, display.contentHeight/15
	
    local ment = display.newText("구매창으로 돌아가기", back.x + 125, back.y)
    ment.size = 25
    ment:setFillColor(1)

    function back:tap( event )
		composer.gotoScene("view1")
		return true
	end
	back:addEventListener( "tap", back )

    sceneGroup:insert(background)
    sceneGroup:insert(back)
    sceneGroup:insert(endingGroup)
    sceneGroup:insert(ment)
end
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
		composer.removeScene("view3")
	end
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
