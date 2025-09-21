local M = {}

local term_buf = nil
local last_cmd = nil

local function is_term_buf_visible()
	local tabpage_wins = vim.api.nvim_tabpage_list_wins(0)
	for _, win in ipairs(tabpage_wins) do
		local buf = vim.api.nvim_win_get_buf(win)

		if buf == term_buf then
			return buf
		end
	end
	return nil
end

function M.toggle_terminal()
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.cmd("buffer " .. term_buf)
	else
		vim.cmd.term()
		term_buf = vim.api.nvim_get_current_buf()
		vim.cmd("startinsert")
	end
end

function M.toggle_split_terminal()
	local t_win = is_term_buf_visible()
	if t_win ~= nil then
		vim.api.nvim_set_current_win(t_win)
	else
		vim.cmd.new()
		vim.cmd.wincmd("L")
		vim.wo.winfixheight = true
		M.toggle_terminal()
	end
end

function M.send_command(cmd)
	last_cmd = cmd

	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.api.nvim_chan_send(vim.bo[term_buf].channel, cmd .. "\n")
	end
	local term_win = vim.fn.bufwinid(term_buf)
	if term_win ~= -1 then
		vim.api.nvim_win_call(term_win, function()
			vim.cmd("normal! G")
		end)
	end
end

function M.toggle_terminal_insert()
	M.toggle_split_terminal()
	vim.cmd("startinsert")
end

local function create_cmd_window()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = 50
	local height = 1

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		border = "single",
	})
	vim.cmd("startinsert")

	vim.keymap.set("i", "<esc>", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf })

	return { buffer = buf, window = win }
end

local function send_to_terminal(on_submit)
	local res = create_cmd_window()
	local buf = res.buffer
	local win = res.window

	vim.keymap.set("i", "<CR>", function()
		local input = vim.api.nvim_get_current_line()
		vim.api.nvim_win_close(win, true)
		on_submit(input)
	end, { buffer = buf })
end

function M.send_to_split()
	local function on_submit(input)
		local b_win = vim.api.nvim_get_current_win()
		M.toggle_split_terminal()
		M.send_command(input)
		if vim.api.nvim_win_is_valid(b_win) then
			vim.api.nvim_set_current_win(b_win)
			vim.cmd("stopinsert")
		end
	end

	send_to_terminal(on_submit)
end

function M.send_to_terminal()
	local function on_submit(input)
		M.toggle_terminal()
		M.send_command(input)
		vim.cmd("startinsert")
	end
	send_to_terminal(on_submit)
end

local function repeat_terminal_cmd()
	if last_cmd ~= nil then
		M.send_command(last_cmd)
	end
end

function M.repeat_buf()
	M.toggle_terminal()
	repeat_terminal_cmd()
end

function M.repeat_cmd_to_split()
	local curr_win = vim.api.nvim_get_current_win()
	M.toggle_split_terminal()
	repeat_terminal_cmd()
	vim.api.nvim_set_current_win(curr_win)
end

vim.keymap.set("n", "<leader>Tf", M.toggle_terminal)
vim.keymap.set("n", "<leader>Tt", M.send_to_terminal)
vim.keymap.set("n", "<leader>ts", M.toggle_split_terminal)
vim.keymap.set("n", "<leader>tt", M.send_to_split)
vim.keymap.set("n", "<leader>t.", M.repeat_cmd_to_split)
vim.keymap.set("n", "<leader>T.", M.repeat_buf)
