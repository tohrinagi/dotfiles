set nocompatible              "VIMにする 与える影響が大きいので最初にset
filetype off

"何で動いているか調べる
let s:is_windows  =  has('win16') || has('win32') || has('win64') || has('win32unix')
let s:is_mac      =  has('macunix') || has('mac')
let s:is_unix     =  has('unix')
let s:is_cygwin   =  has('win32unix')
let s:is_cui      = !has('gui_running')

"----------------------------------------------------------------------------
" インストールするプラグインの設定
"----------------------------------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/dotfiles/.vim/bundle/'))

"Unite
NeoBundle 'Shougo/unite.vim'
"unite extention
NeoBundle 'Shougo/neomru.vim'
"async process
NeoBundle 'Shougo/vimproc'
"補完
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
"php補完拡張
NeoBundle 'violetyk/neocomplete-php.vim', { 'autoload' : { 'filetype' : ['php'], }, }
"Ryby補完拡張
NeoBundle 'Shougo/neocomplcache-rsense', { 'autoload' : { 'filetype' : ['ruby'], }, }
"リファレンス
NeoBundle 'thinca/vim-ref'
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
"evernote連携
if has('python')
  NeoBundle 'kakkyz81/evervim'
endif
"cuiブラウザ
if s:is_cui
  NeoBundle 'yuratomo/w3m.vim'
endif

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

"----------------------------------------------------------------------------
" 基本設定
"----------------------------------------------------------------------------
set encoding=utf8               "エンコーディング設定
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
syntax enable
set background=dark
colorscheme solarized

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
map ,1 1gt
map ,2 2gt
map ,3 3gt
map ,4 4gt
map ,5 5gt
map ,6 6gt
map ,7 7gt
map ,8 8gt
map ,9 9gt
map ,0 10gt

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

"-------------------------------------------------------------------------------
" プラグイン設定
"-------------------------------------------------------------------------------
if isdirectory($HOME . '/.vim/bundle/unite.vim' )
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable =1
  let g:unite_source_file_mru_limit = 200
  nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
  nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
  nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file -default-action=tabopen<CR>
  nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> ,uu :<C-u>Unite file_mru buffer -default-action=tabopen<CR>
endif
if neobundle#is_installed('neocomplete')
  " neocomplete用設定
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
elseif neobundle#is_installed('neocomplcache')
  let g:acp_enableAtStartup = 0                 "ACPと競合するので強制OFF
  let g:neocomplcache_enable_at_startup = 1     "起動時に有効化
  let g:neocomplcache_enable_smart_case = 1     "大文字が入力されるまで大文字小文字の区別を無視する
  let g:neocomplcache_enable_camel_case_completion = 0 "大文字区切りとしたワイルドカードのように振る舞う。FA->F*A*。但し重くなる。
  let g:neocomplcache_enable_underbar_completion = 1 " _ 区切りの補完を有効にする。
  let g:neocomplcache_min_syntax_length = 3     "シンタックスをキャッシュするときの最小文字長
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*' "自動的にロックするバッファ名のパターンを指定する。相性が悪いプラグインがある時に設定する
  "ファイルタイプごとの辞書設定
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : ''
      \ }

  "キーマッピング
  imap <C-k>     <Plug>(neocomplcache_snippets_expand)
  smap <C-k>     <Plug>(neocomplcache_snippets_expand)
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " SuperTab like snippets behavior.
  "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
  " <TAB>: completion.
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()

  "最初に候補を選択する設定。便利だが誤爆しやすい。
  "let g:neocomplcache_enable_auto_select = 1
endif
"TABでポップアップウィンドウの移動をする
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

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
"rsenseの設定
if isdirectory($HOME . '/.vim/bundle/neocomplcache-rsense' )
  let g:neocomplcache#sources#rsense#home_directory = $HOME . '/.vim/rsense'
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
if isdirectory($HOME . '/.vim/bundle/evervim' )
  nnoremap <silent> ,el :<C-u>EvervimNotebookList<CR>
  " nnoremap <silent> ,eT :<C-u>EvervimListTags<CR>
  nnoremap <silent> ,en :<C-u>EvervimCreateNote<CR>
  " nnoremap <silent> ,eb :<C-u>EvervimOpenBrowser<CR>
  " nnoremap <silent> ,ec :<C-u>EvervimOpenClient<CR>
  nnoremap ,es :<C-u>EvervimSearchByQuery<SPACE>
  "タスク用ノートを開く
  nnoremap <silent> ,et :<C-u>EvervimSearchByQuery<SPACE>notebook:"Tasks"<CR>
  " nnoremap <silent> ,et :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done -tag:someday<CR>
  " nnoremap <silent> ,eta :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done<CR>
  " nnoremap <silent> ,em :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done<CR>
  "vがデフォ。vspになる
  "let evervim_splitoption=''
  "let g:evervim_devtoken= は .vimrc.localにある
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
