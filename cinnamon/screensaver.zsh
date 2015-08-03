function lock() {
  if [[ "$1" == "off" ]]; then
    gsettings set org.cinnamon.desktop.session idle-delay 0
    gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 0
  else
    gsettings set org.cinnamon.desktop.session idle-delay 900
    gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 900
  fi
}
