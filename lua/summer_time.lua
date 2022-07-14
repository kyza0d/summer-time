-- stylua: ignore
local palette = {
  --              Dark       Light
  background  = { "#181d23", "#e3e6fc" },
	green       = { "#347960", "#6B8E23" },
	yellow      = { "#D3AB58", "#AA822C" },
	blue        = { "#00A3D2", "#007B9E" },
	magenta     = { "#c792ea", "#c792ea" },
	white       = { "#A6ABB8", "#585E6F" },
	cyan        = { "#00A9B9", "#00909E" },
	red         = { "#FA5F8B", "#F92F68" },
	soft_red    = { "#F06C6F", "#DE1747" },
	orange      = { "#D08447", "#B76B2F" },
	soft_orange = { "#E17954", "#DA582A" },
	comment     = { "#606571", "#606571" },
}

local variant
for i, x in pairs(vim.opt.background) do
	if i == "_value" then
		if x == "light" then
			variant = 2
		else
			variant = 1
		end
	end
end

local clear

local background = palette["background"][variant]
local yellow = palette["yellow"][variant]
local blue = palette["blue"][variant]
local orange = palette["orange"][variant]
local cyan = palette["cyan"][variant]
local white = palette["white"][variant]
local comment = palette["comment"][variant]
local red = palette["red"][variant]
local soft_red = palette["soft_red"][variant]
local soft_orange = palette["soft_orange"][variant]

local blend = require("summer_time.utils").blend

local groups = {
	Normal = { bg = "21262f" },
	TSInclude = { fg = red },
	TSMethod = { fg = cyan },
	TSFunction = { fg = cyan },
	TSKeywordFunction = { fg = red },
	TSKeyword = { fg = red },
	TSFuncBuiltin = { fg = cyan },
	TSNumber = { fg = orange },
	TSString = { fg = yellow },
	TSPunctBracket = { clear },
	TSPunctDelimiter = { clear },
	TSOperator = { clear },
	TSConditional = { fg = red },
	TSComment = { fg = comment },
	TSField = { fg = cyan },
	TSParameter = { fg = orange },
	TSRepeat = { fg = red },
	TSNone = { white },
	TSConstant = { fg = soft_red },
	TSBoolean = { fg = soft_red },
	TSType = { fg = blue },
	TSTag = { fg = cyan },
	TSConstructor = { fg = clear },
	TSTagDelimiter = { clear },
	tsxTSConstructor = { fg = soft_orange },
	TSProperty = { fg = orange },
	TSTypeBuiltin = { fg = soft_orange },
	TSPunctSpecial = { fg = red },
	TSVariable = { fg = white },
	TSStringEscape = { fg = blue },
	TSKeywordOperator = { fg = red },
	TSConstBuiltin = { fg = soft_red },
	TSStringRegex = { fg = soft_orange },
	TSNote = { fg = yellow },
}

--[[
  @param {table} 'highlights_tbl' The first table
  @return {function} applies highlight based off properties in highlights table 
]]
-- stylua: ignore
for group_name, properties in pairs(groups) do
  if properties.links then
    vim.api.nvim_command(string.format(
      "highlight! link %s %s",

      group_name,
      properties.links))
  elseif properties.clear then
    vim.api.nvim_command(string.format(
      "highlight! clear %s",
      group_name))
  else
    vim.api.nvim_command(string.format(
      "highlight! %s guifg=%s guibg=%s guisp=%s gui=%s", group_name,

      properties.fg or "none",
      properties.bg or "none",
      properties.sp or "none",
      properties.cfg or "none",
      properties.gui or "none"))
  end
end

local status_ok, nvim_palette = pcall(require, "palette")

if not status_ok then
	print("Error: nvim_palette.lua not found")
	return
end

-- stylua: ignore
nvim_palette.register({
	colors = {
		["summer_time"] = {
			background = { "#181d23", "#eaecf9" },
			foreground = { "#A6ABB8", "#383A42" },
			red        = palette["red"],
			green      = palette["green"],
			yellow     = palette["yellow"],
			blue       = palette["blue"],
			purple     = palette["purple"],
			highlights = {
				PmenuSel = { bg = blend(blue, background, 0.8) },
			},
		},
	},
})
