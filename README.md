
## install

```sh
git clone https://github.com/rideliner/dotfiles.git <local-repo-dir>
```

## bootstrap

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
- `~/.zshrc` _managed_
- `/etc/zlogin`
- `~/.zlogin`
- `~/.zlogout`
- `/etc/zlogout`
