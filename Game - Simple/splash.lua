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

local more_easing = require( "more_easing" )

local logo

local function on_tap( event ) 
	storyboard.gotoScene( "home", {effect="slideDown", time=400} )
end 


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	logo = display.newImageRect( "images/Logo.png", 187, 226 )	
	logo.x = display.contentCenterX
	logo.y = display.contentCenterY
	group:insert( logo )
	
end


function scene:willEnterScene( event ) 
	local group = self.view
	logo.xScale = 0.01
	logo.yScale = logo.xScale
	logo.rotation = 60
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	transition.to( logo, {xScale=1, yScale=1, time=1000, transition=more_easing.easeOutElastic} )
	transition.to( logo, {rotation=0, time=800, delay=1100, transition=more_easing.easeOutBack} )
	Runtime:addEventListener( "tap", on_tap )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	Runtime:removeEventListener( "tap", on_tap )
end

function scene:didExitScene( event )
	local group = self.view
	
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