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


local physics = require("physics")


-- ------------------------------------------------------------------------------
-- 
-- Some variables to run the program 
-- 
-- ------------------------------------------------------------------------------
local rock_array = {}

local ship_sheet
local rock_sheet
local explosion_sheet 
local explosion_small_sheet
local explosion_medium_sheet
local alien_sheet
local pick_up_sheet

local ship

local game_on
local score
local score_text
local target_x
local target_y

local missile_timer
local rock_timer
local alien_timer
local pick_up_timer







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
	if game_on == true then 
		score = score + 1
		score_text.text = score
	end 
end 








-- Function to make new rocks 
-- ------------------------------------------------------------------------------
local function make_rock()
	local t = math.random( 0, 2000 ) + 500
	local rock = display.newSprite( rock_sheet, {start=1, count=30, time=t} )
	physics.addBody( rock, "dynamic", {isSensor=true, radius=20} )
	rock:setFrame( math.random( 1, 30 ) )
	rock:play()
	rock.x = math.random( 0, 320 )
	rock.y = -60
	
	rock.canDestroyShip = true
	rock.isRock = true
	
	scene.view:insert( rock )
	
	-- rock.xScale = ( math.random() * 0.5 ) + 0.5
	-- rock.yScale = rock.xScale
	
	rock.transition = transition.to( rock, {y=520, time=4000, onComplete=rock_complete} )
	rock_array[ rock ] = rock
end 







-- make_alien
-- -----------------------------------------------------------------------------
local function make_alien()
	local alien = display.newSprite( alien_sheet, {start=1, count=25} )
	alien:setFrame( math.random(1, 25) )
	physics.addBody( alien, "dynamic", {isSensor} )
	alien.canBeHitByPlayerMissile = true
	alien.x = math.random( 16, display.contentWidth - 16 ) 
	alien.y = -32
	
	alien.canDestroyShip = true
	alien.canBeHitByPlayerMissile = true
	
	transition.to( alien, {y=display.contentHeight+32, time=5000, onComplete=function( alien ) 
		display.remove( alien )
	end } )
end 













-- make_pick_up
---------------------------------------------------------------------------
local function make_pick_up()
	local pickup = display.newSprite( pick_up_sheet, {start=1, count=28} )
	pickup:setFrame( math.random(1, 28) )
	physics.addBody( pickup, "dynamic", {isSensor} )
	pickup.canBeHitByPlayerMissile = true
	pickup.x = math.random( 16, display.contentWidth - 16 ) 
	pickup.y = -32
	
	pickup.shipCanPickUp = true
	pickup.canBeHitByPlayerMissile = true
	
	transition.to( pickup, {y=display.contentHeight+32, time=5000, onComplete=function( pickup ) 
		display.remove( pickup )
	end } )
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
local function make_explosion( size )
	local explosion
	if size == "small" then 
		explosion = display.newSprite( explosion_small_sheet, {start=1, count=13, loopCount=1} )
	elseif size == "medium" then
		explosion = display.newSprite( explosion_medium_sheet, {start=1, count=13, loopCount=1} )
	else 
		explosion = display.newSprite( explosion_sheet, {start=1, count=40, loopCount=1} )
	end 
	
	scene.view:insert( explosion )
	
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
			
		end 
	end 
end 











-- game_over 
-- ------------------------------------------------------------------------------
local function game_over()
	if game_on then 
		game_on = false
		local explosion = make_explosion()
		explosion.x = ship.x
		explosion.y = ship.y
		ship.isVisible = false
		timer.cancel( missile_timer )
		timer.performWithDelay( 1200, function()
			storyboard.showOverlay( "game_over", {effect="fade"} )
		end )
		storyboard.level_complete( score )
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







-- make_missile
-- -----------------------------------------------------------------------------
local function make_missile() 
	local missile = display.newRect( 0, 0, 3, 7 )
	physics.addBody( missile, "kinematic", {isSensor=true} )
	missile.x = ship.x
	missile.y = ship.y - 7
	missile:setFillColor( 1, 0, 0 )
	missile.isMissile = true
	
	transition.to( missile, {y=missile.y - 500, time=1000, onComplete=function(missile)
		display.remove( missile )
	end } )
end 






