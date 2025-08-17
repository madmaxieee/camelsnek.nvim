# camelsnek.nvim

A lua port of [vim-camelsnek](https://github.com/nicwest/vim-camelsnek).

## Installation

```lua
{
    "madmaxieee/camelsnek.nvim",
    cmd = {
      "Snek",
      "Screm",
      "Camel",
      "Pascal",
      "Kebab",
    },
    opts = {}, -- no options required
}
```

## Usage

### Commands

- `:Snek` - Convert the word under the cursor to snake_case.
- `:Screm` - Convert the word under the cursor to SCREAM_CASE
- `:Camel` - Convert the word under the cursor to camelCase.
- `:Pascal` - Convert the word under the cursor to PascalCase.
- `:Kebab` - Convert the word under the cursor to kebab-case.

These commands can be used in visual mode as well, to convert the selected text.

### Keymaps

Define your own keymaps like this:

```lua
vim.keymap.set("n", "<leader>cs", "<cmd>Snek<cr>", { desc = "Convert to snake_case" })
```

### Lua API

You can also use the functions directly in Lua:

```lua
require("camelsnek").snek() -- Convert to snake_case
```
