local M = {}

local getSheetOptions = function()
	local options = {
		frames = {
		
			{
				x = 0,
				y = 102,
				width = 32,
				height = 26
			},
		
			{
				x = 0,
				y = 68,
				width = 32,
				height = 32
			},
		
			{
				x = 68,
				y = 34,
				width = 32,
				height = 30
			},
		
			{
				x = 68,
				y = 66,
				width = 32,
				height = 30
			},
		
			{
				x = 166,
				y = 0,
				width = 28,
				height = 32
			},
		
			{
				x = 34,
				y = 102,
				width = 26,
				height = 26
			},
		
			{
				x = 34,
				y = 34,
				width = 32,
				height = 32
			},
		
			{
				x = 34,
				y = 0,
				width = 32,
				height = 32
			},
		
			{
				x = 228,
				y = 0,
				width = 22,
				height = 32
			},
		
			{
				x = 0,
				y = 34,
				width = 32,
				height = 32
			},
		
			{
				x = 34,
				y = 68,
				width = 32,
				height = 32
			},
		
			{
				x = 0,
				y = 0,
				width = 32,
				height = 32
			},
		
			{
				x = 68,
				y = 0,
				width = 32,
				height = 32
			},
		
			{
				x = 166,
				y = 64,
				width = 30,
				height = 30
			},
		
			{
				x = 102,
				y = 0,
				width = 30,
				height = 30
			},
		
			{
				x = 134,
				y = 64,
				width = 30,
				height = 30
			},
		
			{
				x = 198,
				y = 64,
				width = 30,
				height = 30
			},
		
			{
				x = 196,
				y = 32,
				width = 30,
				height = 30
			},
		
			{
				x = 134,
				y = 0,
				width = 30,
				height = 30
			},
		
			{
				x = 102,
				y = 32,
				width = 30,
				height = 30
			},
		
			{
				x = 102,
				y = 64,
				width = 30,
				height = 30
			},
		
			{
				x = 196,
				y = 0,
				width = 30,
				height = 30
			},
		
			{
				x = 100,
				y = 98,
				width = 30,
				height = 30
			},
		
			{
				x = 134,
				y = 32,
				width = 30,
				height = 30
			},
		
			{
				x = 68,
				y = 98,
				width = 30,
				height = 30
			},
		
			{
				x = 132,
				y = 96,
				width = 30,
				height = 30
			},
		
			{
				x = 164,
				y = 96,
				width = 30,
				height = 30
			},
		
			{
				x = 196,
				y = 96,
				width = 30,
				height = 30
			},
		
		},
		
		sheetContentWidth = 256,
		sheetContentHeight = 128
	}

	return options
end
M.getSheetOptions = getSheetOptions

return M