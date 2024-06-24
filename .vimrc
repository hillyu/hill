set nocp
"Auto install vim-plug from github address.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'altercation/vim-colors-solarized'
" Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish' "provides subvert coerce to handle search and cases
Plug 'tpope/vim-commentary'
Plug 'chrisbra/matchit'
Plug 'lervag/vimtex'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/vis'
" Plug 'vim-scripts/STL-Syntax' ,{'for': 'cpp'}
" Plug 'wavded/vim-stylus' ,{'for': 'stylus'}
" Plug 'vim-python/python-syntax'
" Plug 'vim-scripts/indentpython.vim' ,{'for': 'python'} " not used
" Plug 'tmhedberg/SimpylFold' ,{'for': 'python'}
Plug 'jpalardy/vim-slime', {'for': 'python'}
Plug 'vimwiki/vimwiki'
" Plug 'prabirshrestha/async.vim'
" Plug 'maralla/completor.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
call plug#end()

"============================================
"Generic Behavior
"============================================
let mapleader = " "
set hlsearch
set incsearch
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,popup
if has("vms")
    set nobackup
else
    set backup
endif
syntax on
set scrolloff=5
" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" OPTIONAL: This enables automatic indentation as you type.
filetype plugin indent on
set showcmd
" set dictionary+=~/.vim/dict/words
" set thesaurus+=~/.vim/dict/thesaurus
" set background fixed a bug in kitty termnal
let &t_ut=''
if has("gui_running")
    set guioptions=-t
    let g:solarized_termcolors=256
    set lines=51
    set columns=90
endif
colorscheme solarized
" colorscheme catppuccin_latte
" colorscheme catppuccin_macchiato
set background=dark
hi Normal ctermbg=None
" hi clear SpellBad
hi SpellBad cterm=underline
hi SignColumn ctermbg=0
hi Visual ctermbg=14 ctermfg=8
set wrap
set textwidth=0
set ambiwidth=double
set wrapmargin=0
set number
set cursorline
set cursorcolumn
set ignorecase
set smartcase
set incsearch
" let &t_SI="\<Esc>[5 q"
" let &t_EI="\<Esc>[2 q"
"Mode Settings
"
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[3 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" netrw settings
" disable file explore banner
let g:netrw_banner = 0
let g:netrw_browse_split = 4
" let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_preview = 1
nnoremap <leader>f :Vex <cr>

"tag path
set tags+=./tags,../tags,../../tags,../../../tags,../../../../tags

"make backspace work
set backspace=2

 "set path to do fuzzy search
set path+=~/.config,~/bin
set path+=**

" fix vim c-w c-u not recoverable, will will use normalmode db and d0 command
" for replacement then we can bind c-y to c-r " in insertmode to recover what
" we have used before.
inoremap <silent> <C-W> <C-\><C-O>db
inoremap <silent> <C-U> <C-\><C-O>d0

" set directory for swp files //fixed a bug of E303 Error
set directory=~/.vim/swap,.

"do not destroy the buffer when not active
set hidden

" add spell suggestion to completion list
set complete+=kspell

" Don't update the display while executing macros
set lazyredraw

" At least let yourself know what mode you're in
" not needed because of airline
"set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Add the unnamed register to the clipboard, conflict with my yank script so
" disble
" if has("unnamedplus")
"     set clipboard=unnamedplus
" else
"     set clipboard=unnamed
" endif

" Automatically read a file that has changed on disk
set autoread

" Set the status line the way I like it overrided by vim-airline
"set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" tell Vim to always put a status line in, even if there is only one
" window
set laststatus=2

"use modelines the line in the file that set config for vim
set modelines=5

" Hide the mouse pointer while typing
set mousehide

" In general you should endeavour to avoid that type of
" situation because waiting 'timeoutlen' milliseconds is
" like an eternity.
set timeoutlen=500

" Allow the cursor to go in to "invalid" places
set virtualedit=block

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" Keep some stuff in the history
set history=100

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Font settings
if has("mac")
    set guifont=SF\ Mono:h12
else
    let g:main_font = "Monospace\\ 9"
    let g:small_font = "Monospace\\ 2"
endif

"set spell checking
set spell spelllang=en_us

"set file encoding list order.
set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,latin1
set encoding=utf-8

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            osc52 clipboard sync                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function OscyankRegister()
    "" Put current register's content to 'text'
 "let text = @"
 "" Put text with OSC52
 "let executeCmd="echo -n '".text."' | yank.sh"
 "call system(executeCmd)
 "echom "clipboard sync complete"
"endfunction

"nnoremap <silent> <leader>y :call OscyankRegister()<cr>
"nnoremap  <leader>y :call OscyankRegister()<cr>
"nnoremap  <leader>y :call OscyankRegister()<cr>
nnoremap  <leader>y :call system("yank.sh", @")<cr> :echom "clipboard sync complete"<cr>
autocmd! TextYankPost * call system("yank.sh", v:event.regcontents)
" no need for following map anymore since above autocmd took care of
" everything.
" override default yank
" nnoremap <expr> y MyYank(1,1)
" xnoremap <expr> y MyYank(1,1)
"only works on vim 8.2+
" nnoremap yy yy:call system("yank.sh", @")<cr>
" xnoremap<silent> Y Y:call system("yank.sh", @")<cr>

	"function MyYank(type,...) abort
	"  if a:0 
	"    set opfunc=MyYank
	"    return 'g@'
 	  "endif

	"  let sel_save = &selection
	"  let visual_marks_save = [getpos("'<"), getpos("'>")]

	"  try
	"    set clipboard= selection=inclusive
        "" unfortunately below only works on vim 8.2>
	"    "let commands = #{line: "'[V']y", char: "`[v`]y", block: "`[\<c-v>`]y"}
	"    " silent exe 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')
	"    "exe 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')
	"	if a:type == 'block'
	"		exe "noautocmd keepjumps normal! `[\<c-v>`]y"
	"	elseif a:type == 'line'
	"		silent exe "normal! '[V']y"
	"	else
            "silent exe "normal! `[v`]y"
        "endif
        "call system("yank.sh", @")
	"  finally
	"    call setpos("'<", visual_marks_save[0])
	"    call setpos("'>", visual_marks_save[1])
	"    let &selection = sel_save
	"  endtry
	"endfunction


