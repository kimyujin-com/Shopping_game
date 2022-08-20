-----------------------------------------------------------------------------------------
--
-- home.lua
--
-----------------------------------------------------------------------------------------
--JSON 파싱
local json = require('json')
local Data, pos, msg

local function parse()
	local filename = system.pathForFile("Content/JSON/bookInfo.json")
	Data, pos, msg = json.decodeFile(filename)
	--디버그
	if Data then
		print(Data[1].name)
	else
		print(pos)
		print(msg)
	end
	--
end
parse()
--

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImage("Content/PNG/Home/night.jpg", display.contentWidth/2, display.contentHeight/2)

	local ride = {}
	local ride_name = {}
	local ride_button = {}
	local rideGroup = display.newGroup()

	for i = 1, #Data do 
		ride[i] = display.newImage(rideGroup, Data[i].img)
		ride[i].width = 200
		ride[i].height = 200
		ride[i].x, ride[i].y = display.contentWidth/2 + 500*(i - 1), display.contentHeight/2

		ride_name[i] = display.newText(rideGroup, Data[i].title, ride[i].x, display.contentHeight*0.8)
		ride_name[i].size = 50
		ride_name[i]:setFillColor(1)

		ride_button[i] = display.newImage(rideGroup, "Content/PNG/대중교통/check.png")
		ride_button[i].width = 50
		ride_button[i].height = 50
		ride_button[i].x, ride_button[i].y = display.contentWidth/2 + 500*(i - 1), display.contentHeight*0.9
	end

	local function scroll( event )
		if ( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target ) 
			event.target.isFocus = true

			event.target.xStart = event.target.x

		elseif ( event.phase == "moved" ) then
			if ( event.target.isFocus ) then
				
				event.target.x = event.target.xStart + event.xDelta

			end
		elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
			if ( event.target.isFocus ) then
			display.getCurrentStage():setFocus( nil ) 
			event.target.isFocus = false
			end
			display.getCurrentStage():setFocus( nil ) 
			event.target.isFocus = false
		end
	end

	rideGroup:addEventListener("touch", scroll)

	function button( event )
		composer.gotoScene("view1")
		return true
	end

	for i = 1, 5 do
		ride_button[i]:addEventListener("tap", button)
	end
	
	sceneGroup:insert(background)
	--sceneGroup:insert(station)
	sceneGroup:insert(rideGroup)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
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
		composer.removeScene("home")
		-- Called when the scene is now off screen
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