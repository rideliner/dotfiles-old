
## Module format

Any directory in the dotfiles repo is considered to be a module unless it starts with a period (.).

A module could have files/directories of the following format:

- `<file>.zsh`
  - A file that is loaded upon each zsh instance
- `<file>.symlink`
  - A file that is to be symlinked
- `<dir>.symlink/`
  - A directory that is to be symlinked
- `<file>.bootstrap`
  - A script to be executed during each run of bootstrap.sh
- `<file>.path`
  - Contains modifications to the path environment variable
- `<file>.completion`
  - Contains modifications to the zsh completion system

### Dependencies

Modules are loaded in the order that they are specified in the .dot file. Any dependencies are loaded immediately prior to the first module in the list that depends on it.

Prerequisites will be recursively checked.
NOTE: This could make a dependency be loaded earlier than expected.

A dependency is specified in the module's .meta file using the following syntax:

```
zstyle ':ride:depend' <module> <depended-modules>...
```

NOTE: This should only appear once in the .meta file and should contain a space separated list of the dependencies in the desired order.

### Loading

The order that .zsh files, .path files, and .completion files are loaded on a per module basis can be controlled through the .meta file.

The files are loaded in the general order of `.path` > `.zsh` > `.completion`.

If any files are not specified, they are added to the end of their respective list in alphanumeric order.

To control the order of the files, use the appropriate format from the following:

```
zstyle ':ride:order:<module>' zsh <filename>...
zstyle ':ride:order:<module>' path <filename>...
zstyle ':ride:order:<module>' completion <filename>...
```

NOTE: Each of the above should appear at most once in the .meta file and should contain a space separated list of the files in the desired order.
NOTE: Leave out the extensions (i.e. .path, .zsh, and .completion) from the filename.

### Symlinks

Each symlink should have a corresponding entry in the .meta file stating where the symlink should go.
If no entry is found for a given file or directory, a symlink of <file>.symlink will be defaulted to ~/.<file> and a symlink of <dir>.symlink/ will be defaulted to ~/.<dir>/

An entry in the module's .meta file should look like:
```
zstyle ':ride:symlink:<module>' <file/dir> <location>
```

i.e., ~/.gitconfig pointing to the config.symlink file in the git module would look like:
```
zstyle ':ride:symlink:git' ignore ~/.gitignore
```

NOTE: Leave out the .symlink extension from the module's file.

WARNING: Unexpected results if a file symlink and a directory symlink have the same name. Most OSes don't allow it, but worth noting.

### Configuring

The amount of configuration offered by each module will vary, possibly with no configuration offered.

All configuration should be stored in the .dot file in the following format:

```
zstyle ':ride:config:<module>' <key> <value(s)>...
# The module may split the configuration into categories:
zstyle ':ride:config:<module>:<category>' <key> <value(s)>...
# It may even have chained subcategories (not likely unless it has a lot of config)
zstyle ':ride:config:<module>:<category>:<sub-cat>:<sub-cat>:...' <key> <value(s)>...
```

Each module should describe individually what the available configuration is.