nnoremap   <leader>dm :!daily_update_email.sh '%' <cr>
let @b = 'i|:.,+1s/\n/|/gAh| |j0'
let h = '|Cat.|Detail|Time spent|Status|'
nnoremap   <leader>dc I\|Cat.\|Detail\|Time spent\|Status\|<cr><Esc>20@b
nnoremap <leader>da  :read !diary2report.sh %<cr>
:nnoremap <leader>s a<C-X><C-S>
"-----------------------------------------------------------------------------
" mark down review using bin/mdv
"-----------------------------------------------------------------------------
"nnoremap  <silent> <leader>mdv :! mdv % <cr>
nnoremap   <leader>mdv :!md2html '%' & <cr><cr>
" nnoremap   <leader>mdv :!typora '%' & <cr><cr>
"-----------------------------------------------------------------------------
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------

iab teh       the
iab Teh       The
iab taht      that
iab Taht      That
iab alos      also
iab Alos      Also
iab aslo      also
iab Aslo      Also
iab becuase   because
iab Becuase   Because
iab bianry    binary
iab Bianry    Binary
iab bianries  binaries
iab Bianries  Binaries
iab charcter  character
iab Charcter  Character
iab charcters characters
iab Charcters Characters
iab exmaple   example
iab Exmaple   Example
iab exmaples  examples
iab Exmaples  Examples
iab shoudl    should
iab Shoudl    Should
iab seperate  separate
iab Seperate  Separate
iab fone      phone
iab Fone      Phone

"-----------------------------------------------------------------------------
"plugin specific settigns
"-----------------------------------------------------------------------------

" tex settings
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='pdflatex'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 --interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'Skim'

 "airline settings
"if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
  "endif
