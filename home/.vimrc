" 設定関連 {{{
  let mapleader = ","   " キーマップリーダー

  " clipbordを有効化 -> http://qiita.com/shoma2da/items/92ea8badcd4655b6106c
  set clipboard+=unnamed

  filetype on                    " ファイル形式の検出を有効化
  set nocompatible               " compatible の機能をオフにします。compatible のオプションを有効にすると、Vimの便利な機能が使えなくなる。 初期値：オン
  set hlsearch                   " 検索結果をハイライト表示
  set tabstop=2                  " ファイル内の <Tab> が対応する空白の数。
  set expandtab                  " Insertモードで: <Tab> を挿入するのに、適切な数の空白を使う。（タブをスペースに展開する）
  set autoindent                 " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
  set relativenumber             " 相対行番号表示
  set scrolloff=5                " スクロール時の余白確保
  set wildmenu                   " コマンドライン補完を拡張モードにする
  set wildmode=list:longest,full " コマンドライン補完を拡張モードにする
  set autoread                   " 他で書き換えられたら自動で読み直す
  set foldmethod=marker          " 折りたたみ
  set formatoptions=lmoq         " テキスト整形オプション，マルチバイト系を追加
  set showcmd                    " コマンドをステータス行に表示
  set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
  set showmode                   " 現在のモードを表示
  set list                " 不可視文字の可視化
  " デフォルト不可視文字は美しくないのでUnicodeで綺麗に
  set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
  " 不可視文字の表示形式
  set listchars=tab:>.,trail:_,extends:>,precedes:<

  "カレントウィンドウのカーソル行をハイライトする
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  set showtabline=2 " タブページを常に表示

  "カレントウィンドウのカーソル行をハイライトする
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  set textwidth=0         " 自動的に改行が入るのを無効化

  set nowritebackup
  set nobackup   " バックアップ取らない
  set noswapfile " スワップファイル作らない

  " シフト移動幅
  set shiftwidth=2

  " 検索関連 http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
  set ignorecase          " 大文字小文字を区別しない
  set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
  set incsearch           " インクリメンタルサーチ

  " バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
  cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
  cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

  "-------------------------------------
  " StatusLine
  "-------------------------------------
  set laststatus=2 " 常にステータスラインを表示

  " 印字不可能文字を16進数で表示
  set display=uhex

  " 全角スペースの表示
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
  match ZenkakuSpace /　/

  " ポップアップの配色
  hi Pmenu guibg=#006400
  hi PmenuSel guibg=#8cd0d3 guifg=#666666
  hi PmenuSbar guibg=#333333

  "全角スペースをハイライトさせる。
  function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
  endf
"}}}

" util {{{
  " 保存時に行末の空白を除去する
  function! s:remove_dust()
      let cursor = getpos(".")
      %s/\s\+$//ge
      %s/\t/  /ge
      call setpos(".", cursor)
      unlet cursor
  endfunction
  autocmd BufWritePre * call <SID>remove_dust()



  "ファイルの前回閉じた時の場所を覚えていてくれる
  if has("autocmd")
      autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
    endif
" }}}

" key map  {{{
  " Ctrl + j, k, h, lでウインドウを移動できるように
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l

   " 入力モード中に素早くjjと入力した場合はESCとみなす
  inoremap jj <Esc>

  "検索結果のハイライトを消す
  nnoremap <ESC><ESC> :nohlsearch<CR>

  "ファイルブラウザを開く
  nnoremap <C-e> :VimFiler<CR>
  "タブで開く
  nnoremap <S-t> :Texplore<CR>

  " bookmarkを表示
  "nnoremap   ;ub :<C-u>Unite bookmark -default-action=vimfiler<CR>
  nnoremap   <C-b> :<C-u>Unite bookmark -default-action=vimfiler<CR>

  "矩形選択後<または>しても、選択を解除しないようにする
  vnoremap < <gv
  vnoremap > >gv

  "ビジュアルモード時vで行末まで選択
  vnoremap v $h

  "コピペした後、貼り付けた範囲を選択
  nnoremap gc `[v`]
  vnoremap gc :<C-u>normal gc<Enter>

  "タブの移動
  nnoremap <S-h> gT
  nnoremap <S-l> gt

  "見た目で行移動
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k

  " 再描画
  nmap ,rd :<C-u>redraw!

