----------------------------------------------------------------------------------
--
-- help.lua
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

local widget = require( "widget" )
local scroll
local background

local function tap_back( event )
	storyboard.gotoScene( "home", {effect="slideRight", time=400} )
end 

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	
	scroll = widget.newScrollView( {top=0, width=320, height=480, scrollWidth=320, scrollHeight=830, hideBackground=true} )
	group:insert( scroll )
	
	background = display.newImageRect( "images/Help.png", 320, 830 )
	background.x = 160
	background.y = 415
	scroll:insert( background )
	

	local back = widget.newButton( {defaultFile="images/back-button.png",
										overFile="images/back-button-over.png",
										width=160,
										height=50,
										onRelease=tap_back} )
	
	group:insert( back )
	back.x = display.contentCenterX
	back.y = display.contentHeight - 60
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene