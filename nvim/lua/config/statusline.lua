local fn = vim.fn
local api = vim.api

local modes = {
	["n"] = "normal",
	["no"] = "normal",
	["v"] = "visual",
	["V"] = "visual line",
	[""] = "visual block",
	["s"] = "select",
	["S"] = "select line",
	[""] = "select block",
	["i"] = "insert",
	["ic"] = "insert",
	["R"] = "replace",
	["Rv"] = "visual replace",
	["c"] = "command",
	["cv"] = "vim ex",
	["ce"] = "ex",
	["r"] = "prompt",
	["rm"] = "moar",
	["r?"] = "confirm",
	["!"] = "shell",
	["t"] = "terminal",
}

local function mode()
	local current_mode = api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode])
end

vim.api.nvim_set_hl(0, "NormalMode", { fg = "#fce8c3" })
vim.api.nvim_set_hl(0, "InsertMode", { fg = "#ffaf87" })
vim.api.nvim_set_hl(0, "VisualMode", { fg = "#ffaf87" })
vim.api.nvim_set_hl(0, "ReplaceMode", { fg = "#ff8787" })
vim.api.nvim_set_hl(0, "CmdLineMode", { fg = "#ff8787" })
vim.api.nvim_set_hl(0, "TerminalMode", { fg = "#87dfff" })

local function update_mode_colors()
	local current_mode = api.nvim_get_mode().mode
	local mode_color = "%#NormalMode#"
	if current_mode == "n" then
		mode_color = "%#NormalMode#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#InsertMode#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#VisualMode#"
	elseif current_mode == "R" then
		mode_color = "%#ReplaceMode#"
	elseif current_mode == "c" then
		mode_color = "%#CmdLineMode#"
	elseif current_mode == "t" then
		mode_color = "%#TerminalMode#"
	end
	return mode_color
end

local function filepath()
	local fpath = fn.fnamemodify(fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

Statusline = {}

Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		update_mode_colors(),
		mode(),
		"%#Normal# ",
		filepath(),
		filename(),
		"%#Normal#",
		lsp(),
	})
end

function Statusline.inactive()
	return " %F"
end

vim.opt.statusline = "%!v:lua.Statusline.active()"

local augroup = vim.api.nvim_create_augroup("StatuslineGroup", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	pattern = "*",
	group = augroup,
	command = "setlocal statusline=%!v:lua.Statusline.active()",
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	pattern = "*",
	group = augroup,
	command = "setlocal statusline=%!v:lua.Statusline.inactive()",
})
