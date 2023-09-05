--[[ vim.cmd [[ ]]
--[[ try ]]
--[[   colorscheme darkplus ]]
--[[ catch /^Vim\%((\a\+)\)\=:E185/ ]]
--[[   colorscheme default ]]
--[[   set background=dark ]]
--[[ endtry ]]
--[[ ]] 


function ColorMyPencils(color)
  color = color or 'gruvbox'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" });
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" });
end

ColorMyPencils('darkplus')
