----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------



-- ------------------------------------------------------------------------------
-- 
-- Some variables to run the program 
-- 
-- ------------------------------------------------------------------------------
local rock_array = {}
local ship_sheet
local rock_sheet
local explosion_sheet 
local ship
local rock_timer
local game_over
local score
local score_text
local target_x
local target_y







-- ------------------------------------------------------------------------------
-- 
-- Functions that run the program
-- 
-- ------------------------------------------------------------------------------


-- This function removes rocks
-- ------------------------------------------------------------------------------
local function remove_rock( rock )
	rock_array[rock] = nil
	display.remove( rock )
end 


-- Called when a rock moves off the bottom of the screen 
-- ------------------------------------------------------------------------------
local function rock_complete( rock ) 
	remove_rock( rock )
	if game_over == false then 
		print( "score points" )
		score = score + 1
		score_text.text = score
	end 
end 


-- Function to make new rocks 
-- ------------------------------------------------------------------------------
local function make_rock()
	local t = math.random( 0, 2000 ) + 500
	local rock = display.newSprite( rock_sheet, {start=1, count=30, time=t} )
	rock:setFrame( math.random( 1, 30 ) )
	rock:play()
	rock.x = math.random( 0, 320 )
	rock.y = -60
	
	scene.view:insert( rock )
	
	rock.xScale = ( math.random() * 0.5 ) + 0.5
	rock.yScale = rock.xScale
	
	rock.transition = transition.to( rock, {y=520, time=4000, onComplete=rock_complete} )
	rock_array[ rock ] = rock
end 


-- Removes explosions 
-- ------------------------------------------------------------------------------
local function remove_explosion( event )
	if event.phase == "ended" then 
		display.remove( event.target )
	end 
end 


-- Makes explosions 
-- -----------------------------------------------------------------------------
local function make_explosion()
	local explosion = display.newSprite( explosion_sheet, {start=1, count=40, loopCount=1} )
	explosion:addEventListener( "sprite", remove_explosion )
	explosion:play()
	return explosion
end 


--------------------------------------------------------------------------------
-- Helper functions
--------------------------------------------------------------------------------

-- Check if two boxes overlap, pass two display objects returns true if they overlap
-- -----------------------------------------------------------------------------
local function hitTestObjects( obj1, obj2 )
        return obj1.contentBounds.xMin < obj2.contentBounds.xMax
			and obj1.contentBounds.xMax > obj2.contentBounds.xMin
			and obj1.contentBounds.yMin < obj2.contentBounds.yMax
			and obj1.contentBounds.yMax > obj2.contentBounds.yMin
end


-- Check for collisions between rocks and ship
--------------------------------------------------------------------------------
local function check_for_collision()
	for k, rock  in pairs( rock_array ) do
		if hitTestObjects( rock, ship ) then 
			local explosion = make_explosion()
			explosion.x = ship.x
			explosion.y = ship.y
			
			ship.isVisible = false
			remove_rock( rock )	
			
			game_over = true
			storyboard.showOverlay( "game_over" )
			storyboard.level_complete( score )
		end 
	end 
end 


-- Function moves ship 
-- ------------------------------------------------------------------------------
local function move_ship()
	ship.x = ship.x - ( ship.x - target_x ) * 0.1
	ship.y = ship.y - ( ship.y - target_y ) * 0.1
end 


-- handles Frame events 
-- ------------------------------------------------------------------------------
local function on_frame( event ) 
	if game_over == false then 
		check_for_collision()
	end 
	move_ship()
end 


-- Handles touch events 
-- -----------------------------------------------------------------------------
local function on_touch( event )
	if event.phase == "began" or event.phase == "moved" then 
		target_x = event.x 
		target_y = event.y
	end 
end 





-- ==============================================================================
-- 
-- Storyboard event handlers 
-- 
-- ==============================================================================



-- Called when the scene's view does not exist:
-- ------------------------------------------------------------------------------
function scene:createScene( event )
	local group = self.view

	ship_sheet = graphics.newImageSheet( "images/ships_1.png", {width=36, height=50, numFrames=5} )
	rock_sheet = graphics.newImageSheet( "images/rocks_1.png", {width=64, height=64, numFrames=30} )
	explosion_sheet = graphics.newImageSheet( "images/explosion_1.png", {width=93, height=100, numFrames=40} )

	ship = display.newSprite( ship_sheet, {start=1, count=5} )
	ship:setFrame( 3 )
	ship.x = 160
	ship.y = 440
	
	target_x = ship.x
	target_y = ship.y

	ship.vx = 0

	score_text = display.newText( "0", 10, 10, native.systemFont, 24 )
	group:insert( score_text )
end


-- Called just before this scene moves into view 
-- ------------------------------------------------------------------------------
function scene:willEnterScene( event )
	ship.isVisible = true
	game_over = false
	score = 0
	score_text.text = 0
end 


-- Called immediately after scene has moved onscreen:
-- ------------------------------------------------------------------------------
function scene:enterScene( event )
	local group = self.view
	
	rock_timer = timer.performWithDelay( 1000, make_rock, 0 )
	Runtime:addEventListener( "enterFrame", on_frame )
	Runtime:addEventListener( "touch", on_touch )
end


-- Called when scene is about to move offscreen:
-- -----------------------------------------------------------------------------
function scene:exitScene( event )
	local group = self.view
	timer.cancel( rock_timer )
	Runtime:removeEventListener( "enterFrame", on_frame )
	Runtime:removeEventListener( "touch", on_touch )
end


-- Called immediately after this scene has moved out of view
-- -----------------------------------------------------------------------------
function scene:didExitScene( event ) 
	for k, rock in pairs( rock_array ) do
		transition.cancel( rock_array[k].transition )
		remove_rock( rock_array[k] )
	end 
end 


-- Called prior to the removal of scene's "view" (display group)
-- -----------------------------------------------------------------------------
function scene:destroyScene( event )
	local group = self.view
	
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "willEnterScene", scene )
scene:addEventListener( "didExitScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene