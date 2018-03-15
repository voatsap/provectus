## Configuration for VIM IDE

### NerdTree

The NERDTree is a file system explorer for the Vim editor. Using this plugin, users can visually browse complex directory hierarchies, quickly open files for reading or editing, and perform basic file system operations.

[Dowload NerdTree](https://github.com/scrooloose/nerdtree)

[Main commands](https://www.cheatography.com/stepk/cheat-sheets/vim-nerdtree/)

To change focus use CTRL+WW

Installation:

```
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
```

add into ~/.vimrc

```
execute pathogen#infect()
syntax on
filetype plugin indent on

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <F2> :NERDTreeToggle<cr>

map ^[[C :tabn<cr>
map ^[[D :tabp<cr>

nnoremap ^[1 1gt
nnoremap ^[2 2gt
nnoremap ^[3 3gt
nnoremap ^[4 4gt
nnoremap ^[5 5gt
nnoremap ^[6 6gt
nnoremap ^[7 7gt
nnoremap ^[8 8gt
nnoremap ^[9 9gt
```

### Auto-Pairs

Auto-pairs module to close brackets () {} [] etc..
https://github.com/jiangmiao/auto-pairs
```
git clone git://github.com/jiangmiao/auto-pairs.git ~/.vim/bundle/auto-pairs
```

### Terraform Syntax Highlight

```
cd ~/.vim/bundle
git clone https://github.com/hashivim/vim-terraform.git
```
