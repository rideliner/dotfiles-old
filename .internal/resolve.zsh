#!/usr/bin/env zsh

# Arguments:
# 1- name of variable to store result
# 2- name of symlink file
# 3- name of module
function dotfileSymlinkResolve() {
  eval "$1=\"${${${(P)1//\?/$2}//\!/$3}/\~/$HOME}\""
}