" }}}

" ファイルタイプの追加 {{{
  au BufNewFile,BufRead *.slim setf slim
" }}}

" 関数群{{{
function! InsertDebugger()
    "let require_debugger = "require 'ruby-debug'"
    "let debugger = "debugger"
    "let dummy = "p '######'"
    "execute ":normal i" . require_debugger
    "execute ":normal i" . debugger
    "execute ":normal i" . dummy
"    let debugger = "require 'pry-debugger'binding.pry"
"
"
    if &filetype == 'coffee' || &filetype == 'javascript'
      let debugger = "debugger"
    elseif &filetype == 'ruby'
      let debugger = "binding.pry"
    elseif &filetype == 'eruby'
      let debugger = "<% binding.pry %>"
    elseif &filetype == 'haml'
      let debugger = "- binding.pry"
    else
      let debugger = "binding.pry"
    endif

    "execute ":normal i" . debugger
    return debugger
endfunction

"noremap <silent> <F12> :call InsertDebugger()<CR><LF>
inoremap <expr> <C-b> InsertDebugger()

" vimで縦に連番を入力する =>http://d.hatena.ne.jp/fuenor/20090907/1252315621
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor
"}}}

" NeoBundle {{{
  filetype plugin indent off

  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()
  endif

  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/unite.vim'

  "vimのcolor設定{{{
    NeoBundle 'altercation/vim-colors-solarized'
    colorscheme solarized
    set background=dark
    if &term =~ "xterm-256color" || "screen-256color"
      set t_Co=256
      set t_Sf=[3%dm
      set t_Sb=[4%dm
    elseif &term =~ "xterm-color"
      set t_Co=8
      set t_Sf=[3%dm
      set t_Sb=[4%dm
    endif

    syntax enable
    hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
  "}}}

  NeoBundle 'Shougo/vimfiler' " {{{
    let g:vimfiler_as_default_explorer = 1
    "bookmarkだけホームディレクトリに保存
    let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'
  " }}}

  " vim上でgitを使う
  NeoBundle 'tpope/vim-fugitive'
  NeoBundleLazy "gregsexton/gitv", {
       \ "depends": ["tpope/vim-fugitive"],
       \ "autoload": {
       \   "commands": ["Gitv"],
       \ }}

  " camelcaseとかに変換してくれそうなvim
  NeoBundle "tpope/vim-abolish"
  NeoBundle 'tpope/vim-bundler'

  " Ruby {{{
      " ヒアドキュメントのシンタックスハイライト
      NeoBundle 'joker1007/vim-ruby-heredoc-syntax'
  " }}}

  NeoBundle 'mattn/emmet-vim'

  NeoBundle 'osyo-manga/vim-over'
  nnoremap <silent> <Leader>/ :OverCommandLine<CR>%s/

  filetype plugin indent on
"}}}

""QFixHown -> https://sites.google.com/site/fudist/Home/qfixhowm/install{{{
  "hown_dirにDropboxフォルダを指定
  set runtimepath+=~/.vim/qfixapp

  " キーマップリーダー
  let QFixHowm_Key  =  'g'

  " howm_dirはファイルを保存したいディレクトリを設定
  let howm_dir = '~/Dropbox/commonSettings/howm'
  let howm_filename         =  '%Y/%m/%Y-%m-%d-%H%M%S.rb'
  let howm_fileencoding     =  'utf-8'
  let howm_fileformat       =  'unix'

  " QFixHowmのファイルタイプ
  let QFixHowm_FileType  =  'rb'
"}}}
