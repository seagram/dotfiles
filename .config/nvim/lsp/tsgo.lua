---@type vim.lsp.Config
return {
    cmd = { 'tsgo', '--lsp', '--stdio' },
    filetypes = {
        'javascript',
    },
    root_markers = {
        'jsconfig.json',
        'package.json',
        '.git',
    },
}
