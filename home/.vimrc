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


  " Vimを終了しても undo 履歴を復元する ->http://mba-hack.blogspot.jp/2013/02/vim.html
  " http://vim-users.jp/2010/07/hack162/
  " undo 履歴を保存するディレクトリを指定する
  set undodir=./.vimundo,~/.vimundo

  " バッファの保存時に undo 履歴をファイルに保存する(すべてのファイル対象)
  set undofile
  if has('persistent_undo')
    augroup vimrc-undofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
    augroup END
  endif
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

  "テキストオブジェクト的にカーソルが単語内の何処にあってもヤンクした文字列と置換
  nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

  " binding.pryを探す
  nnoremap <C-n> :<C-u>/binding.pry<CR>

  " 1行上をコピーしてyank
  nnoremap <C-k> 0ykp
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
  NeoBundle "tpope/vim-abolish"
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tmhedberg/matchit'
  NeoBundle 'h1mesuke/vim-alignta'
  NeoBundle 'mattn/httpstatus-vim'

  NeoBundle 'osyo-manga/vim-over'
  nnoremap <silent> <Leader>/ :OverCommandLine<CR>%s/

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
    "let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'

    "セーフモードを無効にした状態で起動する
    let g:vimfiler_safe_mode_by_default = 0
  " }}}

  " git {{{
    NeoBundle 'tpope/vim-fugitive'
    NeoBundleLazy "gregsexton/gitv", {
         \ "depends": ["tpope/vim-fugitive"],
         \ "autoload": {
         \   "commands": ["Gitv"],
         \ }}
  " }}}

  " Ruby {{{
      " ヒアドキュメントのシンタックスハイライト
      "NeoBundle 'joker1007/vim-ruby-heredoc-syntax'
      "NeoBundle 'tpope/vim-bundler'

      NeoBundle 'tpope/vim-rails'
  " }}}

  " syntax highlight {{{
    NeoBundle 'slim-template/vim-slim'
    NeoBundle 'kchmck/vim-coffee-script'
    au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee " vimにcoffeeファイルタイプを認識させる
  " }}}

  NeoBundle 'AndrewRadev/switch.vim' "{{{
  nnoremap - :Switch<cr>
  let s:switch_definition = {
        \ '*': [
        \   ['is', 'are']
        \ ],
        \ 'ruby,eruby,haml,slim' : [
        \   ['if', 'unless'],
        \   ['while', 'until'],
        \   ['.blank?', '.present?'],
        \   ['include', 'extend'],
        \   ['class', 'module'],
        \   ['.inject', '.delete_if'],
        \   ['.map', '.map!'],
        \   ['attr_accessor', 'attr_reader', 'attr_writer'],
        \ ],
        \ 'Gemfile,Berksfile' : [
        \   ['=', '<', '<=', '>', '>=', '~>'],
        \ ],
        \ 'ruby.application_template' : [
        \   ['yes?', 'no?'],
        \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
        \   ['controller', 'model', 'view', 'migration', 'scaffold'],
        \ ],
        \ 'erb,html,php' : [
        \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
        \ ],
        \ 'rails' : [
        \   [100, ':continue', ':information'],
        \   [101, ':switching_protocols'],
        \   [102, ':processing'],
        \   [200, ':ok', ':success'],
        \   [201, ':created'],
        \   [202, ':accepted'],
        \   [203, ':non_authoritative_information'],
        \   [204, ':no_content'],
        \   [205, ':reset_content'],
        \   [206, ':partial_content'],
        \   [207, ':multi_status'],
        \   [208, ':already_reported'],
        \   [226, ':im_used'],
        \   [300, ':multiple_choices'],
        \   [301, ':moved_permanently'],
        \   [302, ':found'],
        \   [303, ':see_other'],
        \   [304, ':not_modified'],
        \   [305, ':use_proxy'],
        \   [306, ':reserved'],
        \   [307, ':temporary_redirect'],
        \   [308, ':permanent_redirect'],
        \   [400, ':bad_request'],
        \   [401, ':unauthorized'],
        \   [402, ':payment_required'],
        \   [403, ':forbidden'],
        \   [404, ':not_found'],
        \   [405, ':method_not_allowed'],
        \   [406, ':not_acceptable'],
        \   [407, ':proxy_authentication_required'],
        \   [408, ':request_timeout'],
        \   [409, ':conflict'],
        \   [410, ':gone'],
        \   [411, ':length_required'],
        \   [412, ':precondition_failed'],
        \   [413, ':request_entity_too_large'],
        \   [414, ':request_uri_too_long'],
        \   [415, ':unsupported_media_type'],
        \   [416, ':requested_range_not_satisfiable'],
        \   [417, ':expectation_failed'],
        \   [422, ':unprocessable_entity'],
        \   [423, ':precondition_required'],
        \   [424, ':too_many_requests'],
        \   [426, ':request_header_fields_too_large'],
        \   [500, ':internal_server_error'],
        \   [501, ':not_implemented'],
        \   [502, ':bad_gateway'],
        \   [503, ':service_unavailable'],
        \   [504, ':gateway_timeout'],
        \   [505, ':http_version_not_supported'],
        \   [506, ':variant_also_negotiates'],
        \   [507, ':insufficient_storage'],
        \   [508, ':loop_detected'],
        \   [510, ':not_extended'],
        \   [511, ':network_authentication_required'],
        \ ],
        \ 'rspec': [
        \   ['describe', 'context', 'specific', 'example'],
        \   ['before', 'after'],
        \   ['be_true', 'be_false'],
        \   ['get', 'post', 'put', 'delete'],
        \   ['==', 'eql', 'equal'],
        \   { '\.should_not': '\.should' },
        \   ['\.to_not', '\.to'],
        \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
        \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
        \ ],
        \ 'markdown' : [
        \   ['[ ]', '[x]']
        \ ]
        \ }
  " }}} Switch.vim

  "NeoBundle 'scrooloose/syntastic' " {{{
  "  let g:syntastic_mode_map = { 'mode': 'passive',
  "              \ 'active_filetypes': ['ruby'] }
  "  let g:syntastic_ruby_checkers = ['rubocop']
  NeoBundle 'scrooloose/syntastic'
  " }}}

  NeoBundle 'basyura/unite-rails' " {{{
    function! UniteRailsSetting()
      nnoremap <buffer><C-i>h           :<C-U>Unite rails/helper<CR>
      nnoremap <buffer><C-i><C-u><C-u>  :<C-U>Unite rails/view<CR>
      nnoremap <buffer><C-i><C-u>       :<C-U>Unite rails/model<CR>
      nnoremap <buffer><C-i>            :<C-U>Unite rails/controller<CR>

      nnoremap <buffer><C-i>c           :<C-U>Unite rails/config<CR>
      nnoremap <buffer><C-i>s           :<C-U>Unite rails/spec<CR>
      nnoremap <buffer><C-i>m           :<C-U>Unite rails/db -input=migrate<CR>
      nnoremap <buffer><C-i>l           :<C-U>Unite rails/lib<CR>
      nnoremap <buffer><expr><C-i>g     ':e '.b:rails_root.'/Gemfile<CR>'
      nnoremap <buffer><expr><C-i>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
      nnoremap <buffer><expr><C-i>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
      nnoremap <buffer><C-i>ra          :<C-U>Unite rails/rake<CR>
    endfunction
    aug MyAutoCmd
      au User Rails call UniteRailsSetting()
    aug END
  " }}}

  NeoBundle 'Shougo/neocomplcache' "{{{
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
  "}}}

  NeoBundle 'Shougo/neosnippet' " {{{
    NeoBundle 'Shougo/neosnippet-snippets'

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

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

    " 自分用 snippet ファイルの場所
    let s:my_snippet = '~/.vim/snippets'
    let g:neosnippet#snippets_directory = s:my_snippet

    " neosnippet.vim公式指定をちょっといじる => http://qiita.com/muran001/items/4a8ffafb9c6564313893
    imap <expr><CR> neosnippet#expandable() <bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
    imap <expr><TAB> neosnippet#jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"
  " }}}

  NeoBundle 'itchyny/lightline.vim' "{{{
    let g:lightline = {
            \ 'colorscheme': 'wombat',
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

    " カラー設定
    set t_Co=256
  " }}}

  NeoBundle 'rhysd/clever-f.vim' "{{{
    " http://rhysd.hatenablog.com/entry/2013/09/17/220837
    let g:clever_f_ignore_case = 1             " 小文字・大文字の区別はしない
    let g:clever_f_smart_case = 1              " 大文字が入力された場合は大文字のみ検索
    let g:clever_f_across_no_line = 1          " 行をまたがない
    let g:clever_f_chars_match_any_signs = ';' " 記号を;でひっかける
  "}}}

  NeoBundle 'LeafCage/yankround.vim' " {{{
    nmap p <Plug>(yankround-p)
  "}}}
"}}}

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
