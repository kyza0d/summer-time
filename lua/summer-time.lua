local M = {}

local blend = require("summer-time.utils").blend

-- stylua: ignore
local palette = {
	background  = { "#1D1F21", "#2E2E32" },
	foreground  = { "#d7d9e0", "#A6ABB8" },
	comment     = { "#676B6F", "#676B6F" },
  dimmed      = { "#8e9399", "#676B6F" },
	yellow      = { "#F7C95C", "#F7C95C" },
  blue        = { "#93DDFA", "#93DDFA" },
	purple      = { "#E58AC9", "#E58AC9" },
	orange      = { "#FFA94D", "#D08447" },
	green       = { "#c9e589", "#c9e589" },
	red         = { "#e58e89", "#e58e89" },
}

-- stylua: ignore
M.colorscheme = function()
  vim.g.colors_name = "summer-time"

  local variant = require("palette.utils").get_variant()

  local background = palette["background"][variant]
  local foreground = palette["foreground"][variant]
  local dimmed     = palette["dimmed"][variant]
  local orange     = palette["orange"][variant]
  local yellow     = palette["yellow"][variant]
  local blue       = palette["blue"][variant]
  local purple     = palette["purple"][variant]

  local comment    = palette["comment"][variant]

	vim.api.nvim_command("colorscheme summer-time")

  -- See :help 'nvim-treesitter-highlights'

	local syntax = {
    TSVariable        = { fg = foreground }, -- Variable names that don't fit into other categories.
    TSLabel           = { fg = foreground }, -- GOTO labels: `label:` in C, and `::label::` in Lua.
    TSConstructor     = { fg = dimmed }, -- Constructor calls and definitions: `{}` in Lua, and Java constructors.
    TSTagDelimiter    = { fg = dimmed }, -- Tag delimiters like `<` `>` `/`.
    TSPunctBracket    = { fg = dimmed }, -- Brackets, braces, parentheses, etc.
    TSPunctDelimiter  = { fg = dimmed }, -- Punctuation delimiters: Periods, commas, semicolons, etc.
    TSOperator        = { fg = dimmed }, -- Binary or unary operators: `+`, and also `->` and `*` in C.
    TSVariableBuiltin = { fg = foreground }, -- Variable names defined by the language: `this` or `self` in Javascript.
    TSPunctSpecial    = { fg = purple },     -- Special punctuation that doesn't fit into the previous categories.
    TSKeyword         = { fg = purple },     -- Keywords that don't fit into other categories.
    TSInclude         = { fg = purple },     -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
    TSRepeat          = { fg = purple },     -- Keywords related to loops: `for`, `while`, etc.
    TSKeywordFunction = { fg = purple },     -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
    TSConditional     = { fg = purple },     -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
    TSKeywordOperator = { fg = purple },     -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
    TSMethod          = { fg = blue },       -- Method calls and definitions.
    TSFunction        = { fg = blue },       -- Function calls and definitions.
    TSFuncBuiltin     = { fg = blue },       -- Function calls and definitions.
    TSTag             = { fg = purple },     -- Tags like HTML tag names.
    TSField           = { fg = blue },       -- Object and struct fields.
    TSNumber          = { fg = orange },     -- Numeric literals that don't fit into other categories.
    TSFloat           = { fg = orange },     -- Floating-point number literals.
    TSParameter       = { fg = foreground }, -- Parameters of a function.
    TSProperty        = { fg = foreground }, -- Object and struct fields.
    TSString          = { fg = yellow },     -- String literals.
    TSBoolean         = { fg = orange },     -- Boolean literals: `True` and `False` in Python.
    TSStringRegex     = { fg = purple },     -- Regular expression literals.
    TSStringEscape    = { fg = purple },     -- Regular expression literals.
    TSConstant        = { fg = foreground }, -- Constants identifiers. These might not be semantically constant.
    TSConstBuiltin    = { fg = purple },     -- Built-in constant values: `nil` in Lua.
    TSTypeBuiltin     = { fg = orange },     -- Built-in types: `i32` in Rust.
    TSNote            = { fg = orange },     -- Text representation of an informational note.
    TSDanger          = { fg = purple },     -- Text representation of a danger note.
    TSWarning         = { fg = orange },     -- Text representation of a warning note.
    TSType            = { fg = foreground }, -- Type (and class) definitions and annotations.
    TSNamespace       = { fg = purple },     -- Identifiers referring to modules and namespaces.
    TSURI             = { fg = blue },       -- URIs like hyperlinks or email addresses.
    TSComment         = { fg = comment },    -- Line comments and block comments.

    -- Language-specific highlights

    -- JavaScript / TypeScript
    tsxTSConstructor  = { fg = blue },   -- TSX components tags.
    jsxTSConstructor  = { fg = orange }, -- JSX components tags.

    -- C / C++
    cStorageClass     = { fg = purple },

    -- Yaml
    yamlPlainScalar   = { fg = foreground }, -- Plain scalar values

    -- Regex
    regexTSPunctBracket = { fg = foreground },

    -- Fallback colors for when a token doesn't match any of the above categories.

    String         = { links = "TSString" },
    Quote          = { links = "TSString" },
    Operator       = { links = "TSOperator" },
    SpecialComment = { links = "TSComment" },
    Comment        = { links = "TSComment" },
    Identifier     = { links = "TSNamespace" },
    Function       = { links = "TSFunction" },
    Tag            = { links = "TSTag" },
    Number         = { links = "TSNumber" },
    Float          = { links = "TSFloat" },
    Conditional    = { links = "TSConditional" },
    Repeat         = { links = "TSRepeat" },
    Statement      = { links = "TSKeyword" },
    Label          = { links = "TSLabel" },
    Exception      = { links = "TSKeyword" },
    Include        = { links = "TSInclude" },
    PreCondit      = { links = "TSKeyword" },
    Error          = { links = "TSDanger" },
    Constant       = { links = "TSConstant" },
    Boolean        = { links = "TSBoolean" },
    Type           = { links = "TSType" },
    SpecialChar    = { links = "TSPunctSpecial" },
    Todo           = { links = "TSNote" },
    Define         = { links = "TSConditional" },
    Macro          = { links = "TSConditional" },
    PreProc        = { links = "TSKeyword" },
    Character      = { links = "TSStringRegex" },
    StorageClass   = { links = "cStorageClass" },
    Typedef        = { links = "TSType" },
    NonText        = { links = "TSVariable" },
    SpecialKey     = { links = "TSComment" },
    Special        = { links = "TSPunctSpecial" },
    Title          = { links = "TSKeyword" },

    -- Miscellaneous
    htmlLink          = { links = "TSURI" }, -- Hyperlinks.
    helpHyperTextJump = { links = "TSURI" }, -- Jump links in help
	}

  --[[
    @param groups string
    @return applies highlight based off properties in highlights table 
  ]]
  for group_name, property in pairs(syntax) do
    if property.links then
      vim.api.nvim_command(string.format(
        "highlight! link %s %s",

        group_name,
        property.links))
    else
      vim.api.nvim_command(string.format(
        "highlight %s guifg=%s",

        group_name, property.fg))
    end
  end

  require("palette").register({
    colors = {
      ["summer-time"] = {
        background = palette["background"],
        foreground = palette["foreground"],
        red        = palette["red"],
        green      = palette["green"],
        yellow     = palette["yellow"],
        blue       = palette["blue"],
        purple     = palette["purple"],
        accent     = palette["blue"],

        highlights = {
          PmenuSel  = { bg = blend(foreground, background, 0.85) },
          Visual    = { bg = blend(foreground, background, 0.85) },
          IncSearch = { bg = blend(foreground, background, 0.50) },
          Search    = { links = "Visual" },
        },
      },
    },
  })
end

return M
