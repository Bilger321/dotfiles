filetype plugin indent on                                 
syntax on                                                 
set encoding=utf-8                                        
set clipboard=unnamedplus                                 
set number                                                
set pastetoggle=<F2>

"""" Vim Appearance                                      
" Search settings                                         
set hlsearch " highlight                                    
set incsearch " jump to best fit                          
" Turn off search highlighting with <CR>.                   
nnoremap <CR> :nohlsearch<CR><CR>                         
" Tab settings                                            
set autoindent                                            
set smartindent                                           
set tabstop=4                                             
set shiftwidth=4                                          
set expandtab                                             
" Make statusline appear even with only single window.    
set laststatus=2     
" Jenkinsfile syntax highlighting (a la groovy)
au BufNewFile,BufRead Jenkinsfile setf groovy
" Jenkinsfile syntax highlighting (a la groovy)
au BufNewFile,BufRead *.gradle setf groovy

"""" Fix indentation on .yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"""" F2 to disable auto-indenting on paste (paste mode on)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"""" File browser tweaks
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-n> :call ToggleVExplorer()<CR>
