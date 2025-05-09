# Neovim Config

> forked from [LunarVim's Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch)

## Install

Make sure to backup your current (if exists) `nvim` directory

```
git clone -b main git@github.com:daolanfler/Neovim-from-scratch.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

each video will be associated with a branch so checkout the one you are interested in

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

-   On mac `pbcopy` should be builtin

-   On Ubuntu

    ```
    sudo apt install xsel
    ```

-   On Arch Linux

    ```
    sudo pacman -S xsel
    ```

Next we need to install python support (node is optional)

-   Neovim python support

    ```
    pip install pynvim
    ```

-   Neovim node support

    ```
    npm i -g neovim
    ```
