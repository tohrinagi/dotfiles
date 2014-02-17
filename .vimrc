set nocompatible

"--------------------
" 基本的な設定
"--------------------
"バックアップファイルのディレクトリを指定する
"set backupdir=$HOME/vimbackup
set nobackup

"スワップファイル用のディレクトリを指定する
"set directory=$HOME/vimbackup
set noswapfile

"クリップボードOSと連携する
set clipboard+=unnamed

"カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
"バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

"複数ファイルの編集を可能にする
set hidden

"内容が更新されたら自動的に再読み込み
set autoread

"コマンドラインをTABで補完できるようにする
set wildchar=<C-Z>

"ターミナルで256表示を使う
set t_Co=256

"カーソルラインを表示する
set cursorline

"行番号の表示
set number

"--------------------
"検索
"--------------------
"検索時　大文字小文字を区別する
set noignorecase

"大文字で検索されたら対象を大文字限定にする
set smartcase

"インクリメンタルサーチを有効にする
set incsearch

"強調表示
set hlsearch

" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>

"--------------------
"フォーマット設定
"--------------------
"自動的にインデントする
set autoindent
set smartindent

"閉括弧が入力された時、対応する括弧を強調する
set showmatch
 
"行頭の余白内でTabを打ち込むと'shiftwidth'の数だけインデントする
set smarttab
 
"タブ設定
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"switch caseを同じ列にする
set cino=:0

"Tab、行末の半角スペースを明示的に表示する
set list
set listchars=tab:^\ ,trail:~


"--------------------
"ステータスライン
"--------------------
"ステータスラインにコマンドを表示
set showcmd

"ステータスラインを常に表示
set laststatus=2
"ファイルナンバー表示
set statusline=[%n]
"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
"ファイル名表示
set statusline+=%<%F
"変更のチェック表示
set statusline+=%m
"読み込み専用かどうか表示
set statusline+=%r
"ヘルプページなら[HELP]と表示
set statusline+=%h
"プレビューウインドウなら[Prevew]と表示
set statusline+=%w
"ファイルフォーマット表示
set statusline+=[%{&fileformat}]
"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"ファイルタイプ表示
set statusline+=%y

"--------------------
"キーマップ
"--------------------
noremap <unique> <script> <M-1> :tabn1<CR>:<BS>
noremap <unique> <script> <M-2> :tabn2<CR>:<BS>
noremap <unique> <script> <M-3> :tabn3<CR>:<BS>
noremap <unique> <script> <M-4> :tabn4<CR>:<BS>
noremap <unique> <script> <M-5> :tabn5<CR>:<BS>
noremap <unique> <script> <M-6> :tabn6<CR>:<BS>
noremap <unique> <script> <M-7> :tabn7<CR>:<BS>
noremap <unique> <script> <M-8> :tabn8<CR>:<BS>
noremap <unique> <script> <M-9> :tabn9<CR>:<BS>
noremap <unique> <script> <M-0> :tabn10<CR>:<BS>

"--------------------
" neobundleの設定
"--------------------

if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/dotfiles/.vim/bundle/'))
endif

" インストールしたいプラグイン
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'tsukkee/unite-tag'
"NeoBundle 'The-NERD-tree'
"NeoBundle 'The-NERD-Commenter'
"NeoBundle 'Gist.vim'

syntax on
filetype plugin indent on

"--------------------
" neocomplcacheの設定
"--------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
