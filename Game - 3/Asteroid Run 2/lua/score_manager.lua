-----------------------------------------------------------------------------------------
-- 
-- Score Manager
-- 
-----------------------------------------------------------------------------------------
local M = display.newGroup()
-----------------------------------------------------------------------------------------



--- -------------------------------------------------------------------------------------
-- 
-- Define some Variables 
-- 
-- --------------------------------------------------------------------------------------
local score = 0



--- -------------------------------------------------------------------------------------
-- 
-- Make some display 
-- 
-- --------------------------------------------------------------------------------------
local back = display.newRoundedRect( 0, 0, 100, 30, 10 )
back.anchorX = 0
back.anchorY = 0

M:insert( back )

local score_text = display.newText( "0", 0, 0, native.systemFont, 24 )
M:insert( score_text )
-----------------------------------------------------------------------------------------
local function set_back_color( r, g, b, a )
	back:setFillColor( r, g, b, a )
end 
M.set_back_color = set_back_color 
-----------------------------------------------------------------------------------------
local function set_score_color( r, g, b, a )
	score_text:setFillColor( r, g, b, a )
end 
M.set_score_color = set_score_color
-----------------------------------------------------------------------------------------
local function update( n )
	score = score + n
	score_text.text = score 
	score_text.anchorX = 1
	score_text.anchorY = 0
	score_text.x = 95
	score_text.y = -1
end 
M.update = update
-----------------------------------------------------------------------------------------
local function reset()
	score = 0
	update( 0 )
end 
M.reset = reset
-----------------------------------------------------------------------------------------
set_back_color( 0/255, 255/255, 0/255, 128/255 )
set_score_color( 0/255, 255/255, 0/255, 255/255 )
reset()
-----------------------------------------------------------------------------------------
return M