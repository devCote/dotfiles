" GOYO setup
let g:goyo_width=100
let g:goyo_height=70

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
