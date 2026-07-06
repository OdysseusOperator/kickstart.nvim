# Neovim Troubleshooting

## Check error messages after startup

All errors that fired during startup or file open are stored in the message history:

```
:messages
```

## Check health of a plugin or subsystem

```
:checkhealth
:checkhealth nvim-treesitter
:checkhealth lsp
```

## Startup timing log

Shows every file sourced during startup and how long it took. Useful to spot slow or crashing scripts:

```
nvim --startuptime /tmp/nvim-startup.log
cat /tmp/nvim-startup.log
```

## LSP debug log

Enable verbose LSP logging, then inspect the log after reproducing the issue:

```lua
vim.lsp.set_log_level('debug')
```

Log file location:

```
~/.local/state/nvim/lsp.log
```

## Treesitter

Check which parsers are installed and their status:

```
:TSInstallInfo
```

Check if a parser loads for the current buffer:

```vim
:lua print(pcall(vim.treesitter.language.add, vim.bo.filetype))
```

Check if the highlighter is active for the current buffer:

```vim
:lua print(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil)
```

## ftplugin files

Files in `ftplugin/` run unconditionally whenever a matching filetype is detected,
outside the normal plugin loading lifecycle. A bare `require()` in these files will
crash silently and can break other things (like treesitter highlighting) without any
obvious error.

Always guard `require()` calls with `pcall` and notify explicitly on failure:

```lua
local ok, mod = pcall(require, 'some-module')
if not ok then
  vim.notify('ftplugin/foo.lua: some-module not found, skipping', vim.log.levels.WARN)
  return
end
```

## Run Neovim headless for quick diagnostics

```bash
nvim --headless -c "lua print('hello')" -c "q"
nvim --headless /tmp/Test.java -c "lua print(vim.bo.filetype)" -c "q"
```
