# dotfiles
organized with yadm

## Notes
  - bat replaces cat
  - exa replaces ls
  - gitui replaces lazygit
  - rtx replaces asdf
  - ripgrep replaces grep
  - zoxide replaces cd
  - pdm is like a modern poetry (PEP compliant)

## How to use

### Python: 
  - rtx to install versions
  - New Projects: pdm init to setup venv and then eval $(pdm venv activate)
  - Adding dependencies: instead of `pip`, use `pdm add`. See [pythonbynight blogpost](https://www.pythonbynight.com/blog/using-pdm-for-your-next-python) and [pdm docs ](http://pdm.fming.dev). For example
    - Jupyter: `pdm add notebook`


### Scala:
  - Install JVM
  - brew install coursier?
    - coursier doesn't install the arm64 version...?

## To do: 
  - [ ] use yadm to ease installation on new computers
  - [ ] list from brew and also app store apps?
  - [ ] describe hammerspoon scripts
  - [ ] test out yabai
