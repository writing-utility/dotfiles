#!/bin/sh

## From $HOME
list=".zprofile .zshrc .xprofile .xinitrc .Xresources"
for i in $list; do
    cp -r "$HOME/$i" "$HOME/Repos/dotfiles" || exit 1
done

## From $HOME/.config
list="zathura dunst qutebrowser nvim alacritty mpv lf autostart calcurse jrnl"
for i in $list; do
    cp -r "$HOME/.config/$i" "$HOME/Repos/dotfiles/.config" || exit 1
done

## Upload to git repo
git add .
git commit -m "$(date)"
git status
git push origin main
