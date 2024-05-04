local M = {}

local sta, B = pcall(require, 'dp_base')

if not sta then return print('Dp_base is required!', debug.getinfo(1)['source']) end

if B.check_plugins {
      'folke/which-key.nvim',
    } then
  return
end

function M.temp_map_jump_mark()
  B.temp_map {
    { 'k', function() M.prev() end, mode = { 'n', 'v', }, silent = true, desc = 'marks: prev', },
    { 'j', function() M.next() end, mode = { 'n', 'v', }, silent = true, desc = 'marks: next', },
  }
end

function M.next()
  M.temp_map_jump_mark()
  require 'marks'.next()
end

function M.prev()
  M.temp_map_jump_mark()
  require 'marks'.prev()
end

require 'marks'.setup {
  mappings = {},
  default_mappings = {},
}

require 'which-key'.register {
  ['<leader>mm'] = { name = 'marks', },
  ['<leader>mmj'] = { function() M.next() end, 'marks: next', mode = { 'n', 'v', }, silent = true, },
  ['<leader>mmk'] = { function() M.prev() end, 'marks: prev', mode = { 'n', 'v', }, silent = true, },
  ['<leader>mmn'] = { function() require 'marks'.set_next() end, 'marks: set_next', mode = { 'n', 'v', }, silent = true, },
  ['<leader>mm<leader>'] = { function() require 'marks'.toggle() end, 'marks: toggle', mode = { 'n', 'v', }, silent = true, },
  ['<leader>mmd'] = { name = 'marks.delete', },
  ['<leader>mmdl'] = { function() require 'marks'.delete_line() end, 'marks.delete: line', mode = { 'n', 'v', }, silent = true, },
  ['<leader>mmdb'] = { function() require 'marks'.delete_buf() end, 'marks.delete: buf', mode = { 'n', 'v', }, silent = true, },
}

return M
