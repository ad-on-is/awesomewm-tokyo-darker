local lain = require( "lain" )
local bling = require( "bling" )
local awful = require( "awful" )
local wibox = require( "wibox" )
local os = require( "os" )
local gears = require( "gears" )
local beautiful = require( "beautiful" )
local dpi = require( "beautiful.xresources" ).apply_dpi

local markup = lain.util.markup

-- useful if wanna show arrows in topbar
local separators = lain.util.separators
local arrow = separators.arrow_left

os.setlocale( os.getenv( "LANG" ) )
beautiful.dateclock = wibox.widget.textclock(
	markup.fontfg(
		beautiful.font, beautiful.fg_normal,
			markup( beautiful.color_yellow, "   " ) .. markup( beautiful.fg_normal, "%a, %d. %b" ) ..
				markup( beautiful.color_yellow, "   " ) .. markup( beautiful.fg_normal, " %T" )
	 ), 1
 )

-- local myclock = {
-- 	wibox.widget.textclock(
-- 		markup.fontfg(
-- 			theme.font, theme.fg_normal,
-- 				markup( theme.color_yellow, "   " ) .. markup( theme.fg_normal, "%a, %d. %b" ) ..
-- 					markup( theme.color_yellow, "   " ) .. markup( theme.fg_normal, " %T" )
-- 		 ), 1
-- 	 ),
-- 	bottom = 1,
-- 	color = theme.color_yellow,
-- 	font = theme.font,
-- 	widget = wibox.container.margin
--  }

beautiful.cal = lain.widget.cal(
	{
		attach_to = { beautiful.dateclock },
		notification_preset = { font = beautiful.font, fg = beautiful.fg_normal, bg = beautiful.bg_normal }
	 }
 )

-- Weather
local weathericon = wibox.widget.imagebox( beautiful.widget_weather )
beautiful.weather = lain.widget.weather(
	{
		city_id = 2643743, -- placeholder (London)
		notification_preset = { font = "Terminus 10", fg = beautiful.fg_normal },
		weather_na_markup = markup.fontfg( beautiful.font, "#eca4c4", "N/A " ),
		settings = function()
			descr = weather_now["weather"][1]["description"]:lower()
			units = math.floor( weather_now["main"]["temp"] )
			widget:set_markup( markup.fontfg( beautiful.font, "#eca4c4", descr .. " @ " .. units .. "°C" ) )
		end
	 }
 )

beautiful.temp = lain.widget.temp(
	{
		settings = function()
			local color = beautiful.color_blue_light
			-- if coretemp_now > 70 then color = beautiful.color_orange end
			-- if coretemp_now > 90 then color = beautiful.color_red end
			widget:set_markup( markup.fontfg( beautiful.font, color, coretemp_now .. "°C" ) )
		end
	 }
 )
beautiful.cpu = lain.widget.cpu(
	{
		settings = function()
			local color = beautiful.color_blue_light
			local usage = tonumber( cpu_now.usage ) + 0.0
			if usage > 50 and cpu_now.usage < 90 then color = beautiful.color_yellow end
			if usage > 90 then color = beautiful.color_red end
			widget:set_markup(
				markup.fontfg(
					beautiful.font, beautiful.fg_normal,
						markup( color, "  " ) .. markup( beautiful.fg_normal, usage .. "%" )
				 )
			 )
		end
	 }
 )

beautiful.memory = lain.widget.mem(
	{
		settings = function()
			local color = beautiful.color_blue_light
			local used = math.ceil( mem_now.used / 1000 )
			local percent = math.ceil( 100 / mem_now.total * mem_now.used )
			if percent > 50 and mem_now.used < 90 then color = beautiful.color_yellow end
			if percent > 90 then color = beautiful.color_red end
			widget:set_markup(
				markup.fontfg(
					beautiful.font, beautiful.fg_normal,
						markup( color, "  " ) .. markup( beautiful.fg_normal, used .. " GB (" .. percent .. "%)" )
				 )
			 )
		end
	 }
 )

