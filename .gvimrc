"色のテーマ指定
gui
if isdirectory($HOME . '/.vim/bundle/vim-colors-solarized' )
  set background=dark
  colorscheme solarized
endif

"ツールウィンドウを消す
set guioptions-=T

"FONT設定
set gfn=Ricty:h13:b:cSHIFTJIS
set gfw=Ricty:h13:b:cSHIFTJIS

"vimrcでencoding=utf-8ををしてしまうとメニューがばけるので
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

"半透明化
"autocmd GUIEnter * set transparency=230
