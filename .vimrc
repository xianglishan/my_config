" https://www.tyksnet.com/blog/archives/4228
" 上記urlを参照
"-------------------------------------------------------------------
"プラグイン＆Nerdフォント使用選択

"ステータスラインの種類選択（下記３行のうち何れかを有効化する）
"let g:status_plugin='none'             "プラグインを使わない
let g:status_plugin='lightline'        "lightlineプラグインを使う
"let g:status_plugin='airline'          "airlineプラグインを使う（要NerdFonts）

"どのコード補完プラグインを使うか選択
let g:coding_assist='none'              "プラグインを使わない
"let g:coding_assist='coc_nvim'         "coc.nvimプラグインを使う
"let g:coding_assist='vim_lsp'          "vim-lspプラグインを使う

"NerdFontインストール状態
let g:nerdfont_installed='none'        "NerdFontがインストールされてない
"let g:nerdfont_installed='yes'          "NerdFontがインストール済み

"==== システム関連 ====
if v:version > 800 || (v:version == 800 && has("patch716"))
    set viminfofile=NONE    "viminfoファイルを作らない(Vim v8.0.0716以降)
endif
if v:version > 800
    set termguicolors       "端末でのTrueColorサポート
endif
set regexpengine=1          "使用正規表現エンジン(0:自動切替 1:バックトラック 2:NFA) 注:NFAは一部gVim環境でクラッシュ誘発
set nocompatible            "vi互換モード無効
set shortmess+=I            "起動時のショートメッセージを表示しない
set clipboard=unnamed,unnamedplus   "ヤンクした内容をクリップボードに入れるようにする
set backspace=2             "バックスペースの挙動を通常と同じにする
set encoding=UTF-8          "VIMの内部エンコードをUTF-8とする
set fileencodings=UTF-8,CP932   "ファイルの読み込みのエンコード順を指定
set fileformats=unix,dos,mac    "改行コード自動判定
set ambiwidth=double        "一部の記号などが半角サイズになってしまうのを回避。但しairlineの表示で隙間が空く。
set nobackup                "バックアップファイルを作らない
"set noswapfile              "スワップファイルを作らない
set noundofile              "undoファイルを作らない
set autoread                "編集中のファイルが変更されたら自動で読み直す
set hidden                  "バッファが編集中でも他のファイルを開けるようにする
set showcmd                 "入力中のコマンドをステータスに表示する
set wildmode=list:longest   "コマンドラインの補完
set display=lastline        "長い行を@で省略しない
"折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
"インサートモードでの表示行単位での移動（弊害：モード切替を伴うのでステータスラインがちらつく）
"inoremap <down> <c-\><c-o>gj
"inoremap <up> <c-\><c-o>gk
set virtualedit=onemore     "行末の1文字先までカーソルを移動できるようにする
syntax enable               "シンタックスハイライトの有効化
set number                  "行番号を表示
nnoremap <space>k :set nu! nu?<cr>|    "行番号表示切替
set cursorline              "現在の行を強調表示
set showmatch               "括弧入力時の対応する括弧を表示
"オートインデント無効化
set noautoindent            "オートインデントを無効化
set nosmartindent           "スマートインデントを無効化
set nocindent               "Ｃ言語用のインデントを無効化

"==== ステータス表示関連 ====
set laststatus=2    "ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示 2:常に表示)

