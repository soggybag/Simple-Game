-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local ScrollingBackground = require( "ScrollingBackground" )
local stars = ScrollingBackground.new( {filename="stars.png", y=-1} )

--[[
display.setDefault( "textureWrapY", "repeat" )

local paint = {
    type = "image",
    filename = "stars.png"
}

local rect = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )

rect.fill = paint

transition.to( rect.fill, { time=40000, y=-1, iterations=999 } )
--]]