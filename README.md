
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

- __<module>/\*.zsh__ : file sourced by ~/.zshrc
- __<module>/\*.path__ : path environment for the module
- __<module>/\*.completion__ : completion scripts for the module
- __<module>/\*.symlink__ :  file or directory to be symlinked to home
- __<module>/\*.bootstrap__ : script to be run when bootstrap is run

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
  - `':ride' modules` - space separated list of modules
- tmux
- git
- ruby
- rvm
- terminal
  - `':ride:config:terminal:prompt' char` - character to start the prompt
  - `':ride:config:terminal:prompt' color` - color of the above character
- ssh
- server
- colostate
- fonts
- keys
