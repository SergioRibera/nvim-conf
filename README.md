# Nvim Conf
Nvim-config is a tool that allows to have certain configurations outside the lua files giving more flexibility by being externally modifiable.

## Requisites
[Neovim (v0.5)](https://github.com/neovim/neovim/releases/tag/v0.5.0) or newer is required for `nvim-conf` to work.

## Installation
Using [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'SergioRibera/nvim-conf'
```

Using [dein](https://github.com/Shougo/dein.vim)

```viml
call dein#add('SergioRibera/nvim-conf')
```
Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'SergioRibera/nvim-conf'
```

## Setup
```lua
require("nvim-conf").setup {
    conf_file = vim.fn.stdpath('config') .. "/settings.conf",
    load_event = "setup",
    on_load = function (_)
    end,
}
```

### Default Setup
```lua
M.settings = {
    conf_file = vim.fn.stdpath('config') .. "/settings.conf", -- path to file where save all values
    load_event = "load", -- posibilities: load, setup, none
    on_load = function (_) -- on loaded data callback function
        print("Data Loaded success")
    end,
}
```

### Values and functions
| Functions                                   | Description                                                                                                               |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `get_value(key, default)`                   | Get value with key name or return default if not exists any value with key                                                |
| `set_value(key, value)`                     | Set value with key name and save into file config                                                                         |
| `load()`                                    | Load all data on file especified on setup or default options                                                              |
| `save()`                                    | Save all runtime values on internal values into file path in options                                                      |
| `setup(opts)`                               | Set the variables as default settings to excute and work plugin                                                           |

### Usage
```lua
-- Define as variable
local nvim_conf = require('nvim-conf')
-- Get value
local user_name = nvim_conf.get_value("user_name", "Nombre Por Defecto")

-- Define fake variable for example
local current_color_scheme = "ayu-night"

-- Set value and save in the file especified
nvim_conf.set_value("color_scheme", current_color_scheme)
```

File conf example

`~/.config/nvim/settings.conf`
```conf
user_name=SergioRibera
color_scheme=ayu-night
```
