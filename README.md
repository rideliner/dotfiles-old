
## install

```sh
git clone https://github.com/rideliner/dotfiles.git <local-repo-dir>
```

## bootstrap

Modify ~/.dot.conf to include your desired modules (listed below):

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
- __<module>/.meta__: metadata about the module

## zsh file load order
- `/etc/zshenv`
- `~/.zshenv`
- `/etc/zprofile`
- `~/.zprofile` _managed_
- `/etc/zshrc`
- `~/.dot.conf` - module config
- `~/.dot.pre` - personal config before
- `~/.zshrc` _managed_
- `~/.dot.post` - personal config after
- `/etc/zlogin`
- `~/.zlogin`
- `~/.zlogout`
- `/etc/zlogout`
