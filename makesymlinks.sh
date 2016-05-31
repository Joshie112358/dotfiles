#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dev/dotfiles                    # dotfiles directory
olddir=~/dev/dotfiles/dotfiles_old             # old dotfiles backup directory
files="~/.zshrc ~/.emacs.d/init.el ~/.xmobarrc ~/.xmonad/xmonad.hs ~/.xsession"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p ~/dev
mkdir -p $dir
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

echo "Copying any existing dotfiles from ~ to $olddir"
mv ~/.zshrc $olddir
mv ~/.emacs.d/init.el $olddir
mv ~/.xmobarrc $olddir
mv ~/.xmonad/xmonad.hs $olddir
mv ~/.xsession $olddir
echo "done (no error should have been displayed)"

echo "Creating symlink to $file in home directory."
ln -s $dir/zshrc ~/.zshrc
ln -s $dir/init.el ~/.emacs.d/init.el
ln -s $dir/xmobarrc ~/.xmobarrc
ln -s $dir/xmonad.hs ~/.xmonad/xmonad.hs
ln -s $dir/xsession ~/.xsession
echo "done (no error should have been displayed)"

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo yum install zsh
            install_zsh
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh
            install_zsh
        fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

#install_zsh
