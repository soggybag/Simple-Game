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

local background
local title_1
local title_2
local options
local info
local help
local play

local widget = require( "widget" )

local function tap_options( event )
	storyboard.gotoScene( "options", {effect="slideLeft", time=400} )
end 

local function tap_help( event )
	storyboard.gotoScene( "help", {effect="slideLeft", time=400} )
end 

local function tap_credits( event )
	storyboard.gotoScene( "info", {effect="slideLeft", time=400} )
end 

local function tap_play( event )
	storyboard.gotoScene( "level", {effect="slideLeft", time=400} )
end 



-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	background = display.newImageRect( "images/moon.png", 320, 480 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	
	group:insert( background )
	
	title_1 = display.newImageRect( "images/Title-1.png", 207, 59 )
	group:insert( title_1 )
	
	title_2 = display.newImageRect( "images/Title-2.png", 260, 59 )
	group:insert( title_2 )
	
	options = widget.newButton( {defaultFile="images/options-button.png",
										overFile="images/options-button-over.png",
										width=160,
										height=50,
										onRelease=tap_options} )
										
	group:insert( options )
	options.x = display.contentCenterX
	options.y = 200
	
	
	help = widget.newButton( { defaultFile="images/help-button.png",
									overFile="images/help-button-over.png",
									width=160,
									height=50,
									onRelease=tap_help} )
										
	group:insert( help )
	help.x = display.contentCenterX
	help.y = 260
	
	
	info = widget.newButton( { defaultFile="images/credits-button.png",
										overFile="images/credits-button-over.png",
										width=160,
										height=50,
										onRelease=tap_credits} )
										
	group:insert( info )
	info.x = display.contentCenterX
	info.y = 320
	
	
	play = widget.newButton( {defaultFile="images/play-button.png",
										overFile="images/play-button-over.png",
										width=160,
										height=50,
										onRelease=tap_play} )
										
	group:insert( play )
	play.x = display.contentCenterX
	play.y = 380
end


function scene:willEnterScene( event )
	title_1.x = -110
	title_1.y = 60
	
	title_2.x = display.contentWidth + 140
	title_2.y = 110
	
	options.x = 600
	help.x = 600
	info.x = 600
	play.x = 600
	
	title_1.isVisible = false
	title_2.isVisible = false 
	options.isVisible = false 
	help.isVisible = false
	info.isVisible = false
	play.isVisible = false
end 

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	title_1.isVisible = true
	title_2.isVisible = true 
	options.isVisible = true 
	help.isVisible = true
	info.isVisible = true
	play.isVisible = true
	
	transition.to( title_1, {x=185, time=400, transition=easing.outExpo} )
	transition.to( title_2, {x=160, time=400, transition=easing.outExpo} )
	
	transition.to( options, {x=display.contentCenterX, time=400, delay=1000, transition=easing.outExpo} )
	transition.to( help, {x=display.contentCenterX, time=400, delay=1200, transition=easing.outExpo} )
	transition.to( info, {x=display.contentCenterX, time=400, delay=1400, transition=easing.outExpo} )
	transition.to( play, {x=display.contentCenterX, time=400, delay=1600, transition=easing.outExpo} )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
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

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene