local awful = require( "awful" )
local wibox = require( "wibox" )
local beautiful = require( "beautiful" )
local bling = require( "bling" )
local rubato = require( "rubato" )

-- Enable Playerctl Module from Bling
-- Playerctl = bling.signal.playerctl.lib()

bling.widget.task_preview.enable {
	placement_fn = function( c )
		awful.placement.top_left(
			c, {
				margins = {
					-- bottom = beautiful.wibar_height + beautiful.useless_gap * 2,
					-- left = beautiful.useless_gap * 2
					top = 20,
					left = 20
				 }
			 }
		 )
	end
 }

-- require( "ui.pop.window_switcher" ).enable()

local naughty = require( "naughty" )
local playerctl = bling.signal.playerctl.lib()
