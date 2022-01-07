require('lualine').setup{
  options = {
    theme = 'gruvbox',
    section_separators = {'', ''},
    component_separators = {'', ''},
    icons_enabled = false,
  },
  sections = {
    lualine_a = { {'mode', upper = true} },
    lualine_b = { {'branch', icon = '', separator = '|'}, {'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_c = { {'filename', file_status = true, path = 1 } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}
