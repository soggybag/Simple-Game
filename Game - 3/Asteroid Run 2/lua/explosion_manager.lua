-----------------------------------------------------------------------------------------
-- Explosion Manager 
-----------------------------------------------------------------------------------------
local M = {}
-----------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------
-- Import the physics library. 
-- --------------------------------------------------------------------------------------
local physics = require( "physics" )



-- Load the explosion sprite sheet 
-----------------------------------------------------------------------------------------
local explosion_sheet = graphics.newImageSheet( "images/explosion_1.png", {width=93, height=100, numFrames=40} )
-----------------------------------------------------------------------------------------


--- -------------------------------------------------------------------------------------
-- 
-- Private functions 
-- 
-- --------------------------------------------------------------------------------------


-- Remove explosions 
-- --------------------------------------------------------------------------------------
local function remove_explosion( event )
	if event.phase == "ended" then 
		display.remove( event.target )
	end 
end 



--- -------------------------------------------------------------------------------------
-- 
-- Public functions 
-- 
-- --------------------------------------------------------------------------------------


-- Call this to make an explosion. Returns an explosion sprite that will remove itself 
-- after playing through once. 
-- --------------------------------------------------------------------------------------
local function make_explosion()
	local explosion = display.newSprite( explosion_sheet, {start=1, count=40, loopCount=1} )
	explosion:addEventListener( "sprite", remove_explosion )
	explosion:play()
	return explosion
end 
M.make_explosion = make_explosion
-----------------------------------------------------------------------------------------
return M 