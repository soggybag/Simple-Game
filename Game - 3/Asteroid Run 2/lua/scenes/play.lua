----------------------------------------------------------------------------------
--
-- play.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-----------------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------







-- ======================================================================================
-- 
-- Import some code 
-- 
-- ======================================================================================

local physics = require( "physics" )
physics.start()
physics.pause()

local enemy_manager 		= require( "lua.enemy_manager" )
local ship_manager 			= require( "lua.ship_manager" )
local score_manager 		= require( "lua.score_manager" )
local missile_manager 		= require( "lua.missile_manager" )
local ScrollingBackground 	= require( "lua.ScrollingBackground" )

-----------------------------------------------------------------------------------------







-- ======================================================================================
-- 
-- Define some variables 
-- 
-- ======================================================================================

local score_group
local ship_group
local enemy_group
local stars_fore
local stars_back

local enemy_timer

-----------------------------------------------------------------------------------------







-- ======================================================================================
-- 
-- Define some functions 
-- 
-- ======================================================================================



-----------------------------------------------------------------------------------------
-- Makes a rock 
-----------------------------------------------------------------------------------------

local function make_rock()
	local rock = enemy_manager.make_rock() -- Makes a rock using enemy_manager.lua
	enemy_group:insert( rock )
end 

-----------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------
-- Handle touch events 
-----------------------------------------------------------------------------------------

local function on_touch( event ) 
	
end 

-----------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------
-- Handle frame events 
-----------------------------------------------------------------------------------------

local function on_frame( event )
	ship_manager.update()
	missile_manager.update()
end

-----------------------------------------------------------------------------------------






-- ======================================================================================
-- 
-- Storyboard handlers 
-- 
-- ======================================================================================


-----------------------------------------------------------------------------------------
-- 
-- Create scene
--  
-----------------------------------------------------------------------------------------
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	-- Start and stop physics 
	physics.start()
	physics.pause()
	-- Set options for storyboard 
	-- physics.setDrawMode( "hybrid" )
	physics.setGravity( 0, 0 )
	
	----------------------------------
	-- Create the background stars, in two layers
	
	stars_back = ScrollingBackground.new( {filename="images/stars.png", y=1, time=60000, scale=-0.5} )
	group:insert( stars_back )
	
	stars_fore = ScrollingBackground.new( {filename="images/stars.png", y=-1} )
	group:insert( stars_fore )
	
	
	-----------------------------------
	-- Create group to hold ship
	
	ship_group = display.newGroup()
	ship_group:insert( ship_manager )
	group:insert( ship_group )
	-----------------------------------
	
	-----------------------------------
	-- Create a group for enemies 
	
	enemy_group = display.newGroup()
	group:insert( enemy_group )
	-----------------------------------
		
	-----------------------------------
	-- Create group to hold score
	
	score_group = display.newGroup()
	score_group:insert( score_manager )
	group:insert( score_group )
	score_manager.x = 210
	score_manager.y = 10
	-----------------------------------
	
	missile_manager.init( group )
end




-- ------------------------------------------------------------------------
-- 
-- Will Enter Scene - event occurs just before the scene moves into view. 
--
---------------------------------------------------------------------------

function scene:willEnterScene( event )
	
end 

-- --------------------------------------



---------------------------------------------------------------------------
-- 
-- Called immediately after scene has moved onscreen:
--
---------------------------------------------------------------------------

function scene:enterScene( event )
	local group = self.view
	
	enemy_timer = timer.performWithDelay( 1000, make_rock, 0 )
	ship_manager.init()
	physics.start()
	Runtime:addEventListener( "touch", on_touch )
	Runtime:addEventListener( "enterFrame", on_frame )
end

-------------------------------------------------------------------------


-- ----------------------------------------------------------------------
-- 
-- Called when scene is about to move offscreen:
-- 
-- ----------------------------------------------------------------------

function scene:exitScene( event )
	local group = self.view
	
	timer.cancel( enemy_timer )
	ship_manager.cleanup()
	physics.pause()
	Runtime:addEventListener( "touch", on_touch )
end

------------------------------------------------------------------------




------------------------------------------------------------------------
-- 
-- Did Exit Scene 
--
------------------------------------------------------------------------

function scene:didExitScene( event ) 
	
end 



------------------------------------------------------------------------
--
-- Called prior to the removal of scene's "view" (display group)
--
------------------------------------------------------------------------

function scene:destroyScene( event )
	local group = self.view
	
end

-------------------------------------------------------------------------






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