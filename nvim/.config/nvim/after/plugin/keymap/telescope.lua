local Remap = require("danson.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-p>", function()
    require('telescope.builtin').git_files()
end)


nnoremap ("<leader>ff",function()
    require('telescope.builtin').find_files()
end)

nnoremap ("<leader>fg",function()
    require('telescope.builtin').live_grep()
end)

nnoremap ("<leader>fb",function()
    require('telescope.builtin').buffers()
end)
nnoremap ("<leader>fh",function()
    require('telescope.builtin').help_tags()
end)
