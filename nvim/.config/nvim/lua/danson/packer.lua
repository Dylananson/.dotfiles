local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use "sbdchd/neoformat"


  use 'folke/tokyonight.nvim'

  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/nvim-cmp")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use("glepnir/lspsaga.nvim")
  use 'folke/lsp-colors.nvim'
  use 'pantharshit00/vim-prisma'
 

  use 'numToStr/Comment.nvim'

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate",
  }

  use 'JoosepAlviste/nvim-ts-context-commentstring'


  use("nvim-treesitter/playground")
  use("romgrk/nvim-treesitter-context")

  use "nvim-lua/plenary.nvim"

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  use('MunifTanjim/eslint.nvim')
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