if g:status_plugin == 'none'
    set statusline=%F                   "ファイル名表示
    set statusline+=%m                  "変更チェック表示
    set statusline+=%r                  "読み込み専用かどうか表示
    set statusline+=%h                  "ヘルプページなら[HELP]と表示
    set statusline+=%w                  "プレビューウインドウなら[Preview]と表示
    set statusline+=%=                  "これ以降は右寄せ表示
    if g:coding_assist == 'coc_nvim'
        set statusline+=%{coc#status()}\ \|\ |      "'neoclide/coc.nvim'のステータス(ソース中のエラー数)を表示
    endif
    set statusline+=fmt:%{&ff}\ \|\ |   "ファイルフォーマット（dos/unix/mac）
    set statusline+=enc:%{&fileencoding}\ \|\ |
    set statusline+=row:%l/%L\ \|\ |    "現在行数/全行数
    set statusline+=col:%c\ |           "現在列数
else    "airlineやlightlineを入れていると[esc]でノーマルモードに戻るのが１テンポ遅れるのを回避
    set timeout
    set ttimeout
    set timeoutlen=1000                 "2個目以降のキーのマッピング待ち時間
    set ttimeoutlen=0                   "キーコード待ち時間
endif

"==== ベル音関連 ====

if (v:version == 704 && has("patch793")) || v:version >= 705    "belloffをサポートしているなら
    set belloff=all         "ベル音を無効化
else
    set visualbell t_vb=    "ベル音を無効化
endif

"==== Tab関連 ====
set expandtab       "Tab文字を半角スペースにする
set tabstop=4       "行頭以外のTab文字の表示幅（スペースいくつ分）
set shiftwidth=4    "行頭でのTab文字の表示幅
nnoremap <silent><C-l> :set list! list?<cr>|    "改行記号、タブ記号、行末スペース表示切り替え[ctrl]+[l]
set nolist                                      "非表示文字(タブ・改行等）を非表示とする
set listchars=eol:￬,tab:>.,trail:_              "不可視文字を可視化
"set listchars=eol:￬,tab:>.,trail:_,space:.     "不可視文字を可視化

"==== 検索関連 ====
set ignorecase      "大文字小文字を区別せずに検索
set incsearch       "検索文字列入力時に順次対象文字列にヒットさせる
set wrapscan        "検索時に最後まで行ったら最初に戻る
set hlsearch        "検索語をハイライト表示
nnoremap <space>n :nohl<cr>|    "検索結果のハイライトを消す[space]→[n]

"Windowsの場合は外部のgrepプログラムを指定を指定（要grep for windowsインストール）
if has('win32') || has ('win64')    " Windows 32bit, Windows 64bit のどちらか
    set grepprg=grep\ -n
endif

"===== 編集中プログラム実行 [F5]キーで実行 =====
"下記に設定を追加する事で対応言語を追加出来ます。
augroup rungroup
    autocmd!
    autocmd BufRead,BufNewFile *.go nnoremap <F5> :exec '!go run' shellescape(@%, 1)<cr>
    autocmd BufRead,BufNewFile *.py nnoremap <F5> :exec '!python' shellescape(@%, 1)<cr>
    autocmd BufRead,BufNewFile *.sh nnoremap <F5> :exec '!bash' shellescape(@%, 1)<cr>
augroup END

"-------------------------------------------------------------------
"===== カラースキーム設定 =====

"if &term == "xterm-256color" || &term == "builtin_gui"

if has('gui_running') || &t_Co > 255  "256色以上なら
    let g:rehash256 = 1
    colorscheme molokai             "molokaiカラースキーム設定
    "コメント、選択時、不可視文字、タブ、検索結果などが見辛いので調整
    hi Comment      ctermfg=246 guifg=#8E9EA1           "コメント
    hi Visual       ctermbg=238 guibg=#605D4D           "範囲選択時
    hi NonText      ctermfg=226 guifg=#ffff00           "不可視文字
    hi SpecialKey   ctermfg=226 guifg=#ffff00 gui=none  "タブ等
    hi Search       ctermfg=196 ctermbg=222 cterm=NONE guifg=#FF0000 "検索結果ハイライト
    hi LineNr       guifg=#bbbbbb   "行番号の色
    hi Special      gui=bold        "特殊なシンボル
    "カラム(桁)ライン表示
    set colorcolumn=100             "カラムラインの位置
    hi ColorColumn  ctermbg=235      "カラムラインの色
elseif &t_Co < 17       "16色以下なら
    "幾つかの設定が暗い青で見辛いので緑に変更
    hi Comment      ctermfg=7
    hi NonText      ctermfg=10
    hi SpecialKey   ctermfg=10
    hi PreProc      ctermfg=10
    "カラム(桁)ライン表示
    "set colorcolumn=100             "カラムラインの位置
    "hi ColorColumn ctermbg=1        "カラムラインの色
endif

"カーソルラインの行番号のハイライトは残しつつ、行のハイライトだけ消す
"注：この設定は「colorschem」の設定後に書く事。また「set cursorline」が設定されている事が前提です
hi clear cursorline

"-------------------------------------------------------------------
"===== プラグインマネージャー「plug」の設定 =====

"最初に一時的にファイルタイプを無効化する
filetype off
filetype plugin indent off

"pluginのパスを指定
if has('win32') || has ('win64')    " Windows 32bit, Windows 64bit のどちらか
    call plug#begin('~/vimfiles/plugged')
else    "それ以外のOS
    call plug#begin('~/.vim/plugged')
endif
"プラグイン登録ここから---------------

"ステータスライン関係
if g:status_plugin == 'airline'
    Plug  'vim-airline/vim-airline'         "ステータスライン拡張
    Plug  'vim-airline/vim-airline-themes'  "vim-airline用テーマ
    Plug  'ryanoasis/vim-devicons'          "特殊アイコン(要NERD FONTS)
elseif g:status_plugin == 'lightline'
    Plug  'itchyny/lightline.vim'           "ステータスライン拡張
endif

"レギュラープラグイン関連
Plug    'scrooloose/nerdtree'               "ファイラー
"Plug    'scrooloose/syntastic'              "
Plug    'tomtom/tcomment_vim'               "コメント切替

"unite関連
Plug    'Shougo/unite.vim'                  "便利ツール
Plug    'Shougo/neomru.vim'                 "unite用mru
Plug    'Shougo/neoyank.vim'                "unite用yank
Plug    'Shougo/unite-outline'              "unite用outline
"Plug    'Shougo/vimproc.vim'                "unite用vimproc

"URL/ブラウザ関連
Plug    'itchyny/vim-highlighturl'            "URLハイライトプラグイン
Plug    'tyru/open-browser.vim'               "ワードやリンクをブラウザで開く

"テンプレート関連
Plug    'mattn/vim-sonictemplate'             "自動初期テンプレート(独自テンプレート追加も可)

"コード補完関連
if  g:coding_assist == 'coc_nvim'
    "コード補完プラグイン「coc.nvim」(要Node.js v12.12.0以上)
    Plug  'neoclide/coc.nvim', {'branch': 'release'}
elseif  g:coding_assist == 'vim_lsp'
    "コード補完プラグイン「vim-lsp」関連（'neoclide/coc.nvim'とは排他）
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/vim-lsp'           "コード補完プラグイン
    Plug 'mattn/vim-lsp-icons'
    Plug 'mattn/vim-lsp-settings'           "言語サーバーを自動的にセットアップしてくれるプラグイン
endif

"プラグイン登録ここまで---------------
call plug#end()
"filetype plugin indent on
filetype plugin on

"============================================
"基本設定はここまで、以下はプラグイン毎の設定
"============================================

"-------------------------------------------------------------------
"===== scrooloose/nerdtree用設定 =====

nnoremap <silent><C-e> :NERDTreeToggle<cr>  "ファイラーを開く [ctrl]+[e]
let NERDTreeQuitOnOpen=1                    "NERDTreeでファイル選択後に自動でNERDTreeを閉じる
let NERDTreeShowHidden=1                    "隠しファイルを表示

"特殊アイコン(要NerdFonts&vim-devicons)を表示(1:する 0:しない）
if g:nerdfont_installed == 'yes'            "NerdFontがインストール済みなら
    let g:webdevicons_enable_nerdtree = 1
else
    let g:webdevicons_enable_nerdtree = 0
endif

"-------------------------------------------------------------------
"===== lightline用設定 =====
if g:status_plugin == 'lightline'
    set noshowmode         "モード表示がlightlineと重複するのでvim標準の方を消す
endif

"-------------------------------------------------------------------
"===== vim-airline/vim-airline-themes用の設定 =====

if g:status_plugin == 'airline'
    "let g:airline_theme = 'wombat'                 "vim-airline用のテーマ指定
    let g:airline_theme = 'powerlineish'            "vim-airline用のテーマ指定
    set noshowmode                                  "モード表示がvim-airlineと重複するのでvim標準の方を消す
    let g:airline#extensions#coc#enabled = 1                        "coc.nvimインテグレーション有効化
    let airline#extensions#coc#error_symbol = 'Err:'                "エラーシンボル
    let airline#extensions#coc#warning_symbol = 'Warn:'             "ワーニングシンボル
    let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'    "エラーフォーマット
    let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'   "ワーニングフォーマット
    let g:airline#extensions#tabline#enabled = 1                    "タブラインを表示
    "Powerlineフォント(要PowerlineFonts or NerdFonts)の使用(1:する 0:しない)
    if g:nerdfont_installed == 'yes'
        let g:airline_powerline_fonts = 1
    else
        let g:airline_powerline_fonts = 0
    endif
    let g:airline#extensions#whitespace#enabled = 1     "行末のスペース(Trailing)チェック（0:しない 1:する）
    nnoremap <space>c :AirlineToggleWhitespace<cr>|     "行末のスペース(Trailing)チェック切替 [space] → [c]
endif

"-------------------------------------------------------------------
"===== Unite用の設定 =====

"let g:unite_enable_start_insert=1              "インサートモードで開始
let g:unite_source_history_yank_enable =1       "ヒストリー/ヤンク機能を有効化
nmap <Space> [unite]|                           "uniteのプレフィックス(修飾)キーの設定 [space]
nnoremap <silent> [unite]a :UniteWithBufferDir -buffer-name=files file<cr>| "[Space]->[a]で編集中のファイルのディレクトリを表示
nnoremap <silent> [unite]f :Unite<Space>file<cr>|            "[Space]->[f] カレントディレクトリを表示
nnoremap <silent> [unite]m :Unite<Space>file_mru<cr>|        "[Space]->[m] 最近開いたファイルを表示
nnoremap <silent> [unite]d :Unite<Space>directory_mru<cr>|   "[Space]->[d] 最近開いたディレクトリを表示
nnoremap <silent> [unite]b :Unite<Space>buffer<cr>|          "[Space]->[b]でバッファを表示
nnoremap <silent> [unite]r :Unite<Space>register<cr>|        "[Space]->[r]でレジスターを表示
nnoremap <silent> [unite]t :Unite<Space>tab<cr>|             "[Space]->[t]でタブを表示
nnoremap <silent> [unite]y :Unite<Space>history/yank<cr>|    "[Space]->[y]でヒストリ/ヤンクを表示
nnoremap <silent> [unite]o :Unite<Space>outline<cr>|         "[Space]->[o]でアウトラインを表示
nnoremap <silent> [unite]<cr> :Unite<Space>file -start-insert file_rec/async:!<cr>|  "[Space]->[ENTER]でカレントディレクトリで入力文字で始まる名前のファイルを絞り込み

"-------------------------------------------------------------------
"===== tyru/open-browser.vim用設定 =====

map <Leader>w <Plug>(openbrowser-search)|               "カーソル下のワードを検索エンジンで検索[\]→[w]
map <Leader>l <Plug>(openbrowser-smart-search)|         "カーソル下のリンクを開く又はワードを検索エンジンで検索[\]→[l]
map <Leader>g :<C-u>execute 'OpenBrowserSearch -gog' expand('<cWORD>')<CR>| "カーソル下のワードをGoogle検索[\]→[g]
map <Leader>b :<C-u>execute 'OpenBrowserSearch -big' expand('<cWORD>')<CR>| "カーソル下のワードをbing検索[\]→[b]
let g:openbrowser_search_engines = {
    \ 'gog': 'https://www.google.co.jp/search?q={query}',
    \ 'big': 'https://www.bing.co.jp/search?q={query}',
    \ }

"-------------------------------------------------------------------
"===== mattn/vim-sonictemplate用の設定 =====

"独自の追加テンプレート用のフォルダを指定
if has('win32') || has ('win64')
    let g:sonictemplate_vim_template_dir = ['~/vimfiles/template']  "Windows用
else
    let g:sonictemplate_vim_template_dir = ['~/.vim/template']      "その他OS用
endif

"-------------------------------------------------------------------
"===== neoclide/coc.nvim用の設定 =====（要Node.js v12.12.0以上）
if g:coding_assist == 'coc_nvim'
    "'neoclide/coc.nvim'が「Ver.8.1.1719」以降のVimでないと警告を表示するので抑制する。
    let g:coc_disable_startup_warning = 1

    "lightlineにcoc.nvimのステータス(ソース中のエラー数)を表示
    if g:status_plugin == 'lightline'
    let g:lightline = {
        \ 'colorscheme': 'powerline',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status'
        \ },
        \ }
    " Use autocmd to force lightline update.
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
    endif
endif

"===== 'tomtom/tcomment_vim' =====
"未対応のコメントタイプのコメントアウトキャラクターを設定

if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif
let g:tcomment_types['text'] = '#%s'
"let g:tcomment_types['phpunit'] = '// %s'
"let g:tcomment_types['twig'] = '{# %s #}'

set cursorline
highlight CursorLine cterm=underline
set cursorcolumn
highlight CursorColumn ctermbg=lightblue
