require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-sleuth'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'romainl/vim-cool'
    use 'tpope/vim-fugitive'
    use 'szw/vim-maximizer'
    use 'jiangmiao/auto-pairs'
    use 'unblevable/quick-scope'
    use 'airblade/vim-rooter'
    use 'lervag/vimtex'
    use 'christoomey/vim-tmux-navigator'
    use 'vimwiki/vimwiki'
    use 'preservim/vimux'
    use 'numToStr/Comment.nvim'
    use 'phaazon/hop.nvim'
    use 'karb94/neoscroll.nvim'
    use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}
    use 'folke/tokyonight.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = 'nvim-lua/plenary.nvim'
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update{ with_sync = true })
        end
    }
    use 'p00f/nvim-ts-rainbow'
    use 'lukas-reineke/indent-blankline.nvim'
end)