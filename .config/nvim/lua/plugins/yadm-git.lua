vim.cmd [[
let g:yadm_git_enabled = 1
let g:yadm_git_verbose = 0

let g:yadm_git_fugitive_enabled = 1
let g:yadm_git_gitgutter_enabled = 0

let g:yadm_git_repo_path = "~/.local/share/yadm/repo.git"
let g:yadm_git_default_git_path = "git"
  ]]
return {
  "seanbreckenridge/yadm-git.vim",
}
