local transforms = require "camelsnek.transforms"

local modify_selection = require("camelsnek.modify").modify_selection
local modify_cword = require("camelsnek.modify").modify_cword

---@param transform fun(text: string): string
local function make_api(transform)
  return function()
    if vim.fn.mode() == "v" then
      modify_selection(transform)
    else
      modify_cword(transform)
    end
  end
end

return {
  snek = make_api(transforms.snek),
  screm = make_api(transforms.screm),
  kebab = make_api(transforms.kebab),
  camel = make_api(transforms.camel),
  pascal = make_api(transforms.pascal),
}
