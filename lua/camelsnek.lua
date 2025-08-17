local M = {}

---PascalCase: First letter of each word capitalized
---@param text string
function M.pascal(text)
  local parts = {}
  for word in text:gmatch "[A-Za-z0-9]+" do
    table.insert(parts, word)
  end

  if #parts == 1 then
    return string.upper(parts[1]:sub(1, 1)) .. parts[1]:sub(2)
  elseif #parts < 1 then
    return text
  end

  local result = {}
  for _, word in ipairs(parts) do
    table.insert(result, string.upper(word:sub(1, 1)) .. string.lower(word:sub(2)))
  end
  return table.concat(result, "")
end

---camelCase: like PascalCase but first letter lowercase
---@param text string
function M.camel(text)
  local pascal = M.pascal(text)
  return string.lower(pascal:sub(1, 1)) .. pascal:sub(2)
end

---snake_case: lowercase, underscores between words
---@param text string
function M.snek(text)
  local t = text
  -- Replace non-alphanumeric with space
  t = t:gsub("[^A-Za-z0-9]", " ")
  -- Add space between non-lowercase followed by lowercase
  t = t:gsub("([^a-z])([a-z])", " %1%2")
  -- Add space between lowercase followed by non-lowercase
  t = t:gsub("([a-z])([^a-z])", "%1 %2")
  -- Trim spaces
  t = t:match "^%s*(.-)%s*$" or t
  -- Replace spaces or hyphens with underscores
  t = t:gsub("[%s%-]+", "_")
  return string.lower(t)
end

---kebab-case: like snake_case but with hyphens
---@param text string
function M.kebab(text)
  local t = M.snek(text)
  return t:gsub("_", "-")
end

---SCREAM_CASE: uppercase snake_case
---@param text string
function M.screm(text)
  local t = M.snek(text)
  return string.upper(t)
end

---@param transform fun(text: string) Function to modify the word
local function modify_cword(transform)
  local orig_selection = vim.fn.getreg "v"

  vim.cmd 'normal! "vyiw'
  local selection = vim.fn.getreg "v"
  if selection == "" then
    return
  end

  local new_word = transform(selection)
  vim.fn.setreg("v", new_word)

  vim.cmd 'normal! viw"vP'

  vim.fn.setreg("v", orig_selection) -- Restore original selection
end

---@param transform fun(text: string): string Function to modify the selection
local function modify_selection(transform)
  local orig_selection = vim.fn.getreg "v"

  vim.cmd 'normal! gv"vy'
  local selection = vim.fn.getreg "v"
  if selection == "" then
    return
  end

  local new_word = transform(selection)
  vim.fn.setreg("v", new_word)

  vim.cmd 'normal! gv"vP'

  vim.fn.setreg("v", orig_selection) -- Restore original selection
end

function M.setup()
  vim.api.nvim_create_user_command("Snek", function(opts)
    if opts.range == 0 then
      modify_cword(M.snek)
    else
      modify_selection(M.snek)
    end
  end, { range = true })

  vim.api.nvim_create_user_command("Screm", function(opts)
    if opts.range == 0 then
      modify_cword(M.screm)
    else
      modify_selection(M.screm)
    end
  end, { range = true })

  vim.api.nvim_create_user_command("Kebab", function(opts)
    if opts.range == 0 then
      modify_cword(M.kebab)
    else
      modify_selection(M.kebab)
    end
  end, { range = true })

  vim.api.nvim_create_user_command("Camel", function(opts)
    if opts.range == 0 then
      modify_cword(M.camel)
    else
      modify_selection(M.camel)
    end
  end, { range = true })

  vim.api.nvim_create_user_command("Pascal", function(opts)
    if opts.range == 0 then
      modify_cword(M.pascal)
    else
      modify_selection(M.pascal)
    end
  end, { range = true })
end

return M
