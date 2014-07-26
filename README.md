
## install

```sh
git clone https://github.com/rideliner/dotfiles.git <local-repo-dir>
```

## bootstrap

```sh
./bootstrap.sh --all | <mod>...
```

- `--all`
  symlink all modules available
- `<mod>...`
  symlink the specified modules if available

## components

- **\*/*\.zsh**:
- **\*/path.zsh**:
- **\*/completion.zsh**:
- **\*/\*.symlink**:

## zsh file load order
- /etc/zshenv
- ~/.zshenv
- /etc/zprofile
- ~/.zprofile
- /etc/zshrc
- ~/.local-rc
- ~/.zshrc
- ~/.local+rc
- /etc/zlogin
- ~/.zlogin
- ~/.zlogout
- /etc/zlogout

## modules
- zsh (always loaded)
- tmux
- git
- ruby
- rvm
- terminal
- ssh
- server
- colostate
- fonts

## using a module
In your ~/.local-rc file:

    zstyle ':ride' modules <mod>...

Ex.

    zstyle ':ride' modules ruby rvm git
