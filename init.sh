mv ~/.bash_aliases ~/.bash_aliases.old
mv ~/.bash_profile ~/.bash_profile.old
mv ~/.bashrc ~/.bashrc.old
mv ~/.gitconfig ~/.gitconfig.old
mv ~/.gitignore ~/.gitignore.old
mv ~/.profile ~/.profile.old
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.inputrc ~/.inputrc.old
mv ~/.tern-project ~/.tern-project.old

printf "    renamed already present files with '.old' postfix\n"

if cat /proc/sys/kernel/osrelease | grep -q Microsoft; then
  echo "WSL identified, using Windows folders"

  eval USERNAME=`cmd.exe /c "echo %USERNAME%"`
  USERNAME="${USERNAME/$'\r'/}"

  if [ ! -d ~/.config/sublime-text-3/Packages/ ]; then
    mkdir -p ~/.config/sublime-text-3/Packages/
    printf "    Sublime Text 3 Packages Unix folder created\n"
  else
    mv -T ~/.config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User.old
    printf "    renamed sublime-text-3 Unix User folder or symlink with '.old' postfix\n"
  fi

  ln -s $PWD/.config/sublime-text-3/Packages/User /mnt/c/Users/$USERNAME/AppData/Roaming/Sublime\ Text\ 3/Packages/User
  printf "Symlink created to Sublime Text 3 Windows User folder%s\nbroken in WSL, create symlink manually with the following command in an admin cmd:%s\n mklink /J 'C:%s\Users\\DJ\\AppData\\Roaming\\Sublime Text 3\\Packages%s\User' B:\\dev\\unix-conf\\.config\\sublime-text-3\\Packages%s\User%s\n%s\n"


  if [ ! -d /mnt/c/Users/$USERNAME/AppData/Roaming/Code/ ]; then
    mkdir -p /mnt/c/Users/$USERNAME/AppData/Roaming/Code/
    printf "VScode Windows folder created\n"
  else
    mv /mnt/c/Users/$USERNAME/AppData/Roaming/Sublime\ Text\ 3/Packages/User /mnt/c/Users/$USERNAME/AppData/Roaming/Sublime\ Text\ 3/Packages/User.old
    printf "renamed VScode Windows User folder or symlink with '.old' postfix\n"
  fi

  ln -s $PWD/Code /mnt/c/Users/$USERNAME/AppData/Roaming/Code/
  printf "Symlink created to VScode Windows User folder%s\n broken in WSL, create symlink manually with the following command in an admin cmd:%s\n mklink /J 'C:\\Users\\DJ\\AppData\\Roaming\\Code' B:\\dev\\unix-conf\\Code%s\n%s\n"

else
  echo "WSL not identified, using Unix folders"

  if [ ! -d ~/.config/Code/User/ ]; then
    mkdir -p ~/.config/Code/User/
    printf "    VScode Unix folder created\n"
  else
    mv -T ~/.config/Code/User ~/.config/Code/User.old
    printf "    renamed VScode Unix User folder or symlink with '.old' postfix\n"
  fi

  ln -s $PWD/.config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User
  printf "Symlink created to Sublime Text 3 Unix User folder\n\n"


  if [ ! -d ~/.config/Code/ ]; then
    mkdir -p ~/.config/Code/
    printf "VScode Unix folder created\n"
  else
    mv ~/.config/Cpde ~/.config/Code.old
    printf "renamed VScode Unix User folder or symlink with '.old' postfix\n"
  fi

  ln -s $PWD/.config/Code ~/.config/Code
  printf "Symlink created to VScode Unix User folder\n\n"
fi


ln -s $PWD/.bashrc ~/.bashrc
printf "    Symlink created to .bashrc\n"
ln -s $PWD/.bash_aliases ~/.bash_aliases
printf "    Symlink created to .bash_aliases\n"
ln -s $PWD/.bash_profile ~/.bash_profile
printf "    Symlink created to .bash_profile\n"
ln -s $PWD/.gitconfig ~/.gitconfig
printf "    Symlink created to .gitconfig\n"
ln -s $PWD/.gitignore ~/.gitignore
printf "    Symlink created to .gitignore\n"
ln -s $PWD/.profile ~/.profile
printf "    Symlink created to .profile\n"
ln -s $PWD/.tmux.conf ~/.tmux.conf
printf "    Symlink created to .tmux.conf\n"
ln -s $PWD/.inputrc ~/.inputrc
printf "    Symlink created to .inputrc\n"
ln -s $PWD/.tern-project ~/.tern-project
printf "    Symlink created to .tern-project\n\n"

cat code-extensions.txt | xargs -L 1 code --install-extension
printf "    installed vscode extensions from code-extensions.txt\n"
code --list-extensions > code-extensions.txt
printf "    saved currently installed VScode extensions in code-extensions.txt\n\n"
