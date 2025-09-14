local M = {}

---@param transform fun(text: string): string Function to modify the selection
function M.modify_selection(transform)
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
function M.modify_cword(transform)
  vim.cmd "normal! viw"
  M.modify_selection(transform)
end

return M
