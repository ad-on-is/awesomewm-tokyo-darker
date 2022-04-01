local awful = require( "awful" )
local modkey = "Mod4"
local altkey = "Mod1"
local beautiful = require( "beautiful" )
local lain = require( "lain" )
local naughty = require( "naughty" )

local globalkeys = awful.util.table.join( -- Destroy all notifications
	-- awful.key( { "Control" }, "space", function() awful.layout.inc( 1 ) end ),
	awful.key( { "Control", "Shift" }, "space", function() awful.layout.inc( -1 ) end ),
		awful.key( { altkey }, "p", function() os.execute( "screenshot" ) end ),
		awful.key( { altkey, "Control" }, "l", function() os.execute( scrlocker ) end ), -- Show help
		awful.key( { modkey, "Control" }, "Left", awful.tag.viewprev ),
		awful.key( { modkey, "Control" }, "Right", awful.tag.viewnext ),
		awful.key( { modkey }, "j", awful.tag.viewprev ),
		awful.key( { modkey }, "l", awful.tag.viewnext ),
		awful.key( { modkey }, "Escape", awful.tag.history.restore ), awful.key(
			{ modkey }, ".", function() awful.spawn( "emote", { floating = true, skip_taskbar = true } ) end
		 ),
		-- awful.key( { modkey }, "t", bling.module.tabbed.pick(), { description = "show help", group = "awesome" } ),
		-- awful.key( { modkey, "Shift" }, "t", bling.module.tabbed.pop(), { description = "show help", group = "awesome" } ),
		awful.key( { altkey, "Control", "Shift" }, "1", function() awful.spawn( "flameshot gui" ) end ), -- G1
		awful.key(
			{ altkey, "Control", "Shift" }, "2",
				function() awful.spawn.with_shell( "peek & sleep 2 && touch ~/.config/picom/picom.conf" ) end
		 ), -- G2
		-- Non-empty tag browsing
		-- awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
		--           {description = "view  previous nonempty", group = "tag"}),
		-- awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
		--           {description = "view  previous nonempty", group = "tag"}),
		-- Default client focus
		-- awful.key({ altkey,           }, "j",
		--     function ()
		--         awful.client.focus.byidx( 1)
		--     end,
		--     {description = "focus next by index", group = "client"}
		-- ),
		-- awful.key({ altkey,           }, "k",
		--     function ()
		--         awful.client.focus.byidx(-1)
		--     end,
		--     {description = "focus previous by index", group = "client"}
		-- ),
		-- Layout manipulation
		awful.key( { modkey, "Shift" }, "Left", function() awful.client.swap.byidx( 1 ) end ),
		awful.key( { modkey, "Shift" }, "Right", function() awful.client.swap.byidx( -1 ) end ),
		awful.key( { modkey, "Control" }, "j", function() awful.screen.focus_relative( 1 ) end ),
		awful.key( { modkey, "Control" }, "k", function() awful.screen.focus_relative( -1 ) end ),
		-- awful.key( { modkey }, "u", awful.client.urgent.jumpto ), awful.key(
		-- 	{ modkey }, "Tab", function()
		-- 		if cycle_prev then
		-- 			awful.client.focus.history.previous()
		-- 		else
		-- 			awful.client.focus.byidx( -1 )
		-- 		end
		-- 		if client.focus then client.focus:raise() end
		-- 	end
		--  ), -- Show/hide wibox
		-- awful.key({ modkey }, "b", function ()
		--         for s in screen do
		--             s.mywibox.visible = not s.mywibox.visible
		--             if s.mybottomwibox then
		--                 s.mybottomwibox.visible = not s.mybottomwibox.visible
		--             end
		--         end
		--     end,
		--     {description = "toggle wibox", group = "awesome"}),
		-- On-the-fly useless gaps change
		-- awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
		--           {description = "increment useless gaps", group = "tag"}),
		-- awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
		--           {description = "decrement useless gaps", group = "tag"}),
		-- Dynamic tagging
		-- awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
		--           {description = "add new tag", group = "tag"}),
		-- awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
		--           {description = "rename tag", group = "tag"}),
		-- awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
		--           {description = "move tag to the left", group = "tag"}),
		-- awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
		--           {description = "move tag to the right", group = "tag"}),
		-- awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
		--           {description = "delete tag", group = "tag"}),
		-- Standard program
		awful.key( { modkey }, "Return", function() awful.spawn( awful.util.terminal ) end ),
		awful.key( { modkey, "Control" }, "r", awesome.restart ), --   awesome.quit
		awful.key(
			{ modkey, "Shift", "Control" }, "q", function() os.execute( "systemctl restart sddm" ) end
		 ), awful.key( { modkey, altkey }, "l", function() awful.tag.incmwfact( 0.05 ) end ),
		awful.key( { modkey, altkey }, "h", function() awful.tag.incmwfact( -0.05 ) end ),
		awful.key( { modkey, "Shift" }, "h", function() awful.tag.incnmaster( 1, nil, true ) end ),
		awful.key( { modkey, "Shift" }, "l", function() awful.tag.incnmaster( -1, nil, true ) end ),
		awful.key( { modkey, "Control" }, "h", function() aJJwful.tag.incncol( 1, nil, true ) end ),
		awful.key( { modkey, "Control" }, "l", function() awful.tag.incncol( -1, nil, true ) end ),
		awful.key( { modkey }, "Tab", function() awful.layout.inc( 1 ) end ),
		awful.key( { modkey, "Shift" }, "Tab", function() awful.layout.inc( -1 ) end ), awful.key(
			{ modkey, "Control" }, "n", function()
				local c = awful.client.restore()
				-- Focus restored client
				if c then c:emit_signal( "request::activate", "key.unminimize", { raise = true } ) end
			end
		 ), -- Dropdown application
		awful.key( { modkey }, "z", function() awful.screen.focused().quake:toggle() end ), -- Widgets popups
		awful.key( { altkey }, "c", function() if beautiful.cal then beautiful.cal.show( 7 ) end end ),
		awful.key( { altkey }, "h", function() if beautiful.fs then beautiful.fs.show( 7 ) end end ),
		awful.key(
			{ altkey }, "w", function() if beautiful.weather then beautiful.weather.show( 7 ) end end
		 ), -- Screen brightness
		awful.key(
			{}, "XF86PowerOff", function()

				for s in screen do
					naughty.notify {
						preset = naughty.config.presets.critical,
						title = "ZZZzzzzz...",
						text = "Going to sleep now, see ya!",
						timeout = 2,
						screen = s
					 }
				end

				awful.spawn.with_shell( "systemctl suspend" )
			end
		 ), awful.key(
			{}, "XF86AudioPlay", function()
				awful.spawn.with_shell( "playerctl play-pause" )
				beautiful.mpd.update()
			end
		 ), awful.key(
			{}, "XF86AudioPrev", function()
				awful.spawn.with_shell( "playerctl previous" )
				beautiful.mpd.update()
			end
		 ), awful.key(
			{}, "XF86AudioNext", function()
				awful.spawn.with_shell( "playerctl next" )
				beautiful.mpd.update()
			end
		 ), awful.key(
			{}, "XF86MonBrightnessUp", function() awful.spawn.with_shell( "xbacklight -inc 10" ) end
		 ), awful.key(
			{}, "XF86MonBrightnessDown", function() awful.spawn.with_shell( "xbacklight -dec 10" ) end
		 ), -- ALSA volume control
		awful.key(
			{}, "XF86AudioRaiseVolume", function()
				awful.spawn.with_shell( string.format( "amixer -q set %s 2%%+", beautiful.volume.channel ) )
				beautiful.volume.update()
				awesome.emit_signal( "volume_change" )
			end
		 ), awful.key(
			{}, "XF86AudioLowerVolume", function()
				awful.spawn.with_shell( string.format( "amixer -q set %s 2%%-", beautiful.volume.channel ) )
				beautiful.volume.update()
				awesome.emit_signal( "volume_change" )
			end
		 ), awful.key(
			{}, "XF86AudioMute", function()
				awful.spawn.with_shell(
					string.format(
						"amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel
					 )
				 )
				awesome.emit_signal( "volume_change" )
				beautiful.volume.update()
			end
		 ), -- awful.key({ altkey, "Control" }, "m",
		-- awful.key(
		-- 	{ altkey }, "0", function()
		-- 		local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
		-- 		if beautiful.mpd.timer.started then
		-- 			beautiful.mpd.timer:stop()
		-- 			common.text = common.text .. lain.util.markup.bold( "OFF" )
		-- 		else
		-- 			beautiful.mpd.timer:start()
		-- 			common.text = common.text .. lain.util.markup.bold( "ON" )
		-- 		end
		-- 		naughty.notify( common )
		-- 	end
		--  ), -- Copy primary to clipboard (terminals to gtk)
		awful.key( { modkey }, "c", function() awful.spawn.with_shell( "xsel | xsel -i -b" ) end ), -- Copy clipboard to primary (gtk to terminals)
		awful.key( { modkey }, "v", function() awful.spawn.with_shell( "xsel -b | xsel" ) end ), -- User programs
		awful.key(
			{ altkey }, "Tab", function() awful.spawn( "/home/adonis/.config/rofi/bin/switcher" ) end
		 ), -- awful.key({ modkey }, "q", function () awful.spawn(browser) end,
		--           {description = "run browser", group = "launcher"}),
		-- Default
		--[[ Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    --]] --[[ dmenu
    awful.key({ modkey }, "x", function ()
            os.execute(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
            beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
        end,
        {description = "show dmenu", group = "launcher"}),
    --]] -- alternatively use rofi, a dmenu-like application with more featuresdd
		-- check https://github.com/DaveDavenport/rofi for more details
		awful.key(
			-- { altkey }, "space", function() awful.spawn( "ulauncher" ) end
			{ altkey }, "space", function() awful.spawn( "/home/adonis/.config/rofi/bin/launcher" ) end
		 ), -- Prompt
		-- awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
		--           {description = "run prompt", group = "launcher"}),
		awful.key(
			{ modkey }, "x", function()
				awful.prompt.run {
					prompt = "Run Lua code: ",
					textbox = awful.screen.focused().mypromptbox.widget,
					exe_callback = awful.util.eval,
					history_path = awful.util.get_cache_dir() .. "/history_eval"
				 }
			end
		 ) -- ]]
 )

