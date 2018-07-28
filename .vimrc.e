"
" .vimrc
"

set nocompatible

" 行番号表示
set number

" 括弧の対応をハイライト
set showmatch

" 不可視文字表示
set list

" 不可視文字の表示形式
set listchars=tab:>-,trail:_,extends:>,precedes:<

" 印字不可能文字を16進数で表示
set display=uhex

" カーソル行と列をハイライト
set cursorline
"set cursorcolumn

" 高速ターミナル接続を行う
set ttyfast

" スクロール時の余白確保
set scrolloff=5

" 一行に長い文章を書いていても自動折り返しをしない
set textwidth=0

" バックアップ取らない
set nobackup

" 他で書き換えられたら自動で読み直す
set autoread

" スワップファイル作らない
set noswapfile

" 編集中でも他のファイルを開けるようにする
set hidden

" バックスペースでなんでも消せるように
set backspace=indent,eol,start

" テキスト整形オプション，マルチバイト系を追加
set formatoptions=lmoq

" ビープをならさない
set vb t_vb=

" Exploreの初期ディレクトリ
set browsedir=buffer

" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

" コマンドをステータス行に表示
set showcmd

" 現在のモードを表示
set showmode

" viminfoファイルの設定
set viminfo='50,<1000,s100,\"50

" モードラインは無効
"set modelines=0

" title表示
set title

" OSのクリップボードを使用する
"set clipboard+=unnamedplus

" ターミナルでマウスを使用できるようにする
if has('mouse')
	set mouse=a
	set guioptions+=a
	set ttymouse=xterm2
endif

" ファイルタイプ判定をon
filetype plugin on

"カーソル位置がずれないようにする
set ambiwidth=double

" コマンド補完を強化
set wildmenu
" コマンド補完を開始するキー
set wildchar=<tab>
" リスト表示，最長マッチ
set wildmode=full
" コマンド・検索パターンの履歴数
set history=1000
" 補完に辞書ファイル追加
set complete+=k

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline

"set foldenable
"set foldmethod=syntax
"set foldmethod=marker
"set foldcolumn=6

" Tabキーを空白に変換
"set expandtab

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
" autocmd BufWritePre * :%s/\t/  /ge

" デフォルトエンコーディング
set encoding=utf-8

" 文字コード
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

" ワイルドカードで表示するときに優先度を低くする拡張子
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,
			\.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" 自動でインデント
set autoindent

" ペースト時にautoindentを無効に
set paste

" 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする
set smartindent

" Cプログラムファイルの自動インデントを始める
set cindent

" tab幅 8
set tabstop=8 shiftwidth=8 softtabstop=0

" 矩形選択で自由に移動する
set virtualedit+=block

" 最後まで検索したら先頭へ戻る
set wrapscan

" 大文字小文字無視
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" インクリメンタルサーチ
set incsearch

" 検索文字をハイライト
set hlsearch

" コマンドラインの高さ
set cmdheight=2

" 常にステータスラインを表示
set laststatus=2

" カーソルが何行目の何列目に置かれているかを表示する
set ruler

" Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash

" ハイライト on
if has('syntax')
	syntax on
endif

set t_Co=256

" テーマカラー
"colorscheme torte
colorscheme molokai

"set textwidth=0
"if exists('&colorcolumn')
"	set colorcolumn=+1
"endif


" カレントウィンドウにのみ罫線を引く {{{
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END
"}}}


" 文字コードの自動認識 {{{
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconvがeucJP-msに対応しているかをチェック
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	" iconvがJISX0213に対応しているかをチェック
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	" fileencodingsを構築
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	" 定数を処分
	unlet s:enc_euc
	unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" カーソル位置がずれないようにする
if exists('&ambiwidth')
	set ambiwidth=double
endif
"}}}


" ステータスラインに文字コードやBOM、16進表示等表示 {{{
if has('iconv')
	set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P
else
	set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L%8P
endif

function! FencB()
	let c = matchstr(getline('.'), '.', col('.') - 1)
	let c = iconv(c, &enc, &fenc)
	return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
	return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
	return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction
"}}}

