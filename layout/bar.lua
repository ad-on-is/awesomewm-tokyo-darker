-- ]] local gears = require( "gears" )
local lain = require( "lain" )
local awful = require( "awful" )
local wibox = require( "wibox" )
local beautiful = require( "beautiful" )
local dpi = require( "beautiful.xresources" ).apply_dpi
local spotify_widget = require( "awesome-wm-widgets.spotify-widget.spotify" )
local pulse = require( "lain.widget.pulse" )

local widgets = require( "layout.widgets" )

local bar_height = 25

function beautiful.top_bar( s )

	function right_tri( cr, width, height, degree )
		cr:move_to( bar_height, 0 )
		cr:line_to( 0, bar_height )
		cr:line_to( bar_height, bar_height )
		cr:close_path()
	end

	local function mysep( color, shape )
		return wibox.widget {
			shape = shape,
			color = color,
			border_width = 0,
			forced_width = bar_height,
			widget = wibox.widget.separator
		 }
	end

	local widget_spacing = dpi( 10 )
	local task_width = dpi( 0 )
	if s == screen.primary then task_width = dpi( 130 ) end

	s.quake = lain.util.quake( { app = awful.util.terminal } )

	awful.tag( awful.util.tagnames, s, awful.layout.layouts )

	s.mylayoutbox = awful.widget.layoutbox( s )
	s.mylayoutbox:buttons( awful.util.layoutbox_buttons )
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = awful.util.taglist_buttons
	 }

	s.mytasklist = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = awful.util.tasklist_buttons,
		layout = { spacing = widget_spacing, layout = wibox.layout.flex.horizontal },
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{ id = "icon_role", widget = wibox.widget.imagebox },
						margins = 5,
						forced_width = dpi( 25 ),
						widget = wibox.container.margin
					 },
					{ id = "text_role", forced_width = task_width, widget = wibox.widget.textbox },
					layout = wibox.layout.fixed.horizontal
				 },
				left = 10,
				right = 10,
				widget = wibox.container.margin
			 },
			id = "background_role",
			widget = wibox.container.background
		 }
	 }

	-- if s == screen.primary then pos = "bottom" end

	-- Create the wibox
	s.topbar = awful.wibar(
		{
			position = "top",
			screen = s,
			height = dpi( bar_height ),
			border_width = 1,
			border_color = beautiful.border_normal,
			opacity = 0.8
		 }
	 )

	-- sys:set_base_size( 20 )
	local systray = wibox.widget {
		{ wibox.widget.systray(), top = 5, widget = wibox.container.margin },
		widget = wibox.container.background
	 }
	beautiful.systray_icon_spacing = dpi( 15 )
	beautiful.bg_systray = beautiful.bg_normal

	local left_widgets = { layout = wibox.layout.fixed.horizontal, s.mytaglist }

	local right_widgets = {}

	if s ~= screen.primary then
		right_widgets = {
			layout = wibox.layout.fixed.horizontal,
			wibox.container.margin( beautiful.volume.widget, widget_spacing, widget_spacing, 0, 0 ),
			wibox.container.margin( beautiful.dateclock, widget_spacing, widget_spacing, 0, 0 ),
			wibox.container.margin( beautiful.battery.widget, widget_spacing, widget_spacing, 0, 0 ),
			wibox.container.margin( s.mylayoutbox, widget_spacing, widget_spacing, 5, 5 )

		 }

	else
		right_widgets = {
			layout = wibox.layout.fixed.horizontal,
			-- beautiful.pulse.widget,
			wibox.container.margin( beautiful.volume.widget, widget_spacing, widget_spacing, 0, 0 ),
			wibox.container.margin( beautiful.dateclock, widget_spacing, widget_spacing, 0, 0 ),
			wibox.container.margin( beautiful.battery.widget, widget_spacing, widget_spacing, 0, 0 ),
			wibox.container.margin( systray, widget_spacing, widget_spacing, 1, 5 ),
			wibox.container.margin( s.mylayoutbox, widget_spacing, widget_spacing, 5, 5 )

		 }

	end

	-- local center_widgets = {}

	-- if s ~= screen.primary then
	center_widgets = { layout = wibox.layout.fixed.horizontal, s.mytasklist }
	-- else

	-- 	center_widgets = { layout = wibox.layout.fixed.horizontal, s.mytasklist }
	-- end

	-- Add widgets to the wibox
	s.topbar:setup{
		expand = "none",
		layout = wibox.layout.align.horizontal,
		left_widgets,
		center_widgets,
		right_widgets

	 }

	if (s == screen.primary) then
		s.bottombar = awful.wibar(
			{
				position = "bottom",
				screen = s,
				height = dpi( bar_height ),
				border_width = 1,
				border_color = beautiful.border_normal,
				opacity = 0.8
			 }
		 )

		--  
		s.bottombar:setup{
			expand = "none",
			layout = wibox.layout.align.horizontal,
			{ layout = wibox.layout.fixed.horizontal, beautiful.archlogo },
			{ layout = wibox.layout.fixed.horizontal, beautiful.playerctl },
			{
				layout = wibox.layout.fixed.horizontal,
				wibox.container.margin( beautiful.packages, widget_spacing, widget_spacing, 0, 0 ),
				wibox.container.margin( beautiful.cpu.widget, widget_spacing, widget_spacing, 0, 0 ),
				wibox.container.margin( beautiful.temp.widget, 0, widget_spacing, 0, 0 ),
				-- wibox.container.background( mysep( beautiful.color_dark3, right_tri ), "#00000000" ),
				wibox.container.margin( beautiful.memory.widget, widget_spacing, widget_spacing, 0, 0 ),
				wibox.container.margin( beautiful.fs.widget, widget_spacing, widget_spacing, 0, 0 )

			 }
		 }
	end

end
