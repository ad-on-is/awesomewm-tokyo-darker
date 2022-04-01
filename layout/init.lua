local awful = require( "awful" )
local bling = require( "bling" )
local lain = require( "lain" )
local beautiful = require( "beautiful" )
-- local leaved = require( "awesome-leaved" )
require( "layout.bar" )

awful.util.tagnames = { "   ", "   ", "   " }
awful.layout.layouts = {

	awful.layout.suit.spiral.dwindle,
	bling.layout.mstab, -- bling.layout.vertical,
	awful.layout.suit.tile.bottom,
	lain.layout.termfair,
	lain.layout.termfair.center,
	-- bling.layout.centered,
	bling.layout.deck -- awful.layout.suit.tile
	-- bling.layout.horizontal,
	-- bling.layout.equalarea,
	-- awful.layout.suit.floating,
	-- leaved.layout.suit.tile.right,
	-- leaved.layout.suit.tile.left,
	-- leaved.layout.suit.tile.bottom,
	-- leaved.layout.suit.tile.top,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,

	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
	-- lain.layout.cascade,
	-- lain.layout.cascade.tile,
	-- lain.layout.centerwork,
	-- lain.layout.centerwork.horizontal,

 }

-- lain.layout.termfair.nmaster           = 3
-- lain.layout.termfair.ncol              = 1
-- lain.layout.termfair.center.nmaster    = 3
-- lain.layout.termfair.center.ncol       = 1
-- lain.layout.cascade.tile.offset_x      = 2
-- lain.layout.cascade.tile.offset_y      = 32
-- lain.layout.cascade.tile.extra_padding = 5
-- lain.layout.cascade.tile.nmaster       = 5
-- lain.layout.cascade.tile.ncol          = 2

awful.screen.connect_for_each_screen( function( s ) beautiful.top_bar( s ) end )