beautiful.fs = lain.widget.fs(
	{
		notification_preset = { font = beautiful.font, fg = beautiful.fg_normal },
		settings = function()
			local color_root = beautiful.color_torquise_dark
			local color_home = beautiful.color_torquise_dark
			local root_free = math.floor( 100 / fs_now["/"].size * fs_now["/"].free )
			local root_text = math.floor( fs_now["/"].free )
			local home_free = math.floor( 100 / fs_now["/home"].size * fs_now["/home"].free )
			local home_text = math.floor( fs_now["/home"].free )
			if root_free < 10 then color_root = beautiful.color_red end
			if home_free < 10 then color_home = beautiful.color_red end
			widget:set_markup(
				markup.fontfg(
					beautiful.font, beautiful.fg_normal,
						markup( color_root, "  /root  " ) .. markup( beautiful.fg_normal, root_text .. " GB " ) ..
							markup( color_home, "   /home  " ) .. markup( beautiful.fg_normal, home_text .. " GB" )
				 )
			 )
		end
	 }
 )

beautiful.battery = lain.widget.bat(
	{
		settings = function()
			local icon = " "
			local color = beautiful.color_purple
			local perc = bat_now.perc ~= "N/A" and bat_now.perc or 0

			if bat_now.ac_status == 1 then
				icon = "" .. icon
				color = beautiful.color_torquise_light
			end

			if perc > 10 and perc < 50 then color = beautiful.color_orange end
			if perc < 10 then color = beautiful.color_red end

			bat_notification_critical_preset = {
				title = "Battery exhausted",
				text = "Shutdown imminent",
				timeout = 15,
				fg = beautiful.color_red,
				bg = beautiful.bg_normal
			 }

			bat_notification_low_preset = {
				title = "Battery low",
				text = "Plug the cable!",
				timeout = 15,
				fg = beautiful.color_yellow,
				bg = beautiful.bg_normal
			 }

			-- widget:set_markup( markup.fontfg( beautiful.font, beautiful.fg_normal, perc .. " " ) )
			widget:set_markup(
				markup.fontfg(
					beautiful.font, beautiful.fg_normal,
						markup( color, icon ) .. markup( beautiful.fg_normal, perc .. "% " )
				 )
			 )
		end,
		timeout = 1,
		full_notify = "off"

	 }
 )

-- ALSA volume
beautiful.volume = lain.widget.alsa(
	{
		settings = function()
			if volume_now.status == "off" then
				volume_now.level = markup( beautiful.color_red, "  " ) .. volume_now.level
			else
				volume_now.level = markup( beautiful.color_green, "  " ) .. volume_now.level
			end

			widget:set_markup( "  " .. markup.fontfg( beautiful.font, beautiful.fg_normal, volume_now.level ) )
		end,
		timeout = 1
	 }
 )

beautiful.pulse = lain.widget.pulse(
	{
		settings = function()
			-- 	if volume_now.status == "off" then
			-- 		volume_now.level = markup( beautiful.color_red, "  " ) .. volume_now.level
			-- 	else
			-- 		volume_now.level = markup( beautiful.color_green, "  " ) .. volume_now.level
			-- 	end

			widget:set_markup( "  " .. markup.fontfg( beautiful.font, beautiful.fg_normal, volume_now.index ) )
		end
	 }
 )

beautiful.packages = awful.widget.watch(
	"bash -c 'paru -Qqu'", 60, function( widget, stdout )
		local count = select( 2, stdout:gsub( "\n", "\n" ) )
		if count > 0 then
			widget:set_markup(
				markup.fontfg(
					beautiful.font, beautiful.fg_normal,
						markup( beautiful.color_red, "  " ) .. markup( beautiful.fg_normal, count )
				 )
			 )
		end
	end
 )

beautiful.archlogo = wibox.widget {
	markup = markup( beautiful.color_blue_light, "  " ),
	widget = wibox.widget.textbox
 }

beautiful.mpd = lain.widget.mpd( {} ) -- needed to show player notifications

local icon_widget = wibox.widget {
	markup = markup( beautiful.color_torquise, " ﱘ " ),
	widget = wibox.widget.textbox
 }
local name_widget = wibox.widget { markup = "", widget = wibox.widget.textbox }

local title_widget = wibox.widget { markup = "", widget = wibox.widget.textbox }

local artist_widget = wibox.widget { markup = "", widget = wibox.widget.textbox }

-- -- Get Song Info
local playerctl = bling.signal.playerctl.lib()
playerctl:connect_signal(
	"metadata", function( _, title, artist, album_path, album, new, player_name )
		-- Set art widget

		-- Set player name, title and artist widgets
		name_widget:set_markup_silently( player_name )
		title_widget:set_markup_silently( title )
		artist_widget:set_markup_silently( artist )
	end
 )

beautiful.playerctl = {
	layout = wibox.layout.fixed.horizontal,
	-- name_widget,
	artist_widget,
	icon_widget,
	title_widget
 }
