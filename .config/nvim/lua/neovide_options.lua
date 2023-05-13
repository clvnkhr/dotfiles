-- Put anything you want to happen only in Neovide here
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

-- local color = require("onedarkpro.helpers")
--
-- local colors = color.get_preloaded_colors()

-- -- Helper function for transparency formatting
-- local alpha = function()
--   return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
-- end
-- -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
-- vim.g.neovide_transparency = 0.0
-- vim.g.transparency = 0.9
-- vim.g.neovide_background_color = colors.bg .. alpha()
