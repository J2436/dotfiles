return {
	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
		config = function()
			require('telescope').setup {
				defaults = {
					mappings = {
						i = {
							['<C-u>'] = false,
							['<C-d>'] = false,
						},
					},
					file_ignore_patterns = {
						"node_modules",
						"dist",
						"build",
						"package%-lock.json",
						".git"
					},
					-- layout_strategy = 'vertical',
					layout_config = {
						vertical = { width = 0.9, preview_height = 0.7 },
						horizontal = { width = .95, preview_width = 0.6 }
					}
				},
				pickers = {
					git_branches = {
						previewer = false,
						layout_config = {
							prompt_position = "top",
							width = 0.5,
							height = 0.5
						}
					}
				}
			}

			-- Enable telescope fzf native, if installed
			pcall(require('telescope').load_extension, 'fzf')

			-- See `:help telescope.builtin`
			vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
			vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
			vim.keymap.set('n', '<leader>/', function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					-- winblend = 10,
					previewer = false,
				})
			end, { desc = '[/] Fuzzily search in current buffer' })

			-- LSP
			vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = '[F]ind [S]ymbols' })

			vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
			vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = 'Search [G]it [B]ranches' })
			vim.keymap.set('n', '<leader>fd',
				function()
					require('telescope.builtin').find_files({
						hidden = true
					})
				end,
				{ desc = '[F]ind [F]iles' })
			vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
			vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
			vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
			vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
			vim.keymap.set('n', '<leader>gs', function()
				require('telescope.builtin').git_status({
					layout_strategy = 'vertical',
					layout_config = {
						vertical = { width = 0.9, preview_height = 0.7 }
					}
				})
			end, { desc = '[G]it [S]tatus' })

			-- Custom
			vim.keymap.set('n', '<leader>sn', function()
				require('telescope.builtin').find_files(require('telescope.themes').get_dropdown {
					cwd = '~/.config/nvim',
					prompt_title = 'Nvim Dotfiles',
					hidden = true,
					previewer = false
				})
			end, { desc = 'Search for nvim config files' })
		end
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},
}
