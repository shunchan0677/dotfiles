#!/bin/bash -e

# Dotfile setup script

for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".travis.yml" ]] && continue
    [ -e ~/"$f" ] && rm -f ~/"$f".bak && mv ~/"$f" ~/"$f".bak
    ln -s "${PWD}"/"$f" ~/
    echo "Made symlink of $f"
done

[ ! -e ~/.local/bin ] && mkdir -p ~/.local/bin

echo "Sucessfully setup dotfiles."
echo "Next, please run install.sh to install essential tools."