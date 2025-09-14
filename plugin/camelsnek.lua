local transforms = require "camelsnek.transforms"

local modify_selection = require("camelsnek.modify").modify_selection
local modify_cword = require("camelsnek.modify").modify_cword

---@param transform fun(text: string): string
local function make_command(transform)
  ---@param opts vim.api.keyset.create_user_command.command_args
  return function(opts)
    if opts.range == 0 then
      modify_cword(transform)
    else
      vim.cmd "normal! gv"
      modify_selection(transform)
    end
  end
end

vim.api.nvim_create_user_command(
  "Snek",
  make_command(transforms.snek),
  { range = true, desc = "Convert to snake_case" }
)

vim.api.nvim_create_user_command(
  "Screm",
  make_command(transforms.screm),
  { range = true, desc = "Convert to SCREAM_CASE" }
)

vim.api.nvim_create_user_command(
  "Kebab",
  make_command(transforms.kebab),
  { range = true, desc = "Convert to kebab-case" }
)

vim.api.nvim_create_user_command(
  "Camel",
  make_command(transforms.camel),
  { range = true, desc = "Convert to camelCase" }
)

vim.api.nvim_create_user_command(
  "Pascal",
  make_command(transforms.pascal),
  { range = true, desc = "Convert to PascalCase" }
)
