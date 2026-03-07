local ok, jdtls = pcall(require, 'jdtls')
if not ok then
  vim.notify('ftplugin/java.lua: nvim-jdtls not found, skipping LSP setup', vim.log.levels.WARN)
  return
end
local config = {
  -- jdtls installed through mason
  cmd = { vim.fn.expand '~/.local/share/kickstart.nvim/mason/bin/jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
jdtls.start_or_attach(config)
