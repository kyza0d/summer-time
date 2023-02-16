local M = {}

local palette = {
  bg = "#2E2E32",
  fg = "#e5e5e5",
  comment = "#676B6F",
  dimmed = "#8e9399",
  yellow = "#F7C95C",
  blue = "#93DDFA",
  purple = "#E58AC9",
  orange = "#FFA94D",
  green = "#c9e589",
  red = "#e58e89",
}

function M.setup()
  vim.g.colors_name = "summer-time"

  -- stylua: ignore
  local syntax = {
    Identifier             = { clear = true },
    Title                  = { fg = palette.fg },
    String                 = { fg = palette.yellow },
    Quote                  = { fg = palette.yellow },
    Character              = { fg = palette.yellow },
    Tag                    = { fg = palette.purple },
    Conditional            = { fg = palette.purple },
    Repeat                 = { fg = palette.purple },
    Statement              = { fg = palette.purple },
    Label                  = { fg = palette.purple },
    Exception              = { fg = palette.purple },
    Include                = { fg = palette.purple },
    PreCondit              = { fg = palette.purple },
    Define                 = { fg = palette.purple },
    Macro                  = { fg = palette.purple },
    PreProc                = { fg = palette.purple },
    StorageClass           = { fg = palette.purple },
    Typedef                = { fg = palette.purple },
    SpecialComment         = { fg = palette.comment },
    Comment                = { fg = palette.comment },
    Number                 = { fg = palette.orange },
    Float                  = { fg = palette.orange },
    Constant               = { fg = palette.orange },
    Boolean                = { fg = palette.orange },
    Todo                   = { fg = palette.orange },
    Type                   = { fg = palette.orange },
    Special                = { fg = palette.blue },
    Function               = { fg = palette.blue },
    SpecialChar            = { fg = palette.dimmed },
    Delimiter              = { fg = palette.dimmed },
    Operator               = { fg = palette.dimmed },
    SpecialKey             = { fg = palette.dimmed },
    Error                  = { fg = palette.red },
    ["@text.literal"]      = { link = "Comment", default = true },
    ["@text.reference"]    = { link = "Identifier", default = true },
    ["@text.title"]        = { link = "Title", default = true },
    ["@text.uri"]          = { link = "Underlined", default = true },
    ["@text.underline"]    = { link = "Underlined", default = true },
    ["@text.todo"]         = { link = "Todo", default = true },
    ["@comment"]           = { link = "Comment", default = true },
    ["@punctuation"]       = { link = "Delimiter", default = true },
    ["@constant"]          = { link = "Constant", default = true },
    ["@constant.builtin"]  = { link = "Special", default = true },
    ["@constant.macro"]    = { link = "Define", default = true },
    ["@define"]            = { link = "Define", default = true },
    ["@macro"]             = { link = "Macro", default = true },
    ["@string"]            = { link = "String", default = true },
    ["@string.escape"]     = { link = "SpecialChar", default = true },
    ["@string.special"]    = { link = "SpecialChar", default = true },
    ["@character"]         = { link = "Character", default = true },
    ["@character.special"] = { link = "SpecialChar", default = true },
    ["@number"]            = { link = "Number", default = true },
    ["@boolean"]           = { link = "Boolean", default = true },
    ["@float"]             = { link = "Float", default = true },
    ["@function"]          = { link = "Function", default = true },
    ["@function.builtin"]  = { link = "Special", default = true },
    ["@function.macro"]    = { link = "Macro", default = true },
    ["@parameter"]         = { link = "Identifier", default = true },
    ["@method"]            = { link = "Function", default = true },
    ["@field"]             = { link = "Special", default = true },
    ["@property"]          = { link = "Special", default = true },
    ["@constructor"]       = { link = "Special", default = true },
    ["@conditional"]       = { link = "Conditional", default = true },
    ["@repeat"]            = { link = "Repeat", default = true },
    ["@label"]             = { link = "Label", default = true },
    ["@operator"]          = { link = "Operator", default = true },
    ["@keyword"]           = { link = "Macro", default = true },
    ["@keyword.operator"]  = { link = "Macro", default = true },
    ["@exception"]         = { link = "Exception", default = true },
    ["@variable"]          = { link = "Identifier", default = true },
    ["@type"]              = { link = "Type", default = true },
    ["@type.definition"]   = { link = "Typedef", default = true },
    ["@storageclass"]      = { link = "StorageClass", default = true },
    ["@structure"]         = { link = "Structure", default = true },
    ["@namespace"]         = { link = "Identifier", default = true },
    ["@include"]           = { link = "Include", default = true },
    ["@preproc"]           = { link = "PreProc", default = true },
    ["@debug"]             = { link = "Debug", default = true },
    ["@tag"]               = { link = "Tag", default = true },
    ["@tag.delimiter"]     = { link = "Delimiter", default = true },
    ["@constructor.lua"]   = { link = "Delimiter", default = true },
  }

  if not pcall(require, "harmony") then
    vim.api.nvim_echo({ { "summer-time: harmony.nvim is not installed. see ':help summer-time-dependencies'", "ErrorMsg" } }, true, {})
    return
  end

  local colors = require("harmony").colors

  -- @param groups string
  -- @return applies highlight based off properties in highlights table
  for group, gui in pairs(syntax) do
    if gui.clear then
      vim.api.nvim_cmd({ cmd = "highlight", args = { "clear", group } }, {})
    end

    -- stylua: ignore
    local keys = {
      "fg", "bg", "sp", "blend", "bold", "standout", "underline",
      "undercurl", "underdouble", "underdotted", "strikethrough", "italic", "reverse",
      "nocombine",  "cterm", "ctermfg", "ctermbg", "default", "link"
    }

    local attrs = {}

    for _, key in ipairs(keys) do
      attrs[key] = colors[gui[key]] or gui[key]
    end

    vim.api.nvim_set_hl(0, group, attrs)
  end

  require("harmony").register({
    ["summer-time"] = {
      bg = palette.bg,
      fg = palette.fg,
      red = palette.red,
      green = palette.green,
      yellow = palette.yellow,
      blue = palette.blue,
      purple = palette.purple,
      accent = palette.blue,
    },
  })
end

return M