"let g:airline_theme='dark'
"let g:airline_powerline_fonts =1
"let g:airline_symbols.linenr = 'Ξ'
"for ambiwidth=double
"let g:airline#extensions#ale#enabled = 1
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#bufferline#enabled = 1

" Vimwiki setting
"let g:vimwiki_table_mappings=0
" nmap ]w <Plug>VimwikiNextLink
" nmap [w <Plug>VimwikiPrevLink
nmap <leader>w<space> <Plug>VimwikiToggleListItem
nmap l <Plug>VimwikiTableMoveColumnRight
nmap h <Plug>VimwikiTableMoveColumnLeft
vmap <leader>w<space> <Plug>VimwikiToggleListItem
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \'auto_export':1,
            \'automatic_nested_syntaxes':1,
            \'path_html': '$HOME/_site',
            \'template_path': '$HOME/.local/share/pandoc/templates',
            \'template_default':'github',
            \'template_ext':'.html',
            \'custom_wiki2html': '$HOME/bin/wiki2html.sh',
            \'autotags': 1,
            \'auto_header' : 1,
            \ 'syntax': 'markdown', 'ext': '.md'}]
"ALE settings
let b:ale_linters = ['flake8']
let b:ale_fixers = [
\   'remove_trailing_lines',
\   'isort',
\   'ale#fixers#generic_python#BreakUpLongLines',
\   'yapf',
\]

"slime setting to send code to tmux REPL ipython
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1
"for vim slime In visual mode, send selection
xmap <leader>r <Plug>SlimeRegionSend
nmap <leader>r <Plug>SlimeParagraphSend
nmap <leader>v <Plug>SlimeConfig

"simplyFOld settings
let g:SimpylFold_docstring_preview=1

" ultiships settings
let g:UltiSnipsExpandTrigger = '<nop>'
let g:UltiSnipsEditSplit="vertical"
let g:ulti_expand_or_jump_res = 0
autocmd FileType js UltiSnipsAddFiletypes javascript-jasmine
" autocmd FileType python UltiSnipsAddFiletypes python
autocmd FileType vimwiki UltiSnipsAddFiletypes markdown

function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<C-y>"
    endif
endfunction
function ExpandSnippetOrTab()
    let snippet = UltiSnips#ExpandSnippet()
    if g:ulti_expand_res > 0
        return snippet
    else
        if exists("g:loaded_vimwiki")
            return vimwiki#tbl#kbd_tab()
        else
            return "\<Tab>"
        endif
    endif
endfunction
inoremap <c-x><c-k> <c-x><c-k>
inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"
inoremap <expr> <tab> pumvisible() ? "\<C-n>" : "\<C-R>=ExpandSnippetOrTab()\<CR>"
inoremap <expr> <s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"

" override vimwiki tab binding, it is filetype mapping so use autocmd to
" rebind
autocmd FileType vimwiki inoremap <silent><buffer> <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "<Esc>:VimwikiReturn 1 5<CR>"
autocmd FileType vimwiki inoremap <silent> <buffer> <expr> <tab> pumvisible() ? "\<C-n>" : "\<C-R>=ExpandSnippetOrTab()\<CR>"
autocmd FileType vimwiki inoremap <silent> <buffer> <expr> <s-tab> pumvisible() ? "\<C-p>" : vimwiki#tbl#kbd_shift_tab() 

"html indentation [no longer using]
"let g:html_indent_inctags = "html,body,head,tbody"
"let g:html_indent_script1 = "inc"
"let g:html_indent_style1 = "inc"


"the fswitch setting [no longer using]
"au BufEnter *.cc,*.cpp let b:fswitchlocs = 'reg:/src/include/,ifrel:|/src/|../include|,./' | let b:fswitchdst = 'h, hpp'
"au BufEnter *.h let b:fswitchdst = 'cc,cpp' | let b:fswitchlocs = 'reg:/include/src/,ifrel:|/include/|../src|,./'

"python highlight settings
" let g:python_highlight_all = 1
"LSP Keybindings

