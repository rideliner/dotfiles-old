
## install

```sh
git clone https://github.com/rideliner/dotfiles.git <local-repo-dir>
```

## bootstrap

Modify ~/.dot to include your desired modules (listed below):

    zstyle ':ride' modules <mod>...

Ex.

    zstyle ':ride' modules ruby rvm git

```sh
./bootstrap.sh
```

## components

- __\*/\*.zsh__ : file sourced by ~/.zshrc
- __\*/path.zsh__ : path environment for the module
- __\*/completion.zsh__ : completion scripts for the module
- __\*/\*.symlink__ :  file or directory to be symlinked to home
- __\*/\*.bootstrap__ : script to be run when bootstrap is run

## zsh file load order
- `/etc/zshenv`
- `~/.zshenv`
- `/etc/zprofile`
- `~/.zprofile` _managed_
- `/etc/zshrc`
- `~/.dot` - module config
- `~/.local-rc` - personal config before
- `~/.zshrc` _managed_
- `~/.local+rc` - personal config after
- `/etc/zlogin`
- `~/.zlogin`
- `~/.zlogout`
- `/etc/zlogout`

## modules
- zsh (always loaded; first)
- tmux
- git
- ruby
- rvm
- terminal
- ssh
- server
- colostate
- fonts
