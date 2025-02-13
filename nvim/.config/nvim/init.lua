vim.g.mapleader = ','
vim.g.maplocalleader = ' '

if vim.g.vscode then
  require "user.vscode_keymaps"
else
  -- Install package manager
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  -- NOTE: Here is where you install your plugins.
  --  You can configure plugins using the `config` key.
  --
  --  You can also configure plugins after the setup call,
  --    as they will be available in your neovim runtime.
  require('lazy').setup('plugins', {
    -- defaults = { lazy = true }
  })

  -- [[ Setting options ]]
  -- See `:help vim.o`
  -- NOTE: You can change these options as you wish!

  -- Set highlight on search
  vim.o.hlsearch = false

  -- Make line numbers default
  vim.wo.number = true
  vim.wo.relativenumber = true

  -- Enable mouse mode
  vim.o.mouse = 'a'

  -- Sync clipboard between OS and Neovim.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.o.clipboard = 'unnamedplus'

  -- Enable break indent
  vim.o.breakindent = true

  -- Save undo history
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or capital in search
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.wo.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250
  vim.o.timeout = true
  vim.o.timeoutlen = 300

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = 'menuone,noselect'

  -- NOTE: You should make sure your terminal supports this
  vim.o.termguicolors = true

  -- Disable word wrap
  vim.o.wrap = false

  -- Set scrolloff
  vim.o.scrolloff = 10

  -- [[ Basic Keymaps ]]

  -- Keymaps for better default experience
  -- See `:help vim.keymap.set()`
  vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

  -- Remap for dealing with word wrap
  vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Center when page down or page up
  vim.keymap.set('n', '<C-d>', '<C-d>zz')
  vim.keymap.set('n', '<C-u>', '<C-u>zz')

  -- Navigation
  vim.keymap.set('n', '<Tab>', '<C-^>')

  -- VimFugitive
  vim.keymap.set('n', '<leader>G', '<cmd>G<cr>', { silent = true })

  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })

  --[[ Yank to Keyboard by default ]]
  vim.o.clipboard = 'unnamed'

  -- [[ Disable auto comment on newline]]
  local formatGrp = vim.api.nvim_create_augroup("NewlineComment", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    command = "set formatoptions-=cro",
    group = formatGrp
  });


  --[[ FileType indent augroups ]]
  vim.api.nvim_create_augroup('setIndent', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = 'setIndent',
    pattern = { 'json', 'lua', 'html', 'css', 'scss', 'javascript', 'typescript', 'xml', 'cpp', 'javascriptreact', 'typescriptreact', 'markdown', '*' },
    command = "setlocal shiftwidth=2 tabstop=2"
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = 'setIndent',
    pattern = { 'java', 'cs', 'sql' },
    command = "setlocal shiftwidth=4 tabstop=4"
  })

  -- [[ Configure Treesitter ]]
  -- See `:help nvim-treesitter`

  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false
    }
  )

  vim.diagnostic.config(
    {
      float = {
        border = 'rounded',
        max_width = 100
      }
    }
  )


  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.

    if _.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr })
    end

    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
  end

  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })
  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.

  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = ""
    }
    vim.lsp.buf.execute_command(params)
  end

  local servers = {
    cssls = {},
    marksman = {},
    pyright = {},
    rust_analyzer = {},
    ts_ls = {
      typescript = {
        preferences = {
          quotePreference = 'single',
          importModuleSpecifierPreference = 'non-relative',
          disableSuggestions = false,
        },
        format = {
          semicolons = 'insert',
          trimTrailingWhitespace = true
        },
        inlayHints = {
          includeInlayEnumMemberValueHints = false,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayVariableTypeHints = false,
          includeInlayParameterNameHints = 'literals',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        }
      },
      javascript = {
        preferences = {
          quoteStyle = 'single',
          importModuleSpecifierPreference = 'non-relative',
          disableSuggestions = false,
        },
        format = {
          semicolons = 'insert',
          trimTrailingWhitespace = true
        },
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayParameterNameHints = 'literals',
        }
      }
    },
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true },
        diagnostics = {
          globals = { 'vim' }
        }
      },
    }
  }

  -- Setup neovim lua configuration
  if not vim.g.vscode then
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        if server_name == 'ts_ls'
        then
          server_name = 'tsserver'
        end

        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          commands = (server_name == 'tsserver' and { OrganizeImports = { organize_imports, description = "Organize Imports" } } or {})
        }
      end,
    }
  end

  -- Nicer hover borders
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = 'rounded',
    }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = 'rounded',
    }
  )

  -- The line beneath this is called `modeline`. See `:help modeline`
  -- vim: ts=2 sts=2 sw=2 et

  vim.keymap.set('n', '<leader>ex', function()
    local file_name = vim.api.nvim_buf_get_name(0)
    local file_extension = file_name:match("[^.]+$")
    local comp = nil
    if file_extension == 'js' or file_extension == 'ts' or file_extension == 'tsx' or file_extension == 'mjs' or file_extension == 'cjs' then
      comp = 'node'
    elseif file_extension == 'py' then
      comp = 'python3'
    elseif file_extension == 'lua' then
      comp = 'lua'
    elseif file_extension == 'java' then
      comp = 'java'
    elseif file_extension == 'cs' then
      comp = 'dotnet run'
    end
    return '<cmd>w | !' .. comp .. " " .. file_name .. '<CR>'
  end, { expr = true })

  vim.keymap.set('n', '<C-s>', '<cmd>w<CR>')

  -- DBUI
  vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<CR>')

  -- [ Highlight groups ]
  ---- TreeSitterContext
  vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { sp = 'Grey', underline = true })
  vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { sp = 'Grey', underline = true })
  vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = 'NONE' })

  ---- Cursor
  vim.api.nvim_set_hl(0, 'LineNr', { fg = "#ebdbb2", italic = true })
  vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = "#928374" })
  vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = "#928374" })

  -- SignColumn
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = "#0A0E14" })

  vim.api.nvim_set_hl(0, 'MoonbowGreenSign', { bg = "bg", fg = "#b8bb26" })
  vim.api.nvim_set_hl(0, 'MoonbowAquaSign', { bg = "bg", fg = "#8ec07c" })
  vim.api.nvim_set_hl(0, 'MoonbowRedSign', { bg = "bg", fg = "#fb4934" })
  vim.api.nvim_set_hl(0, 'MoonbowBlueSign', { bg = "bg", fg = "#83a598" })
  vim.api.nvim_set_hl(0, 'MoonbowYellowSign', { bg = "bg", fg = "#fabd2f" })
  vim.api.nvim_set_hl(0, 'MoonbowOrangeSign', { bg = "bg", fg = "#fe8019" })

  -- [ Commenting ]
  vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
  vim.keymap.set('v', '<C-_>', 'v_gc', { remap = true })
end
