--[[

     Awesome WM configuration template
     github.com/lcpz

--]] -- {{{ Required libraries
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall( require, "luarocks.loader" )

local awful = require( "awful" )
require( "awful.autofocus" )
local beautiful = require( "beautiful" )
local menubar = require( "menubar" )
-- menubar.utils.icon_lookup_path = {
-- 	"/usr/share/pixmaps",
-- 	"/home/adonis/.icons/candy-icons/apps/scalable/",
-- 	"/home/adonis/.icons/candy-icons/devices/scalable/",
-- 	"/home/adonis/.icons/candy-icons/places/scalable/"
--  }

local theme = "tokyo-darker"
beautiful.init( os.getenv( "HOME" ) .. "/.config/awesome/themes/" .. theme .. "/theme.lua" )

local terminal = "kitty"
awful.util.terminal = terminal
menubar.utils.terminal = terminal

-- CONFIG
require( "config.keys" )
require( "config.naughty" )
require( "config.errors" )
require( "config.autostart" )
require( "config.bling" )
require( "config.rules" )
require( "config.signals" )

require( "components.volume-adjust" )

-- LAYOUT
require( "layout" )

collectgarbage( "setpause", 110 )
collectgarbage( "setstepmul", 1000 )
