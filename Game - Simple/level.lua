----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

--------------------------------------------
-- Initialize level array
--------------------------------------------
local widget = require( "widget" )

local total_levels = 16
local level_array = {}
local current_level = 1


--------------------------------------------
-- set up level chooser thing
for i = 1, total_levels do 
	local level = {}
	level.isLocked = true
	level.stars = 0
	level_array[i] = level
end
level_array[1].isLocked = false
---------------------------------------------


--------------------------------------------
-- Handle taps on level buttons
--------------------------------------------
local function tap_level( event )
	current_level = event.target.level
	storyboard.gotoScene( "play", {effect="slideUp", time=400} )
end 
--------------------------------------------


--------------------------------------------
-- Function to build level buttons
--------------------------------------------
local function make_level_button( level, stars, isLocked )
	local level_group = display.newGroup()
	local level_back = display.newImageRect( "images/Level-Button.png", 71, 69 )
	local level_number = display.newText( level, 0, 0, native.systemFont, 24 )
	
	level_group.level = level
		
	level_number:setTextColor( 0, 0, 0 )
	level_number.x = 0
	level_number.y = -10
		
	level_group:insert( level_back )
	level_group:insert( level_number )
		
	scene.view:insert( level_group )
		
	print( "***** Making stars" )
	for j = 1, stars do 
		print( "Level:", level, "stars:", stars )
		local star = display.newImageRect( "images/Level-Star.png", 21, 20 )
		level_group:insert( star )
		star.x = ( (j-1) * 20 ) + -19
		star.y = 19
	end 
		
	level_group.x = (((level-1) % 4) * 70 ) + 55
	level_group.y = ( math.floor((level-1)/4) * 70 ) + 120
		
	if isLocked then 
		level_group.alpha = 0.5
	else
		level_group:addEventListener( "tap", tap_level )
	end 
	return level_group
end 

local function level_complete( score )
	local n = math.floor( score / current_level )
	
	print( "adjusting level score:", score, "level:", current_level, "stars:", n )
	
	if n > level_array[current_level].stars then 
		if n > 2 then 
			level_array[ current_level ].stars = 3
		elseif n > 1 then 
			level_array[ current_level ].stars = 2
		elseif n > 0 then 
			level_array[ current_level ].stars = 2
		end 
	end 
	if n > 0 then 
		level_array[ current_level + 1 ].isLocked = false
	end
end 
storyboard.level_complete = level_complete


--------------------------------------------
-- Tap back button 
--------------------------------------------
local function tap_back( event )
	storyboard.gotoScene( "home", {effect="slideRight", time=400} )
end 
--------------------------------------------


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local back = widget.newButton( {defaultFile="images/back-button.png",
										overFile="images/back-button-over.png",
										width=160,
										height=50,
										onRelease=tap_back} )
	
	group:insert( back )
	back.x = display.contentCenterX
	back.y = display.contentHeight - 60
	
end


function scene:willEnterScene( event )
	for i = 1, #level_array do 
		level_array[i].button = make_level_button( i, level_array[i].stars, level_array[i].isLocked )
	end 
end 

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
end

function scene:didExitScene( event )
	for i = 1, #level_array do 
		display.remove( level_array[i].button )
		level_array[i].button = nil
	end 
end 


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "willEnterScene", scene )
scene:addEventListener( "didExitScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene