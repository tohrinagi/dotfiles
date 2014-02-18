"----------------------------------------------------------------------------
" インストールするプラグインの設定
"----------------------------------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/dotfiles/.vim/bundle/'))

" インストールしたいプラグイン
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'

syntax on
filetype indent on
filetype plugin on

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
set wildchar=<C-Z>              "コマンドラインをTABで補完できるようにする
set cursorline                  "カーソルラインを表示する
set number                      "行番号の表示
set nocompatible
"ターミナルで256表示を使う
set t_Co=256
set mouse=n                     "マウスON

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
set showcmd                     "ステータスラインにコマンドを表示
set laststatus=2                "ステータスラインを常に表示
set statusline=[%n]             "ファイルナンバー表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@   "ホスト名表示
set statusline+=%<%F            "ファイル名表示
set statusline+=%m              "変更のチェック表示
set statusline+=%r              "読み込み専用かどうか表示
set statusline+=%h              "ヘルプページなら[HELP]と表示
set statusline+=%w              "プレビューウインドウなら[Prevew]と表示
set statusline+=[%{&fileformat}]  "ファイルフォーマット表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]  "文字コード表示
set statusline+=%y              "ファイルタイプ表示

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

"単語の上書きペースト
nnoremap <silent> rp ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

"コピーした文字で繰り返し上書きペーストする
vnoremap <silent> 0p "0p<CR>

" 検索語に中央に移動
map n nzz
map N Nzz
map * *zz
map # #zz

"-------------------------------------------------------------------------------
" プラグイン設定
"-------------------------------------------------------------------------------
" neocomplcacheの設定
if isdirectory($HOME . '/.vim/bundle/neocomplcache' )
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
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()

  "最初に候補を選択する設定。便利だが誤爆しやすい。
  "let g:neocomplcache_enable_auto_select = 1
endif

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
