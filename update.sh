#!/bin/sh

## Copy changes
list="zathura dunst qutebrowser nvim alacritty mpv lf autostart calcurse jrnl"
for i in $list; do
    cp -r "$HOME/.config/$i" "$HOME/Repos/config" || exit 1
done

## Upload to git repo
git add .
git commit -m "$(date)"
git status
git push origin main
