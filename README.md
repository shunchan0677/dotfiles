# Dotfiles

zsh環境を構築するためのファイル群

## Setup

Nerd fontsを以下からダウンロードする。
`https://github.com/ryanoasis/nerd-fonts`

以下のコマンドでzsh環境を構築する。

```bash
# clone this repository
$ git clone https://github.com/kan-bayashi/dotfiles
$ cd dotfiles

# setup dotfiles
$ ./setup.sh

# install essential tools (required sudo)
$ ./install.sh

# enable zsh environment
$ exec zsh -l
```