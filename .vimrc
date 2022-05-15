call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'rust-lang/rust.vim'

" Initialize plugin system
call plug#end()

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
