#!/bin/sh

## From $HOME
list=".zprofile .zshrc .xprofile .xinitrc .Xresources"
for i in $list; do
    cp -r "$HOME/$i" "$HOME/Repositories/dotfiles" || exit 1
done

## From $HOME/.config
list="zathura dunst qutebrowser nvim alacritty mpv lf autostart calcurse jrnl"
for i in $list; do
    cp -r "$HOME/.config/$i" "$HOME/Repositories/dotfiles/.config" || exit 1
done

## From $HOME/.local
### applications

## Upload to git repo
git add .
git commit -m "$(date)"
git status
git push origin main
