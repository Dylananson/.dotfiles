return {
	"ThePrimeagen/harpoon",
	lazy = false,
	config = function()
		local harpoon = require("harpoon")
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<leader>l", ui.toggle_quick_menu)

		vim.keymap.set("n", "<leader><C-j>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<leader><C-k>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<leader><C-l>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<leader><C-;>", function()
			ui.nav_file(4)
		end)
		harpoon.setup({})
	end,
}
