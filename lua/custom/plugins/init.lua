-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function ScrollBar()
  local curr_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)
  local i = math.floor((curr_line - 1) / lines * #SCROLL_BAR) + 1
  return '%#String#' .. string.rep(SCROLL_BAR[i], 2) -- I add '%#String#' here
end
return {
  {
    'levouh/tint.nvim',
    config = function()
      -- Override some defaults
      require('tint').setup {
        tint = -45, -- Darken colors, use a positive value to brighten
        saturation = 0.6, -- Saturation to preserve
        transforms = require('tint').transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
        tint_background_colors = true, -- Tint background portions of highlight groups
        highlight_ignore_patterns = { 'WinSeparator', 'Status.*' }, -- Highlight group patterns to ignore, see `string.find`
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_buf_get_option(bufid, 'buftype')
          local floating = vim.api.nvim_win_get_config(winid).relative ~= ''

          -- Do not tint `terminal` or floating windows, tint everything else
          return buftype == floating --"terminal" or
        end,
      }
    end,
  },
  {
    'mvllow/modes.nvim',
    config = function()
      require('modes').setup {
        colors = {
          copy = '#DC9A0C',
          delete = '#C73000',
          insert = '#006600',
          visual = '#9745be',
          default = '#FFFFFF',
          normal = 'white',
        },

        -- Set opacity for cursorline and number background
        line_opacity = 0.5,

        -- Enable cursor highlights
        set_cursor = true,

        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = true,

        -- Enable line number highlights to match cursorline
        set_number = true,

        -- Disable modes highlights in specified filetypes
        -- Please PR commonly ignored filetypes
        ignore_filetypes = { 'NvimTree', 'TelescopePrompt' },
      }
    end,
    vim.opt.guicursor:append 'n-c:block-Cursor',
  },
  {
    'github/copilot.vim',
    config = function()
      vim.cmd [[Copilot disable]]

      -- Keybinding to toggle Copilot
      vim.keymap.set('n', '<leader>cp', function()
        vim.cmd [[Copilot toggle]]
      end, { noremap = true, silent = true, desc = 'Toggle Copilot' })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require('bufferline').setup {}
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diagnostics' },
          lualine_c = { 'filename' },
          --lualine_x = { 'filetype', 'encoding' }, -- "fileformat",
          --lualine_y = { "progress" },
          lualine_z = { 'location', ScrollBar },
          lualine_x = {
            'copilot',
            'encoding',
            'fileformat',
            'filetype',
          },

          --inactive_sections = {
          --	lualine_a = {},
          --	lualine_b = {},
          --	lualine_c = { "filename" },
          --	lualine_x = { "location" },
          --	lualine_y = {},
          --a	lualine_z = {},
          --},
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {},
        },
      }
    end,
  },
  { 'ofseed/copilot-status.nvim' },
  --{ 'AndreM222/copilot-lualine' },
  { -- know what is possible at the command line
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require 'wilder'
      wilder.setup { modes = { ':', '/', '?' } }
    end,
  },

  { -- shows the colors in files e.g. #CCAA33
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'odysseusOperator/start.nvim', --hack and copy
    config = function()
      -- lua
      require('start').set_background_ascii(require('start').default_ascii_1)
    end,
  },
  -- {
  --   'ThePrimeagen/harpoon',
  --   branch = 'harpoon2',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  --   config = function()
  --     local harpoon = require 'harpoon'
  --     -- REQUIRED
  --     harpoon:setup()
  --     -- REQUIRED
  --
  --     vim.keymap.set('n', '<leader>a', function()
  --       harpoon:list():add()
  --     end)
  --     vim.keymap.set('n', '<C-e>', function()
  --       harpoon.ui:toggle_quick_menu(harpoon:list())
  --     end)
  --
  --     vim.keymap.set('n', '<C-h>', function()
  --       harpoon:list():select(1)
  --     end)
  --     vim.keymap.set('n', '<C-j>', function()
  --       harpoon:list():select(2)
  --     end)
  --     vim.keymap.set('n', '<C-k>', function()
  --       harpoon:list():select(3)
  --     end)
  --     vim.keymap.set('n', '<C-l>', function()
  --       harpoon:list():select(4)
  --     end)
  --
  --     -- Toggle previous & next buffers stored within Harpoon list
  --     vim.keymap.set('n', '<leader>p', function()
  --       harpoon:list():prev()
  --     end)
  --     vim.keymap.set('n', '<leader>n', function()
  --       harpoon:list():next()
  --     end)
  --
  --     vim.keymap.set('n', '<leader><left>', ':bp<CR>')
  --     vim.keymap.set('n', '<leader><right>', ':bn<CR>')
  --   end,
  -- },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    config = function()
      local chat = require 'CopilotChat'
      chat.setup()
      vim.keymap.set({ 'n' }, '<leader>aa', chat.toggle, { desc = 'AI Toggle' })
      vim.keymap.set({ 'v' }, '<leader>aa', chat.open, { desc = 'AI Open' })
      vim.keymap.set({ 'n' }, '<leader>ax', chat.reset, { desc = 'AI Reset' })
      vim.keymap.set({ 'n' }, '<leader>as', chat.stop, { desc = 'AI Stop' })
      vim.keymap.set({ 'n' }, '<leader>am', chat.select_model, { desc = 'AI Model' })
      vim.keymap.set('n', '<leader>ar', ':CopilotChatFix<CR>', { desc = 'AI Fix' })

      vim.keymap.set('n', '<leader>at', ':CopilotChatTests<CR>', { desc = 'AI Tests' })
      vim.keymap.set('n', '<leader>ad', ':CopilotChatDocs<CR>', { desc = 'AI Docs' })
      vim.keymap.set('n', '<leader>ar', ':CopilotChatReview<CR>', { desc = 'AI Review' })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
} -- end of return
