-----------------------------------------------------------------------------------------
--
-- Enemy Manager 
--
-----------------------------------------------------------------------------------------

-- ======================================================================================
-- 
-- Make a table to hold the properties and methods of this module 
-- 
-- ======================================================================================

local M = {}



-----------------------------------------------------------------------------------------
-- Load code 
-----------------------------------------------------------------------------------------
local physics = require( "physics" )




-----------------------------------------------------------------------------------------
-- 
-- Load sprite sheet 
-- 
-----------------------------------------------------------------------------------------
local rock_sheet = graphics.newImageSheet( "images/rocks_1.png", {width=64, height=64, numFrames=30} )
local rock_array = {}
local enemy_sheet = graphics.newImageSheet( "images/Aliens-All_default.png", require("lua.Aliens-All_default").getSheetOptions() )
-----------------------------------------------------------------------------------------




-- ======================================================================================
-- 
-- Private methods 
-- 
-- ======================================================================================

-- --------------------------------------------------------------------------------------
-- Remove rocks 
-- --------------------------------------------------------------------------------------
local function remove_rock( rock )
	rock_array[rock] = nil
	display.remove( rock )
end 



-- --------------------------------------------------------------------------------------
-- Rock has moved off the bottom of the screen 
-- --------------------------------------------------------------------------------------
local function rock_complete( rock ) 
	remove_rock( rock )
end 



-- ======================================================================================
-- 
-- Public methods 
-- 
-- ======================================================================================

-- --------------------------------------------------------------------------------------
-- make a rock 
-- --------------------------------------------------------------------------------------
local function make_rock()
	local t = math.random( 700, 2000 ) + 200
	local rock = display.newSprite( rock_sheet, {start=1, count=30, time=t} )
	rock:setFrame( math.random( 1, 30 ) )
	rock:play()
	rock.x = math.random( 0, 320 )
	rock.y = math.random( 0, 100 ) - 160
	
	rock.xScale = ( math.random() * 0.5 ) + 0.5
	rock.yScale = rock.xScale
	
	physics.addBody( rock, "kinematic", {radius=20*rock.xScale, isSensor=true} )
	rock.myName = "rock"
	
	rock.missile_fodder = true
	rock.can_hit_ship = true
	
	rock.transition = transition.to( rock, {y=520, time=4000, onComplete=rock_complete} )
	rock_array[ rock ] = rock
	
	function rock:hit()
		remove_rock( self )
	end 
	
	return rock
end 
M.make_rock = make_rock
-----------------------------------------------------------------------------------------



-- --------------------------------------------------------------------------------------
-- Make an enemy 
-- --------------------------------------------------------------------------------------
local function make_enemy()
	local enemy = display.newSprite( enemy_sheet, {start=1, count=26} )
	enemy:setFrame( math.random( 1, 26 ) )
	
	return enemy
end
M.make_enemy = make_enemy
-----------------------------------------------------------------------------------------



-- --------------------------------------------------------------------------------------
-- Make a power up 
-- --------------------------------------------------------------------------------------
local function make_power_up()
	
end 
M.make_power_up = make_power_up
-----------------------------------------------------------------------------------------



-- --------------------------------------------------------------------------------------
-- Make something random 
-- --------------------------------------------------------------------------------------
local function make_random_thing() 
	
end
M.make_random_thing = make_random_thing
-----------------------------------------------------------------------------------------


-- ======================================================================================
-- return the module 
return M