for i = 1, 9 do
	globalkeys = awful.util.table.join(
		globalkeys, -- View tag only.
		awful.key(
			{ modkey }, "#" .. i + 9, function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then tag:view_only() end
			end
		 ), -- Toggle tag display.
		awful.key(
			{ modkey, "Control" }, "#" .. i + 9, function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then awful.tag.viewtoggle( tag ) end
			end
		 ), -- Move client to tag.
		awful.key(
			{ modkey, "Shift" }, "#" .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then client.focus:move_to_tag( tag ) end
				end
			end
		 ), -- Toggle tag on focused client.
		awful.key(
			{ modkey, "Control", "Shift" }, "#" .. i + 9, function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then client.focus:toggle_tag( tag ) end
				end
			end
		 )
	 )
end

awful.util.clientkeys = awful.util.table.join(
	awful.key(
		{ altkey, "Shift" }, "m", lain.util.magnify_client
	 ), awful.key(
		{ modkey }, "f", function( c )

			c.maximized = not c.maximized
			c:raise()
		end
	 ), awful.key( { modkey }, "q", function( c ) c:kill() end ),
		awful.key( { modkey }, "space", awful.client.floating.toggle ),
		-- awful.key( { "Control" }, "Return", function( c ) c:swap( awful.client.getmaster() ) end ),
		awful.key( { modkey }, "o", function( c ) c:move_to_screen() end ) -- awful.key(
	-- 	{ modkey }, "m", function( c )
	-- 		-- The client currently has the input focus, so it cannot be
	-- 		-- minimized, since minimized clients can't have the focus.
	-- 		c.minimized = true
	-- 	end
	--  ), 
	-- awful.key(
	-- 	{ modkey }, "m", function( c )
	-- 		c.maximized = not c.maximized
	-- 		c:raise()
	-- 	end
	--  ), 
	-- awful.key(
	-- 	{ modkey, "Shift" }, "m", function( c )
	-- 		c.maximized_horizontal = not c.maximized_horizontal
	-- 		c:raise()
	-- 	end
	--  )
 )

