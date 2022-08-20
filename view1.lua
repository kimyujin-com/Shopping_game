-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImage("Content/PNG/home/grocery2.jpg", display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)

	local shelf = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth/2, display.contentHeight/2.5)
 	shelf:setFillColor(0, 0, 0, 0.0)

	local lines = {}
	local linesGroup = display.newGroup()
	for i = 1, 5 do
		lines[i] = display.newRect(linesGroup, shelf.x + 110 * (i - 3), shelf.y, 100, 100)
		lines[i]:setFillColor(1)
	end

	local som = display.newImage("Content/PNG/솜솜이/먹는솜솜2.jpg")
	som.width = 250
	som.height = 200
	som.x, som.y = display.contentWidth*0.13, display.contentHeight*0.5


	local receipt = display.newImage( "Content/PNG/mart/receipt.png" )
	receipt.width = 100
	receipt.height = 100
	receipt.x, receipt.y = shelf.x - 500, shelf.y - 250

	local ment = display.newText("영수증을 눌러 구매 내역을 확인하세요.", shelf.x - 400, shelf.y - 320, native.systemFontBold)
	ment.text = ("영수증을 눌러 구매 내역을 확인하세요.")
	ment.size = 30
	ment:setFillColor(1)

	function receipt:tap( event )
		composer.gotoScene("view3")
		return true
	end
	receipt:addEventListener( "tap", receipt )

	local food = {}
	local foodGroup = display.newGroup()
	local money = {}
	local moneyGroup = display.newGroup()

	food[1] = display.newImage(foodGroup, "Content/PNG/food/2427885_beef_food_meat_protein_steak_icon.png")
	food[1].id = "beef"
	food[2] = display.newImage(foodGroup, "Content/PNG/food/2427849_breakfast_egg_eggs_food_fried egg_icon.png")
	food[2].id = "egg"
	food[3] = display.newImage(foodGroup, "Content/PNG/food/2427864_bird_chicken_drumstick_meat_turkey leg_icon.png")
	food[3].id = "chicken"
	food[4] = display.newImage(foodGroup, "Content/PNG/food/2427860_baguette_bread_bread loaf_food_toast_icon.png")
	food[4].id = "bread"
	food[5] = display.newImage(foodGroup, "Content/PNG/food/2693201_drink_glass_glass of_milk_icon.png")
	food[5].id = "milk"

	for i = 1, 5 do
			food[i].width = 100
			food[i].height = 70
			food[i].x, food[i].y = shelf.x + 110 * (i - 3), shelf.y
			if (i % 2 == 0) then
				money[i] = display.newImage(moneyGroup, "Content/PNG/money/다운로드 (1).jpg")
			else
				money[i] = display.newImage(moneyGroup, "Content/PNG/money/다운로드.jpg")
			end
			money[i].width = 100
			money[i].height = 40
			money[i].x, money[i].y = shelf.x + 110 * (i - 3), shelf.y + 100
	end
	
	local cart = display.newImageRect("Content/PNG/mart/cart.png", 150*1.2, 200*1.2)
	cart.x, cart.y = display.contentWidth*0.13, display.contentHeight*0.83
	cart.width = 250
	cart.height = 250

	local score = 0
	local showScore = display.newText(score, display.contentWidth*0.2, display.contentHeight*0.2)
	showScore:setFillColor(1)
	showScore.size = 100

	list= {}
	j = 1
	local function cartch( event )
		if ( event.phase == "began" ) then
			print(event.target.id .. " 드래그!")
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
		elseif ( event.phase == "moved" ) then

			if ( event.target.isFocus ) then
				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end
		elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
			if ( event.target.isFocus ) then

				if event.target.x < cart.x + 100 and event.target.x > cart.x - 100 
				and event.target.y < cart.y + 100 and event.target.y > cart.y - 100 then

					list[j] = event.target.id
					j = j + 1
					--display.remove(event.target)
					if (event.target.id == 'egg' or event.target.id == 'bread') then
						score = score + 5000
					else
						score = score + 1000
					end
					showScore.text = score
					composer.setVariable("scoreText", score)
					composer.setVariable("count", j)
					
					if score >= 10000 then
						composer.setVariable("complete", true)
						composer.gotoScene("view2")
					end
				else
					event.target.x = event.xStart
					event.target.y = event.ystart
				end
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
		end
	end
		for i=1,5 do
			food[i]:addEventListener("touch",cartch)
		end
	--레이어 정리--
	sceneGroup:insert(background)
	sceneGroup:insert (shelf)
	sceneGroup:insert (ment)
	sceneGroup:insert(cart)
	sceneGroup:insert(receipt)
	sceneGroup:insert(linesGroup)
	sceneGroup:insert(foodGroup)
	sceneGroup:insert(moneyGroup)
	sceneGroup:insert(som)
	sceneGroup:insert(showScore)
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
		-- Called when the scene is now off screen
		composer.removeScene("view1")
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