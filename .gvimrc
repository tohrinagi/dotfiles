"色のテーマ指定
gui
set background=dark
colorscheme solarized

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
