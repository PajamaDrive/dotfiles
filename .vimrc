" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
"set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
" カラースキーマを設定
colorscheme murphy


" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" キーバインド
" 選択部分をクリップボードに切り取り
vmap <C-X> "*d<ESC>
" 元に戻す
nnoremap <C-Z> u
inoremap <C-Z> <ESC>ui
" Yで行末までコピー
nnoremap Y y$

" vim-cheatsheet
let g:cheatsheet#cheat_file = '~/.cheatsheet.md'

" winresizer
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" vim-airline
let g:airline_theme = 'luna'
set laststatus=2
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
"let g:airline_section_c = '%t'
function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode', ' '])
    let g:airline_section_b = airline#section#create_left(['branch', 'file'])
    let g:airline_section_c = airline#section#create(['%{getcwd()}'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
let g:airline_section_x = '%{&filetype}'
"let g:airline_section_z = '%3l:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
"let g:airline#extensions#ale#error_symbol = ' '
"let g:airline#extensions#ale#warning_symbol = ' '
let g:airline#extensions#default#section_truncate_width = {}
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTabet g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
   \ '0': '0 ',
   \ '1': '1 ',
   \ '2': '2 ',
   \ '3': '3 ',
   \ '4': '4 ',
   \ '5': '5 ',
   \ '6': '6 ',
   \ '7': '7 ',
   \ '8': '8 ',
   \ '9': '9 '
   \}

" vim-gitgutter
" ghでdiffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
nnoremap gp :GitGutterPreviewHunk<CR>
" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red
highlight GitGutterAddLine ctermbg=darkgreen ctermfg=lightgray
highlight GitGutterChangeLine ctermbg=darkcyan ctermfg=lightgray
highlight GitGutterDeleteLine ctermbg=darkred ctermfg=lightgray
set updatetime=250

" その他設定
set clipboard=unnamedplus
