" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" fuzzy searcher
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" zen mode : love !!!
Plug 'junegunn/goyo.vim'
"Plug 'frazrepo/vim-rainbow' "color braces plugin
Plug 'chemzqm/vim-jsx-improve'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
"Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'christoomey/vim-tmux-navigator'

" themes
Plug 'gruvbox-community/gruvbox'

Plug 'kjwon15/vim-transparent' " transparent background
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
"Plug 'mxw/vim-jsx'

" Initialize plugin system
call plug#end()

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

nmap <C-e> :Rg<Cr>

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" for mxv/vim-jsx setup only jsx files
"let g:jsx_ext_required = 1
let g:fzf_layout = {'up':'100%', 'window': { 'width': 1.0, 'height': 1.0,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
"let g:fzf_preview_window = ['up:80%:hidden', 'ctrl-x']

" move blocks
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

set clipboard=unnamedplus " share vim clip and sys clip

" color braces
let g:rainbow_active = 1

let g:jsx_improve_javascriptreact = 0
let NERDTreeShowHidden=1

" Russian keymap
:set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" nerd tree keys
inoremap jk <ESC>
nmap <C-n> :NERDTreeToggle<CR>

" nerd comment keymap
nnoremap <C-o> :call NERDComment(0,"toggle")<CR>
vnoremap <C-o> :call NERDComment(0,"toggle")<CR>

" escape parantasis
:inoremap <C-j> <Esc>/[)}"'\]>]<CR>:nohl<CR>a
:vnoremap _( <Esc>`>a)<Esc>`<i(<Esc>


" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocm

" python run script F9
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         


let g:NERDTreeIgnore = ['^node_modules$']

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync


" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

set relativenumber
set nu rnu

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab

colorscheme gruvbox
set background=dark

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
"autocmd BufEnter * call SyncTree()

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  \ 'coc-pairs',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_nfo()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" {\n after curly braces open}
inoremap <leader><Cr> <Cr><Cr><UP><tab><tab>

" remove highlight
nmap <C-i> :nohl<Cr>
"
" Colorize line numbers in insert and visual modes
" ------------------------------------------------
function! SetCursorLineNrColorInsert(mode)
    " Insert mode: blue
    if a:mode == "i"
        highlight CursorLineNr ctermfg=4 guifg=#268bd2

    " Replace mode: red
    elseif a:mode == "r"
        highlight CursorLineNr ctermfg=1 guifg=#dc322f

    endif
endfunction


"function! SetCursorLineNrColorVisual()
    "set updatetime=0

    "" Visual mode: orange
    "highlight CursorLineNr ctermfg=9 guifg=#cb4b16
"endfunction


"function! ResetCursorLineNrColor()
    "set updatetime=4000
    "highlight CursorLineNr ctermfg=3* guifg=#073642
"endfunction


"vnoremap <silent> <expr> <SID>SetCursorLineNrColorVisual SetCursorLineNrColorVisual()
"nnoremap <silent> <script> v v<SID>SetCursorLineNrColorVisual
"nnoremap <silent> <script> V V<SID>SetCursorLineNrColorVisual
"nnoremap <silent> <script> <C-v> <C-v><SID>SetCursorLineNrColorVisual


"augroup CursorLineNrColorSwap
    "autocmd!
    "autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
    "autocmd InsertLeave * call ResetCursorLineNrColor()
    "autocmd CursorHold * call ResetCursorLineNrColor()
"augroup END

" status line color func
"function! InsertStatuslineColor(mode)
  "if a:mode == 'i'
    "hi statusline guibg=DarkGreen ctermfg=6 guifg=Black ctermbg=0
  "elseif a:mode == 'r'
    "hi statusline guibg=DarkYellow ctermfg=3 guifg=Black ctermbg=0
  "elseif a:mode == 'v'
    "hi statusline guibg=DarkGreen ctermfg=2 guifg=Black ctermbg=0
  "else
    "hi statusline guibg=DarkRed ctermfg=4 guifg=Black ctermbg=0
  "endif
"endfunction

"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi statusline ctermfg=0*  ctermbg=2
"au UIEnter * call InsertStatuslineColor(v:hlsearch)
"au UILeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=Grey ctermbg=0

" default the statusline to green when entering Vim
hi StatusLine ctermfg=0 cterm=Bold ctermbg=NONE

" Formats the statusline
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
" right side
set statusline+=\ %=                        " align left
set statusline+=%t\                           " file name
set statusline+=%l/%L\ [%p%%]            " line X of Y [percent of file]

" GOYO setup
let g:goyo_width=88
let g:goyo_height=37

nmap <leader>z :Goyo<Cr>

function! s:goyo_enter()
  set signcolumn=no
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  " ...
endfunction

function! s:goyo_leave()
  set signcolumn=yes
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  " ...
hi StatusLine ctermfg=10 cterm=Bold ctermbg=NONE
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
