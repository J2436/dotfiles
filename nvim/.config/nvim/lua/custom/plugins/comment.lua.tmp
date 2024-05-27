return {
	'numToStr/Comment.nvim',
	config = function ()
		require("Comment").setup {
			opleader = {
				line = "gc",
				block = "gb"
			}
		}
		
		local api = require("Comment.api")
		-- Toggle current line (linewise) using C-/
		vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)

		-- Toggle current line (blockwise) using C-\
		vim.keymap.set('n', '<C-\\>', api.toggle.blockwise.current)

		-- Toggle lines (linewise) with dot-repeat support
		-- Example: <leader>gc3j will comment 4 lines
		vim.keymap.set(
				'n', '<leader>gc', api.call('toggle.linewise', 'g@'),
				{ expr = true }
		)

		local esc = vim.api.nvim_replace_termcodes(
				'<ESC>', true, false, true
		)
		-- Toggle selection (linewise)
		vim.keymap.set('x', '<C-_>', function()
				vim.api.nvim_feedkeys(esc, 'nx', false)
				api.toggle.linewise(vim.fn.visualmode())
		end)

		-- Toggle selection (blockwise)
		vim.keymap.set('x', '<C-\\>', function()
				vim.api.nvim_feedkeys(esc, 'nx', false)
				api.toggle.blockwise(vim.fn.visualmode())
		end)
	end
}
