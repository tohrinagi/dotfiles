set nocompatible              "VIMにする 与える影響が大きいので最初にset
filetype off

"何で動いているか調べる
let s:is_windows  =  has('win16') || has('win32') || has('win64') || has('win32unix')
let s:is_mac      =  has('macunix') || has('mac')
let s:is_unix     =  has('unix')
let s:is_cygwin   =  has('win32unix')
let s:is_cui      = !has('gui_running')

"エンコーディング設定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,enc-jp,sjis,cp932
set fileformats=unix,dos,mac

"----------------------------------------------------------------------------
" インストールするプラグインの設定
"----------------------------------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/dotfiles/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
" 静的解析
NeoBundle 'scrooloose/syntastic'
"Unite
NeoBundle 'Shougo/unite.vim'
"unite extention
NeoBundle 'Shougo/neomru.vim'
"async process
NeoBundle 'Shougo/vimproc'
"補完
NeoBundle 'Shougo/neocomplete'
"php補完拡張
NeoBundle 'violetyk/neocomplete-php.vim', { 'autoload' : { 'filetype' : ['php'], }, }
"ruby拡張
NeoBundleLazy 'marcus/rsense', {
          \ 'autoload' : { 'filetypes' : 'ruby' },
          \ }
NeoBundle 'supermomonga/neocomplete-rsense.vim', {
          \ 'depends': ['Shougo/neocomplete', 'marcus/rsense'],
          \ }
" 静的解析
NeoBundle 'scrooloose/syntastic'
"リファレンス
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
NeoBundle 'mfumi/ref-dicts-en'
NeoBundle 'tyru/vim-altercmd'
"スニペット
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
"カラースキーマ
NeoBundle 'altercation/vim-colors-solarized'
"ステータスライン拡張
NeoBundle 'itchyny/lightline.vim'
"grep後の置換
NeoBundle 'thinca/vim-qfreplace'
"コメントアウト
NeoBundle 'scrooloose/nerdcommenter'
"即実行 todo
NeoBundle 'thinca/vim-quickrun'
"filetype json
NeoBundle 'elzr/vim-json'
"filetype yaml
NeoBundle 'ingydotnet/yaml-vim'
" メソッド定義元へのジャンプ
NeoBundle 'szw/vim-tags'
" 自動で閉じる
NeoBundle 'tpope/vim-endwise'
" 囲うもの S' や S" で単語を囲う
NeoBundle 'tpope/vim-surround'
if has('python')
  "json :NeatJson
  NeoBundle '5t111111/neat-json.vim'
endif
"cuiブラウザ
if s:is_cui
  NeoBundle 'yuratomo/w3m.vim'
endif
"markdown対応 ;PrevimOpenで見る
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

syntax enable
filetype indent on
filetype plugin on

"----------------------------------------------------------------------------
" 外部設定ファイル
"----------------------------------------------------------------------------
" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif

helptags $HOME/.vim/doc/

"----------------------------------------------------------------------------
" 基本設定
"----------------------------------------------------------------------------
set nobackup                    "バックアップファイルのディレクトリを指定する
set noswapfile                  "スワップファイル用のディレクトリを指定する
set hidden                      "複数ファイルの編集を可能にする
set autoread                    "内容が更新されたら自動的に再読み込み
set clipboard+=unnamed,autoselect          "クリップボードOSと連携する
set backspace=indent,eol,start  "バックスペースでインデントや改行を削除できるようにする
set wildmenu
set cursorline                  "カーソルラインを表示する
set number                      "行番号の表示
set mouse=a                     "マウスON
set ttymouse=xterm2
set scrolloff=5                 "スクロールし始める行数
set vb t_vb=                    "ビープ音使用しない
set whichwrap=b,s,h,l,<,>,[,],~     "特定のキーに行頭および行末の回りこみ移動を許可する設定
set wrap                        "行のおりかえし
set showcmd                     " タイプ途中のコマンドを画面最下行に表示

"----------------------------------------------------------------------------
"カラー設定
"----------------------------------------------------------------------------
" ターミナルタイプによるカラー設定
if s:is_cygwin
  "cygwin-minttyではこれがないとsolarized反映しない…
  let g:solarized_termcolors=256
  if &term =~# '^xterm' && &t_Co < 256
    set t_Co=256  " Extend terminal color of xterm
  endif
endif

"カラースキーム
if isdirectory($HOME . '/.vim/bundle/vim-colors-solarized' )
  set background=dark
  colorscheme solarized
endif

"----------------------------------------------------------------------------
"ターミナル設定
"----------------------------------------------------------------------------
if s:is_cui
  if &term !=# 'cygwin'  " not in command prompt
    " Change cursor shape depending on mode
    let &t_ti .= "\e[1 q"
    let &t_SI .= "\e[5 q"
    let &t_EI .= "\e[1 q"
    let &t_te .= "\e[0 q"
  endif
endif


"----------------------------------------------------------------------------
"検索
"----------------------------------------------------------------------------
set noignorecase                "検索時　大文字小文字を区別する
set smartcase                   "大文字で検索されたら対象を大文字限定にする
set incsearch                   "インクリメンタルサーチを有効にする
set hlsearch                    "強調表示

"----------------------------------------------------------------------------
"フォーマット設定
"----------------------------------------------------------------------------
set autoindent                  "自動的にインデントする
set smartindent
set showmatch                   "閉括弧が入力された時、対応する括弧を強調する
set smarttab                    "行頭の余白内でTabを打ち込むと'shiftwidth'の数だけインデントする
set expandtab                   "タブ設定
set tabstop=2
set softtabstop=2
set shiftwidth=2
set cino=:0                     "switch caseを同じ列にする
set list                        "Tab、行末の半角スペースを明示的に表示する
set listchars=tab:^\ ,trail:~

