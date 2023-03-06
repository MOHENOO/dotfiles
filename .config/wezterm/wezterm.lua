local wezterm = require("wezterm")
local os = require("os")

-- neovim zen mode
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			-- overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			-- overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			-- overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- ui
config.max_fps = 144
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.adjust_window_size_when_changing_font_size = false
config.front_end = "WebGpu"
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0
config.macos_window_background_blur = 60
config.window_decorations = "RESIZE"

--color_scheme
-- config.color_scheme = "Catppuccin Frappe"
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		config.window_background_opacity = 0.95
		return "Catppuccin Frappe"
	else
		config.window_background_opacity = 1.0
		return "Catppuccin Latte"
		-- Catppuccin Mocha or Macchiato, Frappe, Latte
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
	os.execute("sh $HOME/.config/wezterm/theme.sh")
end)

config.font = wezterm.font({
	-- 现代
	-- family = "MonaspiceNe Nerd Font",
	-- 人文
	-- family = "MonaspiceAr Nerd Font",
	-- 衬线
	-- family = "MonaspiceXe Nerd Font",
	-- 手写
	family = "MonaspiceRn Nerd Font",
	-- 机械
	-- family = "MonaspiceKr Nerd Font",
	weight = "Medium",
	harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
})

config.font = wezterm.font_with_fallback({
	{
		-- 现代
		-- family = "MonaspiceNe Nerd Font",
		-- 人文
		-- family = "MonaspiceAr Nerd Font",
		-- 衬线
		-- family = "MonaspiceXe Nerd Font",
		-- 手写
		family = "MonaspiceRn Nerd Font",
		-- 机械
		-- family = "MonaspiceKr Nerd Font",
		weight = "Medium",
		harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
	},
	{
		family = "PingFang SC",
		weight = "Medium",
	},
})

-- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html
-- wezterm ls-fonts
-- wezterm ls-fonts --list-system

config.font_size = 20
config.line_height = 1.2
config.cell_width = 1.0

--term
config.term = "xterm-256color"

return config
