-----------------------------------------------------------------------------------------
-- 
-- Missile Manager
-- 
-----------------------------------------------------------------------------------------
local M = {}
-----------------------------------------------------------------------------------------


--- -------------------------------------------------------------------------------------
-- 
-- load libraries 
-- 
-- --------------------------------------------------------------------------------------
local physics = require( "physics" )
local ship_manager = require( "lua.ship_manager" )
local explosion_manager = require( "lua.explosion_manager" )
-----------------------------------------------------------------------------------------



--- -------------------------------------------------------------------------------------
-- 
-- Define variables  
-- 
-- --------------------------------------------------------------------------------------
local missile_array = {}
local display_group
local ticks = 0




--- -------------------------------------------------------------------------------------
-- 
-- Private functions 
-- 
-- --------------------------------------------------------------------------------------


-- Removes missile 
-----------------------------------------------------------------------------------------
local function remove_missile( missile )
	missile_array[missile] = nil
	display.remove( missile )
end 



--- -------------------------------------------------------------------------------------
-- 
-- Public functions 
-- 
-- --------------------------------------------------------------------------------------


-- Make missile. Returns a new missile object 
-----------------------------------------------------------------------------------------
local function make_missile()
	local missile = display.newRect( 0, 0, 1, 5 )
	display_group:insert( missile )
	
	local point = ship_manager.get_missile_origin()
	
	missile.x = point.x
	missile.y = point.y
	
	missile.yReference = -2
	missile.myName = "missile"
	
	missile.transition = transition.to( missile, {y= -5, time=500, onComplete=remove_missile} )
	missile_array[missile] = missile
	
	physics.addBody( missile, "dynamic", {isSensor=true})
	missile.isBullet = true
	
	local function hit( event )
		if event.phase == "began" and event.other.missile_fodder then 
			local explosion = explosion_manager.make_explosion()
			explosion.x = event.other.x
			explosion.y = event.other.y
			event.other:hit()
			remove_missile( missile )
		end 
	end 
	missile:addEventListener( "collision", hit ) 
	 	
	return missile
end 
M.make_missile = make_missile 



-- Initializes this module. You MUST pass the display group where the missiles 
-- should appear! 
-----------------------------------------------------------------------------------------
local function init( group )
	display_group = group
end 
M.init = init



-- Call this each frame to update the position of the missiles. 
-----------------------------------------------------------------------------------------
local function update()
	ticks = ticks + 1
	if ticks > 10 then 
		make_missile()
		ticks = 0
	end 
end 
M.update = update


-----------------------------------------------------------------------------------------
return M




