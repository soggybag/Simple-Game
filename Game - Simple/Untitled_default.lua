local M = {}

local getSheetOptions = function()
	local options = {
		frames = {
		
			{
				x = 0,
				y = 0,
				width = 6,
				height = 6
			},
		
			{
				x = 8,
				y = 0,
				width = 10,
				height = 10
			},
		
			{
				x = 20,
				y = 0,
				width = 16,
				height = 15
			},
		
			{
				x = 38,
				y = 0,
				width = 18,
				height = 17
			},
		
			{
				x = 104,
				y = 0,
				width = 21,
				height = 19
			},
		
			{
				x = 58,
				y = 0,
				width = 21,
				height = 19
			},
		
			{
				x = 127,
				y = 0,
				width = 21,
				height = 19
			},
		
			{
				x = 81,
				y = 0,
				width = 21,
				height = 20
			},
		
			{
				x = 150,
				y = 0,
				width = 22,
				height = 22
			},
		
			{
				x = 174,
				y = 0,
				width = 22,
				height = 22
			},
		
			{
				x = 223,
				y = 0,
				width = 23,
				height = 22
			},
		
			{
				x = 248,
				y = 0,
				width = 23,
				height = 22
			},
		
			{
				x = 198,
				y = 0,
				width = 23,
				height = 24
			},
		
		},
		
		sheetContentWidth = 512,
		sheetContentHeight = 32
	}

	return options
end
M.getSheetOptions = getSheetOptions

return M