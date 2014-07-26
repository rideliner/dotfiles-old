

## install

```sh
git clone https://github.com/rideliner/dotfiles.git <local-repo-dir>
cd <local-repo-dir>
./bootstrap.sh
```

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
