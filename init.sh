mv ~/.bash_aliases ~/.bash_aliases.old
mv ~/.bash_profile ~/.bash_profile.old
mv ~/.bashrc ~/.bashrc.old
mv ~/.gitconfig ~/.gitconfig.old
mv ~/.gitignore ~/.gitignore.old
mv ~/.profile ~/.profile.old
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.inputrc ~/.inputrc.old
mv ~/.tern-project ~/.tern-project.old

printf "renamed already present files with '.old' postfix\n\n"

if cat /proc/sys/kernel/osrelease | grep -q Microsoft; then
  echo "WSL identified, using Windows folder for Sublime"

  eval USERNAME=`cmd.exe /c "echo %USERNAME%"`
  USERNAME="${USERNAME/$'\r'/}"

  if [ ! -d /mnt/c/Users/$USERNAME/AppData/Roaming/Sublime\ Text\ 3/Packages/ ]; then
    mkdir -p /mnt/c/Users/$USERNAME/AppData/Roaming/Sublime\ Text\ 3/Packages/
    printf "Sublime Text 3 Packages Windows folder created\n"
  else
    mv /mnt/c/Users/$USERNAME/AppData/Roaming/Sublime\ Text\ 3/Packages/User /mnt/c/Users/$USERNAME/AppData/Roaming/Sublime\ Text\ 3/Packages/User.old
    printf "renamed sublime-text-3 Windows User folder or symlink with '.old' postfix\n"
  fi

  ln -s $PWD/.config/sublime-text-3/Packages/User /mnt/c/Users/$USERNAME/AppData/Roaming/Sublime\ Text\ 3/Packages/User
  printf "Symlink created to Sublime Text 3 Windows User folder\n\n"

else
  echo "WSL not identified, using Unix folder for Sublime"
	
  if [ ! -d ~/.config/sublime-text-3/Packages/ ]; then
    mkdir -p ~/.config/sublime-text-3/Packages/
    printf "Sublime Text 3 Packages Unix folder created\n"
  else
    mv ~/.config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User.old
    printf "renamed sublime-text-3 Unix User folder or symlink with '.old' postfix\n"
  fi

  ln -s $PWD/.config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User
  printf "Symlink created to Sublime Text 3 Unix User folder\n\n"
fi


ln -s $PWD/.bashrc ~/.bashrc
printf "Symlink created to .bashrc\n"

ln -s $PWD/.bash_aliases ~/.bash_aliases
printf "Symlink created to .bash_aliases\n"

ln -s $PWD/.bash_profile ~/.bash_profile
printf "Symlink created to .bash_profile\n"

ln -s $PWD/.gitconfig ~/.gitconfig
printf "Symlink created to .gitconfig\n"

ln -s $PWD/.gitignore ~/.gitignore
printf "Symlink created to .gitignore\n"

ln -s $PWD/.profile ~/.profile
printf "Symlink created to .profile\n"

ln -s $PWD/.tmux.conf ~/.tmux.conf
printf "Symlink created to .tmux.conf\n"

ln -s $PWD/.inputrc ~/.inputrc
printf "Symlink created to .inputrc\n\n"

ln -s $PWD/.tern-project ~/.tern-project
printf "Symlink created to .tern-project\n\n"
