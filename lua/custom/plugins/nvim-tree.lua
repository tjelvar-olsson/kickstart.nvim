return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}
    vim.keymap.set({ 'n', 'i' }, '<C-n>', '<cmd>NvimTreeToggle<cr>', { desc = 'nvimtree toggle window' })
    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<cr>', { desc = 'nvimtree focus window' })
  end,
}
