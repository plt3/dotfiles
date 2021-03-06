require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "javascript", "lua", "bash", "cpp", "css", "html", "dockerfile", "json", "latex", "yaml", "java", "go" },
  highlight = {
    enable = true,
    disable = { "latex" }, -- latex highlighting always crashes
  },
  indent = {
    enable = true,
    disable = { "python" }, -- python treesitter indentation seems to be buggy
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  }
}
