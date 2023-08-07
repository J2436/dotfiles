return {
	'numToStr/Comment.nvim',
	config = function ()
		require("Comment").setup {
			opleader = {
				line = "gc",
				block = "gb"
			}
		}
	end
}