-- make_ship
-- -----------------------------------------------------------------------------
local function make_ship()
	ship = display.newSprite( ship_sheet, {start=1, count=5} )
	physics.addBody( ship, "dynamic", {isSensor=true, radius=17} )
	
	scene.view:insert( ship )
	
	ship:setFrame( 3 )
	ship.x = 160
	ship.y = 440
	
	target_x = ship.x
	target_y = ship.y

	ship.vx = 0
	ship.isVisible = true
end 









-- on_collision
-- ------------------------------------------------------------------------------
local function on_collision( event ) 
	if event.phase == "began" then
		local obj1 = event.object1
		local obj2 = event.object2
		
		-- Check for collision with ship
		if obj1 == ship and obj2.canDestroyShip then 
			-- ship collided with rock
			print( "rock hit ship" )
			game_over()
		elseif obj2 == ship and obj1.canDestroyShip then 
			-- ship collided with rock
			print( "rock hit ship" )
			game_over()
		elseif obj1.isMissile and obj2.isRock then
			print( "missile hit rock" )
			local explosion = make_explosion( "small" )
			explosion.x = obj1.x
			explosion.y = obj1.y
			display.remove( obj1 )
		elseif obj2.isMissile and obj1.isRock then 
			print( "missile hit rock" )
			local explosion = make_explosion( "small" )
			explosion.x = obj2.x
			explosion.y = obj2.y
			display.remove( obj2 )
		elseif obj1.isMissile and obj2.canBeHitByPlayerMissile then 
			local explosion = make_explosion( "small" )
			explosion.x = obj1.x
			explosion.y = obj1.y
			display.remove( obj1 )
			
			local explosionM = make_explosion( "medium" )
			explosionM.x = obj2.x
			explosionM.y = obj2.y
			display.remove( obj2 )
		elseif obj2.isMissile and obj1.canBeHitByPlayerMissile then 
			local explosion = make_explosion( "small" )
			explosion.x = obj2.x
			explosion.y = obj2.y
			display.remove( obj2 )
			
			local explosionM = make_explosion( "medium" )
			explosionM.x = obj1.x
			explosionM.y = obj1.y
			display.remove( obj1 )
		end 
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
	explosion_small_sheet = graphics.newImageSheet( "images/explosion-small.png", require("explosion-small").getSheetOptions() )
	explosion_medium_sheet = graphics.newImageSheet( "images/explosion-medium.png", require("explosion-medium").getSheetOptions() )
	alien_sheet = graphics.newImageSheet( "images/Alien_32.png", {width=32, height=32, numFrames=25} )
	pick_up_sheet = graphics.newImageSheet( "images/pick-ups.png", require("pick-ups").getSheetOptions() )

	score_text = display.newText( "0", 10, 10, native.systemFont, 24 )
	group:insert( score_text )
end


-- Called just before this scene moves into view 
-- ------------------------------------------------------------------------------
function scene:willEnterScene( event )
	physics.start()
	physics.setGravity( 0, 0 )
	-- physics.setDrawMode( "hybrid" )
	
	make_ship()
	
	game_on = true
	score = 0
	score_text.text = 0
end 


-- Called immediately after scene has moved onscreen:
-- ------------------------------------------------------------------------------
function scene:enterScene( event )
	local group = self.view
	
	Runtime:addEventListener( "enterFrame", on_frame )
	Runtime:addEventListener( "touch", on_touch )
	Runtime:addEventListener( "collision", on_collision )
	
	-- *************************************************************************
	-- These timers add rocks, missiles, and aliens to the scene
	-- *************************************************************************
	rock_timer = timer.performWithDelay( 1000, make_rock, 0 )
	missile_timer = timer.performWithDelay( 400, make_missile, 0 )
	alien_timer = timer.performWithDelay( 5000, make_alien, 0 )
	pick_up_timer = timer.performWithDelay( 7500, make_pick_up, 0 )
	-- *************************************************************************
end


-- Called when scene is about to move offscreen:
-- -----------------------------------------------------------------------------
function scene:exitScene( event )
	local group = self.view
	timer.cancel( rock_timer )
	Runtime:removeEventListener( "enterFrame", on_frame )
	Runtime:removeEventListener( "touch", on_touch )
	Runtime:removeEventListener( "collision", on_collision )
	
	timer.cancel( missile_timer )
end


-- Called immediately after this scene has moved out of view
-- -----------------------------------------------------------------------------
function scene:didExitScene( event ) 
	for k, rock in pairs( rock_array ) do
		transition.cancel( rock_array[k].transition )
		remove_rock( rock_array[k] )
	end 
	
	display.remove( ship )
	
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