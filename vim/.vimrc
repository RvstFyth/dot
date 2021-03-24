" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'mralejandro/vim-phpdoc'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
call plug#end()

" Load coc configuration
source ~/.coc-vim

set t_Co=256

" colors zenburn
" autocmd vimenter * ++nested colorscheme gruvbox
set background=dark
colorscheme PaperColor
set number
set laststatus=2
let g:airline_theme='wombat'

" Set cursors for modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Highlight current line
set cul

" Toggle linenumbers with F3
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

" Open nerdtree with F7
noremap <F7> :NERDTreeToggle<CR>

" display dot files for NERDTree
let NERDTreeShowHidden=1

" Jump to linting errors
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

let g:ale_sign_column_always = 1
let g:ale_sign_error = '⚑'
let g:ale_sign_warning = '⚐'

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

nmap <F6> <Plug>(ale_fix)

nmap <silent> \gs :split<CR><Plug>(coc-definition)
nmap <silent> \gv :vsplit<CR><Plug>(coc-definition)

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" FZF
nnoremap <S-C-N> :Files<CR>
nnoremap <S-C-F> :Rg<CR>
nnoremap <S-C-P> :BTags<CR>
nnoremap <S-C-O> :Buffers<CR>

nnoremap <space>e :CocCommand explorer<CR>

let g:syntastic_javascript_eslint_exe = 'npm run eslint --'

nmap <Leader>d :call PhpDocPasteComment()<CR>

nnoremap <leader>t :wincmd b \| bel terminal<CR>
inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
