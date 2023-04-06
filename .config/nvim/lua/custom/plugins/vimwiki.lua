return {
  'vimwiki/vimwiki',
  config = function()
    vim.cmd([[
      set nocompatible
      filetype plugin on
      syntax on
      let wiki_1 = {'path': '~/Documents/GitHub/Coding-Notes/', 'path_html': '~/Documents/GitHub/Coding-Notes_html'}
      let g:vimwiki_list = [wiki_1, {'auto_diary_index': 1}]
      ]])
  end
}
