local beautiful = require( "beautiful" )
local naughty = require( "naughty" )
naughty.config.defaults.margin = 15
naughty.config.defaults.bg = beautiful.bg_normal .. "90"
naughty.config.defaults.border = 1
naughty.config.presets.critical.icon =
	"/home/adonis/.icons/candy-icons/preferences/scalable/help-faq.svg"
naughty.config.presets.normal.icon =
	"/home/adonis/.icons/candy-icons/preferences/scalable/help-faq.svg"
naughty.config.defaults.border_color = beautiful.border_normal

naughty.config.presets.critical.bg = beautiful.bg_normal .. "90"
naughty.config.presets.critical.fg = beautiful.color_yellow
