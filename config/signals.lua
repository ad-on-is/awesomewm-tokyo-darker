local awful = require( "awful" )
local wibox = require( "wibox" )
local beautiful = require( "beautiful" )
local menubar = require( "menubar" )
local gears = require( "gears" )

-- Signal function to execute when a new client appears.
client.connect_signal(
	"manage", function( c )

		if c.instance ~= nil then
			local icon = menubar.utils.lookup_icon( c.instance )
			local lower_icon = menubar.utils.lookup_icon( c.instance:lower() )
			if icon ~= nil then
				local new_icon = gears.surface( icon )
				c.icon = new_icon._native
			elseif lower_icon ~= nil then
				local new_icon = gears.surface( lower_icon )
				c.icon = new_icon._native
			elseif c.icon == nil then
				local new_icon = gears.surface( menubar.utils.lookup_icon( "application-default-icon" ) )
				c.icon = new_icon._native
			end
		else
			local new_icon = gears.surface( menubar.utils.lookup_icon( "application-default-icon" ) )
			c.icon = new_icon._native
		end

		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		if not awesome.startup then awful.client.setslave( c ) end

		if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
			-- Prevent clients from being unreachable after screen count changes.
			awful.placement.no_offscreen( c )
		end

		if client.floating and context == "new" then
			client.placement = awful.placement.centered + awful.placement.no_overlap
		end

	end
 )

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
	"request::titlebars", function( c )
		-- Custom
		if beautiful.titlebar_fun then
			beautiful.titlebar_fun( c )
			return
		end

		-- Default
		-- buttons for the titlebar

		awful.titlebar( c, { size = 20, bg_normal = beautiful.bg_normal, beautiful.bg_focus } ):setup{
			{ -- Left
				wibox.container.margin( awful.titlebar.widget.iconwidget( c ), 5, 2, 2, 2 ),
				buttons = awful.util.titlebar_buttons,
				layout = wibox.layout.fixed.horizontal
			 },
			{ -- Middle
				{ -- Title
					align = "center",
					widget = awful.titlebar.widget.titlewidget( c )
				 },
				buttons = awful.util.titlebar_buttons,
				layout = wibox.layout.flex.horizontal
			 },
			{ -- Right
				-- awful.titlebar.widget.floatingbutton( c ),
				-- awful.titlebar.widget.maximizedbutton( c ),
				-- awful.titlebar.widget.stickybutton( c ),
				-- awful.titlebar.widget.ontopbutton( c ),
				-- awful.titlebar.widget.closebutton( c ),
				layout = wibox.layout.fixed.horizontal()
			 },
			layout = wibox.layout.align.horizontal
		 }
	end
 )

client.connect_signal( "manage", function( c ) c.shape = gears.shape.rounded_rect end )

-- require( "components.volume-adjust" )

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal( "mouse::enter", function( c ) c:emit_signal( "request::activate", "mouse_enter", { raise = false } ) end )

client.connect_signal( "focus", function( c ) c.border_color = beautiful.border_focus end )
client.connect_signal( "unfocus", function( c ) c.border_color = beautiful.border_normal end )

-- {{{ Screen

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal(
-- 	"property::geometry", function( s )
-- 		-- Wallpaper
-- 		-- if beautiful.wallpaper then
-- 		-- 	local wallpaper = beautiful.wallpaper
-- 		-- 	-- If wallpaper is a function, call it with the screen
-- 		-- 	if type( wallpaper ) == "function" then wallpaper = wallpaper( s ) end
-- 		-- 	gears.wallpaper.maximized( wallpaper, s, true )
-- 		-- end
-- 	end
--  )

-- No borders when rearranging only 1 non-floating or maximized client
-- screen.connect_signal(
-- 	"arrange", function( s )
-- 		-- local only_one = #s.tiled_clients == 1
-- 		-- for _, c in pairs( s.clients ) do
-- 		-- 	if only_one and not c.floating or c.maximized or c.fullscreen then
-- 		-- 		c.border_width = 0
-- 		-- 	else
-- 		-- 		c.border_width = beautiful.border_width
-- 		-- 	end
-- 		-- end
-- 	end
--  )
