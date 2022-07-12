local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.server_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=NONE gui=underline
        hi LspReferenceText cterm=bold ctermbg=red guibg=NONE gui=underline
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=NONE gui=underline
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

--vim.lsp.set_log_level("debug")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- delay update diagnostics
        update_in_insert = false,
    }
)

nvim_lsp.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls", "-remote=auto" },
    filetypes = { "go", "gomod" },
    root_dir = nvim_lsp.util.root_pattern("go.mod", ".git"),
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        gopls = {
            analyses = {
                nilness = true,
            },
            codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
        },
    },
}

nvim_lsp.lemminx.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "java", "-jar", "/home/rafal/.local/bin/org.eclipse.lemminx-uber.jar" },
    filetypes = {"xml", "xsd"},
    root_dir = nvim_lsp.util.root_pattern("go.mod", ".git"),
    settings = {
        xml = {
            catalogs = {"/home/rafal/form3/catalog.xml"},
        },
    },
}

--[[ nvim_lsp.terraformls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
} ]]

nvim_lsp.groovyls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"java", "-jar", "/home/rafal/lib/groovy-language-server/build/libs/groovy-language-server-all.jar"},
}

nvim_lsp.pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.ltex.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"tex", "bib" },
}

--[[ require('jdtls').start_or_attach({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "jdtls" },
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
}) ]]
