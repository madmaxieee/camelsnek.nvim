local transforms = require "camelsnek.transforms"

local M = {}

---@param transform fun(text: string): string Function to modify the selection
local function modify_selection(transform)
  local orig_selection = vim.fn.getreg "s"

  vim.cmd 'normal! "sy'
  local selection = vim.fn.getreg "s"
  if selection == "" then
    return
  end

  local new_word = transform(selection)
  vim.fn.setreg("s", new_word)

  vim.cmd 'normal! gv"sP'

  vim.fn.setreg("s", orig_selection) -- Restore original selection
end

---@param transform fun(text: string) Function to modify the word
local function modify_cword(transform)
  vim.cmd "normal! viw"
  modify_selection(transform)
end

function M.snek()
  if vim.fn.mode() == "v" then
    modify_selection(transforms.snek)
  else
    modify_cword(transforms.snek)
  end
end

function M.screm()
  if vim.fn.mode() == "v" then
    modify_selection(transforms.screm)
  else
    modify_cword(transforms.screm)
  end
end

function M.kebab()
  if vim.fn.mode() == "v" then
    modify_selection(transforms.kebab)
  else
    modify_cword(transforms.kebab)
  end
end

function M.camel()
  if vim.fn.mode() == "v" then
    modify_selection(transforms.camel)
  else
    modify_cword(transforms.camel)
  end
end

function M.pascal()
  if vim.fn.mode() == "v" then
    modify_selection(transforms.pascal)
  else
    modify_cword(transforms.pascal)
  end
end

function M.setup()
  vim.api.nvim_create_user_command("Snek", function(opts)
    if opts.range == 0 then
      modify_cword(transforms.snek)
    else
      vim.cmd "normal! gv"
      modify_selection(transforms.snek)
    end
  end, {
    range = true,
    desc = "Convert to snake_case",
  })

  vim.api.nvim_create_user_command("Screm", function(opts)
    if opts.range == 0 then
      modify_cword(transforms.screm)
    else
      vim.cmd "normal! gv"
      modify_selection(transforms.screm)
    end
  end, {
    range = true,
    desc = "Convert to SCREAM_CASE",
  })

  vim.api.nvim_create_user_command("Kebab", function(opts)
    if opts.range == 0 then
      modify_cword(transforms.kebab)
    else
      vim.cmd "normal! gv"
      modify_selection(transforms.kebab)
    end
  end, {
    range = true,
    desc = "Convert to kebab-case",
  })

  vim.api.nvim_create_user_command("Camel", function(opts)
    if opts.range == 0 then
      modify_cword(transforms.camel)
    else
      vim.cmd "normal! gv"
      modify_selection(transforms.camel)
    end
  end, {
    range = true,
    desc = "Convert to camelCase",
  })

  vim.api.nvim_create_user_command("Pascal", function(opts)
    if opts.range == 0 then
      modify_cword(transforms.pascal)
    else
      vim.cmd "normal! gv"
      modify_selection(transforms.pascal)
    end
  end, {
    range = true,
    desc = "Convert to PascalCase",
  })
end

return M
