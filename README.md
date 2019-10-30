# Installation

## With Vundle
```
Plugin 'celforyon/vimas'
```
then in vim `:VundleInstall`

## Manual installation
```
git clone https://github.com/celforyon/vimas.git
cp vimas/plugin/vimas.vim ~/.vim/plugin
```
(optionally you can also install the docs and generate the tags with `:helptags`)

# Configuration

See `:h vimas`
Generally, you will want to add
```
call vimas#vimas()
```
at the end of your `.vimrc` to automatically manage sessions.
Else, see the different commands that are provided.

# Update

## Vundle
In vim `:VundleUpdate`

## Manual update
Simply redo manual installation steps

# Usage

See `:h vimas`
