return {
    "mbbill/undotree",
    config = function(_, opts)
        vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
    end,
}