function! s:on_lsp_buffer_enabled() abort
    " setlocal omnifunc=lsp#complete
    " setlocal lsp_preview_float=0
    " setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    " nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    " let g:lsp_format_sync_timeout = 1000
    let g:lsp_diagnostics_virtual_text_enabled = 0
    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction
augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
hi lspReference ctermfg=7 ctermbg=4
let g:lsp_diagnostics_echo_cursor=1
" let g:lsp_diagnostics_float_cursor=1
let g:lsp_hover_ui = 'float'
" let g:lsp_hover_conceal = 0
" there is a bug with getreviewwinid so following will not work
" augroup lsp_float_colours
" 	autocmd!
" 	if !has('nvim')
" 		autocmd User lsp_float_opened
" 					\ call setwinvar(lsp#ui#vim#output#getpreviewwinid(),
" 					\		       '&wincolor', 'PopupWindow')
" 	else
" 		autocmd User lsp_float_opened
" 					\ call nvim_win_set_option(
" 					\   lsp#ui#vim#output#getpreviewwinid(),
" 					\   'winhighlight', 'Normal:PopupWindow')
" 	endif
" augroup end

"asyncomplete and supported completors
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'priority': 100,
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
        \    'max_buffer_size': 5000000,
    \  },
    \ }))
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
let g:asyncomplete_min_chars = 2
function! s:sort_by_priority_preprocessor(options, matches) abort
	let l:items = []
	for [l:source_name, l:matches] in items(a:matches)
		for l:item in l:matches['items']
			if stridx(l:item['word'], a:options['base']) == 0
				let l:item['priority'] =
							\ get(asyncomplete#get_source_info(l:source_name),'priority',0)
				call add(l:items, l:item)
			endif
		endfor
	endfor
	let l:items = sort(l:items, {a, b -> b['priority'] - a['priority']})
	call asyncomplete#preprocess_complete(a:options, l:items)
  endfunction
let g:asyncomplete_preprocessor = [function('s:sort_by_priority_preprocessor')]
"-----------------------------------------------------------------------------
" Personal Keybindings
"-----------------------------------------------------------------------------
" System default for mappings is now the "," character
au BufEnter *.py map <leader>tt :!ctags -R --languages=python -f ./tags .<CR>
" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <leader>qq :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" Let's make it easy to edit this file (mnemonic for the key sequence is
" 'e'dit 'v'imrc)
nmap <silent> <leader>ev :e $MYVIMRC<cr>
" And to source this file as well (mnemonic for the key sequence is
" 's'ource 'v'imrc)
nmap <silent><leader>sv :so $MYVIMRC<cr>
":noremap <leader>p ::NERDTreeToggle<CR>
" build tags of your own project with Ctrl-F12
"map <leader>tt :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"
"mark white space as bad in python:
hi BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"override my highlight settings for pum 
hi Pmenusel ctermfg=4 ctermbg=7
" floating popup uses same Highlight, so switch off cterm=revers using clear
hi clear Pmenu 
" hi Pmenu ctermfg=4 ctermbg=8
hi Pmenu ctermfg=15 ctermbg=8
autocmd BufWritePost ~/src/dwmblocks/config.h !cd ~/src/dwmblocks/; sudo make clean install && { killall -q dwmblocks;setsid dwmblocks & }
autocmd BufWritePost ~/src/dwmblocks_official/blocks.h !cd ~/src/dwmblocks_official/; sudo make clean install && { killall -q dwmblocks;setsid dwmblocks & }
autocmd BufWritePost ~/src/st-my-build/config.h !cd ~/src/st-my-build/; sudo make clean install
autocmd BufWritePost ~/src/dwm/config.h !cd ~/src/dwm/; sudo make clean install
autocmd BufWritePost ~/src/dwmblocks-async/config.h !cd ~/src/dwmblocks-async/; sudo make clean install
autocmd BufWritePost ~/src/dwl/config.h !cd ~/src/dwl/; sudo make clean install
autocmd BufWritePost ~/dotfiles/bin/desk_dash.sh !pgrep nwg-wrapper|xargs kill -9 2>&1; desk_dash.sh >/dev/null 2>&1