"-------------------------------------------------------------------------------
"ステータスライン
"-------------------------------------------------------------------------------
set laststatus=2                "ステータスラインを常に表示

"-------------------------------------------------------------------------------
"タブライン
"-------------------------------------------------------------------------------
set showtabline=2                 "タブページを常に表示

"-------------------------------------------------------------------------------
" Mapping
"-------------------------------------------------------------------------------
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map/noremap           @            -              -                  @
" nmap/nnoremap         @            -              -                  -
" imap/inoremap         -            @              -                  -
" cmap/cnoremap         -            -              @                  -
" vmap/vnoremap         -            -              -                  @
" map!/noremap!         -            @              @                  -
"-------------------------------------------------------------------------------
"タブ移動を早くする
map t1 1gt
map t2 2gt
map t3 3gt
map t4 4gt
map t5 5gt
map t6 6gt
map t7 7gt
map t8 8gt
map t9 9gt
map t0 10gt

map to :tabo

"単語の上書きペースト
"nnoremap <silent> rp ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

"コピーした文字で繰り返し上書きペーストする
vnoremap <silent> 0p "0p<CR>

" 検索語に中央に移動
map n nzz
map N Nzz
map * *zz
map # #zz

"行の折り返しをしているとき、見た目の次の行へ移動する
nnoremap j gj
nnoremap k gk

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

".md拡張子をmarkdownファイルとする
au BufRead,BufNewFile *.md set filetype=markdown

" prefix Key
" Pluginのキーバインドルールとしては スペース始まりにしたい
nnoremap [unite] <Nop>
nmap <Space>u [unite]

"-------------------------------------------------------------------------------
" プラグイン設定
"-------------------------------------------------------------------------------
if isdirectory($HOME . '/.vim/bundle/unite.vim' )
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable =1
  let g:unite_source_file_mru_limit = 200
  let g:unite_source_find_command="find.exe"
  nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file -default-action=tabopen<CR>
  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> [unite]u :<C-u>Unite file_mru buffer -default-action=tabopen<CR>
endif
if neobundle#is_installed('neocomplete')
  " neocomplete用設定
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
endif
"TABでポップアップウィンドウの移動をする
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

if isdirectory($HOME . '/.vim/bundle/rsense' )
"  if s:is_cygwin
"    let g:rsenseHome = '/usr/bin/local/rsense'
"  endif
  let g:rsenseUseOmniFunc = 1
endif

" syntastic_mode_mapをactiveにするとバッファ保存時にsyntasticが走る
" active_filetypesに、保存時にsyntasticを走らせるファイルタイプを指定する
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" neosnippetの設定
if isdirectory($HOME . '/.vim/bundle/neosnippet' )
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
   \ "\<Plug>(neosnippet_expand_or_jump)"
   \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
   \ "\<Plug>(neosnippet_expand_or_jump)"
   \: "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

  " Enable snipMate compatibility feature.
  " let g:neosnippet#enable_snipmate_compatibility = 1
endif
"neocomplete-phpの設定
"なお、辞書作成する場合は次のコマンドを呼ぶ :PhpMakeDict
if isdirectory($HOME . '/.vim/bundle/neocomplete-php.vim' )
  let g:neocomplete_php_locale = 'ja'
endif
"nerdcommenterの設定
if isdirectory($HOME . '/.vim/bundle/nerdcommenter' )
  " デフォルトマッピングを無効
  let g:NERDCreateDefaultMappings = 0
  let g:NERDSpaceDelims = 2
  " コメントアウトのマッピング
  :map ,, <Plug>NERDCommenterToggle
  " :map ,m <Plug>NERDCommenterAppend
  " :map ,. <Plug>NERDCommenterSexy
endif
if isdirectory($HOME . '/.vim/bundle/lightline.vim' )
  let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

  function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
  endfunction

  function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
          \  &ft == 'unite' ? unite#get_status_string() :
          \  &ft == 'vimshell' ? vimshell#get_status_string() :
          \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! MyFugitive()
    try
      if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
      endif
    catch
    endtry
    return ''
  endfunction

  function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction

  function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
  endfunction
endif
if isdirectory($HOME . '/.vim/bundle/ref-dicts-en' )
  " vim-ref のバッファを q で閉じられるようにする
  autocmd FileType ref-* nnoremap <buffer> <silent> q :<C-u>close<CR>

  " 辞書定義
  let g:ref_source_webdict_sites = {
        \   'je': {
        \     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
        \   },
        \   'ej': {
        \     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
        \   },
        \ }

  " デフォルトサイト
  let g:ref_source_webdict_sites.default = 'ej'

  " 出力に対するフィルタ
  " 最初の数行を削除
  function! g:ref_source_webdict_sites.je.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
  endfunction

  function! g:ref_source_webdict_sites.ej.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
  endfunction
endif
if isdirectory($HOME . '/.vim/bundle/ref-dicts-en' )
  call altercmd#load()
  "vim-ref webdictを短縮する
  CAlterCommand ej Ref webdict ej
  CAlterCommand je Ref webdict je
endif
if isdirectory($HOME . '/.vim/bundle/w3m.vim' )
  CAlterCommand w3m W3mTab
  CAlterCommand wb W3mTab google
  CAlterCommand wbeng W3mTab alc
  CAlterCommand wbwiki W3mTab wikipedia
  CAlterCommand wbphp W3mTab php
endif
