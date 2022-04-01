-- local freedesktop = require( "freedesktop" )
-- local hotkeys_popup = require( "awful.hotkeys_popup" )
-- require( "awful.hotkeys_popup.keys" )
-- }}}
-- {{{ Menu
-- Create a launcher widget and a main menu
-- local myawesomemenu = {
-- 	{ "Hotkeys", function() hotkeys_popup.show_help( nil, awful.screen.focused() ) end },
-- 	{ "Manual", string.format( "%s -e man awesome", terminal ) },
-- 	{ "Edit config", string.format( "%s -e %s %s", terminal, editor, awesome.conffile ) },
-- 	{ "Restart", awesome.restart },
-- 	{ "Quit", function() awesome.quit() end }
--  }
-- awful.util.mymainmenu = freedesktop.menu.build {
-- 	before = {
-- 		{ "Awesome", myawesomemenu, beautiful.awesome_icon }
-- 		-- other triads can be put here
-- 	 },
-- 	after = {
-- 		{ "Open terminal", terminal }
-- 		-- other triads can be put here
-- 	 }
--  }
-- Hide the menu when the mouse leaves it
--[[
awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function()
    if not awful.util.mymainmenu.active_child or
       (awful.util.mymainmenu.wibox ~= mouse.current_wibox and
       awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox) then
        awful.util.mymainmenu:hide()
    else
        awful.util.mymainmenu.active_child.wibox:connect_signal("mouse::leave",
        function()
            if awful.util.mymainmenu.wibox ~= mouse.current_wibox then
                awful.util.mymainmenu:hide()
            end
        end)
    end
end)
--]] 
