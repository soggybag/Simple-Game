-----------------------------------------------------------------------------------------
-- Ship Manager 
-----------------------------------------------------------------------------------------
local M = display.newGroup()
-----------------------------------------------------------------------------------------
local physics = require( "physics" )
local explosion_manager = require( "lua.explosion_manager" )

local target_x = 160
local target_y = 440
local shield_energy_level = 100

-----------------------------------------------------------------------------------------
local ship_sheet = graphics.newImageSheet( "images/ships_1.png", {width=36, height=50, numFrames=5} )
local ship = display.newSprite( ship_sheet, {start=1, count=5} )

ship:setFrame( 3 )
M.x = 160
M.y = 440

physics.addBody( M, "dynamic", {shape={0, -25,  18, 10,  0, 25,  -18, 10}, isSensor=true} )

ship.isSensor = true
ship.myName = "ship"

M:insert( ship )
-----------------------------------------------------------------------------------------
local shield = display.newCircle( 0, 0, 25 )
shield:setFillColor( 255/255, 255/255, 0/255, 128/255 )
shield.strokeWidth = 1
shield:setStrokeColor( 255, 255, 0 )
shield.x = ship.x
shield.y = ship.y
M:insert( shield )

-----------------------------------------------------------------------------------------
local function hit_ship( event )
	if event.phase == "began" and event.other.can_hit_ship then 
		local explosion = explosion_manager.make_explosion()
		explosion.x = M.x
		explosion.y = M.y
	end 
end 
M:addEventListener( "collision", hit_ship )
-----------------------------------------------------------------------------------------
local function move_ship( x, y )
	target_x = x
	target_y = y
end
-----------------------------------------------------------------------------------------
local function get_missile_origin()
	return {x=M.x, y=M.y-25}
end 
M.get_missile_origin = get_missile_origin
-----------------------------------------------------------------------------------------
local function update( event )
	local x = M.x
	local y = M.y 
	x = x - ( x - target_x ) * 0.1
	y = y - ( y - target_y ) * 0.1
	M.x = x 
	M.y = y
end 
M.update = update
-----------------------------------------------------------------------------------------
local function on_touch( event )
	if event.phase == "began" or event.phase == "moved" then 
		move_ship( event.x, event.y )
	end 
end 

local function init()
	Runtime:addEventListener( "touch", on_touch )
end 
M.init = init
-----------------------------------------------------------------------------------------
local function cleanup()
	Runtime:removeEventListener( "touch", on_touch )
end 
M.cleanup = cleanup
-----------------------------------------------------------------------------------------
return M 









