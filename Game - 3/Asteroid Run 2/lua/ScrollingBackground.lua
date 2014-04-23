-------------------------------------------------
--
-- Scrollbackground.lua 
-- 
-------------------------------------------------
local M = {}
-------------------------------------------------
display.setDefault( "textureWrapY", "repeat" )
display.setDefault( "textureWrapX", "repeat" )

local function new( options )
	local width = options.width or display.contentWidth
	local height = options.height or display.contentHeight
	local time = options.time or 30000
	local y = options.y or 0
	local x = options.x or 0
	local scale = options.scale or 1
	
	local filename = options.filename
	
	local paint = {
		type = "image",
		filename = filename,
	}
	local rect = display.newRect( display.contentCenterX, display.contentCenterY, width, height )
	rect.fill = paint
	rect.fill.scaleX = scale
	rect.fill.scaleY = scale
	
	transition.to( rect.fill, { time=time, x=x, y=y, iterations=999 } )
	
	return rect
end 
M.new = new
-------------------------------------------------
return M