local awful = require( "awful" )

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once( cmd_arr )
	for _, cmd in ipairs( cmd_arr ) do
		awful.spawn.with_shell( string.format( "pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd ) )
	end
end

run_once( { "/home/adonis/.local/bin/adonis-autostart" } ) -- comma-separated entries

-- awful.screen.set_auto_dpi_enabled( true )

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]