awful.util.clientbuttons = awful.util.table.join(
	awful.button(
		{}, 1, function( c ) c:emit_signal( "request::activate", "mouse_click", { raise = true } ) end
	 ), awful.button(
		{ modkey }, 1, function( c )
			c:emit_signal( "request::activate", "mouse_click", { raise = true } )
			awful.mouse.client.move( c )

		end
	 ), awful.button(
		{ modkey }, 3, function( c )
			c:emit_signal( "request::activate", "mouse_click", { raise = true } )
			awful.mouse.client.resize( c )
		end
	 )
 )

awful.util.taglist_buttons = awful.util.table.join(
	awful.button(
		{}, 1, function( t ) t:view_only() end
	 ), awful.button(
		{ modkey }, 1, function( t ) if client.focus then client.focus:move_to_tag( t ) end end
	 ), awful.button( {}, 3, awful.tag.viewtoggle ), awful.button(
		{ modkey }, 3, function( t ) if client.focus then client.focus:toggle_tag( t ) end end
	 ), awful.button( {}, 4, function( t ) awful.tag.viewnext( t.screen ) end ),
		awful.button( {}, 5, function( t ) awful.tag.viewprev( t.screen ) end )
 )

awful.util.tasklist_buttons = awful.util.table.join(
	awful.button(
		{}, 1, function( c )
			if c == client.focus then
				c.minimized = true
			else
				-- Without this, the following
				-- :isvisible() makes no sense
				c.minimized = false
				if not c:isvisible() and c.first_tag then c.first_tag:view_only() end
				-- This will also un-minimize
				-- the client, if needed
				client.focus = c
				c:raise()
			end
		end
	 ), awful.button( {}, 2, function( c ) c.kill( c ) end ),
		awful.button( {}, 4, function() awful.client.focus.byidx( 1 ) end ),
		awful.button( {}, 5, function() awful.client.focus.byidx( -1 ) end )
 )

awful.util.titlebar_buttons = awful.util.table.join(
	awful.button(
		{}, 1, function()
			c:emit_signal( "request::activate", "titlebar", { raise = true } )
			awful.mouse.client.move( c )
		end
	 ), awful.button(
		{}, 3, function()
			c:emit_signal( "request::activate", "titlebar", { raise = true } )
			awful.mouse.client.resize( c )
		end
	 )
 )

local mouse_buttons = awful.util.table
	                      .join( -- awful.button( {}, 3, function() end ), awful.button( {}, 4, awful.tag.viewnext ),
-- 	awful.button( {}, 5, awful.tag.viewprev )
)

awful.util.layoutbox_buttons = awful.util.table.join(
	awful.button(
		{}, 1, function() awful.layout.inc( 1 ) end
	 ), awful.button( {}, 2, function() awful.layout.set( awful.layout.layouts[1] ) end ),
		awful.button( {}, 3, function() awful.layout.inc( -1 ) end ),
		awful.button( {}, 4, function() awful.layout.inc( 1 ) end ),
		awful.button( {}, 5, function() awful.layout.inc( -1 ) end )
 )

root.keys( globalkeys )
root.buttons( mouse_buttons )

