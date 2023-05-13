return {
  "itchyny/calendar.vim",
  config = function()
    vim.cmd [[
    autocmd FileType calendar nmap <buffer> <CR> :<C-u>call vimwiki#diary#calendar_action(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), "V")<CR>
   ]]
  end
}
