local M = {}

local getSheetOptions = function()
	local options = {
		frames = {
		
			{
				x = 0,
				y = 0,
				width = 3,
				height = 3
			},
		
			{
				x = 5,
				y = 0,
				width = 5,
				height = 5
			},
		
			{
				x = 12,
				y = 0,
				width = 8,
				height = 8
			},
		
			{
				x = 22,
				y = 0,
				width = 8,
				height = 8
			},
		
			{
				x = 0,
				y = 13,
				width = 11,
				height = 10
			},
		
			{
				x = 13,
				y = 13,
				width = 11,
				height = 10
			},
		
			{
				x = 32,
				y = 0,
				width = 10,
				height = 10
			},
		
			{
				x = 26,
				y = 13,
				width = 11,
				height = 10
			},
		
			{
				x = 39,
				y = 13,
				width = 11,
				height = 11
			},
		
			{
				x = 44,
				y = 0,
				width = 11,
				height = 11
			},
		
			{
				x = 14,
				y = 27,
				width = 12,
				height = 11
			},
		
			{
				x = 0,
				y = 27,
				width = 12,
				height = 11
			},
		
			{
				x = 52,
				y = 13,
				width = 12,
				height = 12
			},
		
		},
		
		sheetContentWidth = 64,
		sheetContentHeight = 64
	}

	return options
end
M.getSheetOptions = getSheetOptions

return M