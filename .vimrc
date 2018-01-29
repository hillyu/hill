"doing the pathogenTrick
"call pathogen#runtime_append_all_bundles()
"cal pathogen#helptags()
"using vundle instead of pathogen
set nocompatible              " required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
"Plugin 'vim-scripts/ShowMarks'
"Plugin 'newclear/vim-pyclewn'
Plugin 'vim-scripts/STL-Syntax'
Plugin 'wavded/vim-stylus'
"Plugin 'vim-scripts/TagHighlight'
"Plugin 'vim-scripts/taglist.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'wincent/command-t'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ujihisa/nclipper.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
"Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-fugitive'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"from dereks vimrc
"Why is this not a default
set hidden

" Don't update the display while executing macros
set lazyredraw

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu
" Add ignorance of whitespace to diff
set diffopt+=iwhite
" Add the unnamed register to the clipboard
set clipboard+=unnamed
" Automatically read a file that has changed on disk
set autoread
"-----------------------------------------------------------------------------
"vimgdb setting, only for patched vim. !Used pyclewn intead as it is more
""featurerich"
"-----------------------------------------------------------------------------
"set previewheight=12
"run macros/gdb_mappings.vim
"set asm=0
"-----------------------------------------------------------------------------
" Personal Keybindings
"-----------------------------------------------------------------------------

" System default for mappings is now the "," character
let mapleader = ";"
" Set the status line the way I like it
"set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
" Set the status line the way i like it
set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" tell Vim to always put a status line in, even if there is only one
" window
"
set laststatus=2

" Hide the mouse pointer while typing
set mousehide

" In general you should endeavour to avoid that type of
" situation because waiting 'timeoutlen' milliseconds is
" like an eternity.
set timeoutlen=500
" Allow the cursor to go in to "invalid" places
set virtualedit=all
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048
" Keep some stuff in the history
set history=100
" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$
" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
if has("mac")
    set guifont=SF\ Mono:h12
    "let g:main_font = "SF_Mono:h14"
    "let g:small_font = "SF_Mono:h9"
    "let g:main_font = "Inconsolata_for_Powerline:h20"
    "let g:small_font = "Inconsolata_for_Powerline:h14"
else
    let g:main_font = "Monospace\\ 9"
    let g:small_font = "Monospace\\ 2"
endif
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


" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*


" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='pdflatex'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 --interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'Skim'
"============================================
"Generic Behavior
"============================================
set hlsearch
set incsearch
"set autoindent
if has("vms")
    set nobackup
else
    set backup
endif
set ruler
syntax on
filetype plugin on
" OPTIONAL: This enables automatic indentation as you type.
filetype plugin indent on
set showcmd
set dictionary+=~/.vim/dict/words
set thesaurus+=~/.vim/dict/thesaurus
if has("gui_running")
    set guioptions=-t
    let g:solarized_termcolors=256
    set lines=51
    set columns=90
endif
"let VIMPRESS=[{'username':'seraph',
"\'password':'zuotintin',
"\'blog_url':'http://blog.podspring.com/'
"\}]
set wrap
set nocp
set textwidth=0
set wrapmargin=0
set number
set cursorline
"set laststatus=2
"set t_Co=256
colorscheme solarized
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='simple'
let g:airline_powerline_fonts =1
let g:airline_symbols.linenr = 'Ξ'

set background=dark
hi SpellBad cterm=underline
"set tags+=~/.vim/tags/gcc
set tags+=./tags,../tags,../../tags,../../../tags,../../../../tags,~/.vim/tags/std,~/.vim/tags/inet,~/.vim/tags/omnet
"let g:easytags_dynamic_files = 1
"make backspace work
set backspace=2


" OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
"autocmd FileType cpp set foldmethod=syntax
"### setting for fuzzyfinder.vim {{{2
"let g:FuzzyFinder_KeySwitchMode = ['<C-t>', '<C-S-t>']
"let g:FuzzyFinder_KeySwitchIgnoreCase = '<C-i>'
"let g:FuzzyFinder_FileModeVars =
"\ { 'excludedPath' : '^\.$\|\.bak$\|\~$\|\.swp$\|\.pyc$\|\.exe$',
"\   'abbrevMap' :
"\    { "wts" : ["~/work/trunk/src", "~/work/trunk/bugfix"],
"\      "vp" : ["~/.vim/plugin"]
"\    }
"\ }
"let g:FuzzyFinder_IgnoreCase = 1
"" don't use Migemo(a japanese search method)
"let g:FuzzyFinder_Migemo = 0

" Map this to select completion item or to finish input and open a
" buffer/file. 1st item is mapped to open in previous window. 2nd item is
" mapped to open in new window which is made from split previous window. 3rd
" item is mapped to open in new window which is made from split previous
" window vertically.
"let g:FuzzyFinder_KeyOpen = ['<CR>', '<C-O>', '<C-V>']
":noremap ,ff :FufFile<CR>
":noremap <leader>fb :FufBuffer<CR>
":noremap <leader>ft :FufTagFile<CR>
":noremap <leader>ff :FufFile<CR>
":noremap <leader>fc :FufMruCmd<CR>
":noremap <leader>fv :FufFavFile<CR>
":noremap <leader>fd :FufDir<CR>
""}}}2
"NerdTree panel
"nmap <silent> <Leader>p <Plug>ToggleProject
"Tlist setting
let Tlist_Use_Right_Window = 1
let Tlist_Display_Prototype = 0
let Tlist_Display_Tag_Scope = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_SingleClick = 1
let Tlist_WinWidth = 40
let tlist_cpp_settings = 'c++;n:namespace;v:variable;d:macro;t:typedef;c:class;g:enum;s:struct;u:union;f:function;m:member;p:prototype'
let Tlist_Show_One_File = 1
let Tlist_Close_On_Select = 1
"let NERDTreeQuitOnOpen = 1
"Project List
"let g:proj_flags='Lcgimst'
"let g:proj_window_increment=40
"let g:EasyGrepFileAssociations='/Users/hill/.vim/plugin/EasyGrepFileAssociations'
"let g:EasyGrepMode=2
"let g:EasyGrepCommand=0
"let g:EasyGrepRecursive=1
"let g:EasyGrepIgnoreCase=0
"let g:EasyGrepHidden=0
"let g:EasyGrepAllOptionsInExplorer=1
"let g:EasyGrepWindow=0
"let g:EasyGrepReplaceWindowMode=0
"let g:EasyGrepOpenWindowOnMatch=1
"let g:EasyGrepEveryMatch=0
"let g:EasyGrepJumpToMatch=0
"let g:EasyGrepInvertWholeWord=0
"let g:EasyGrepFileAssociationsInExplorer=0
"let g:EasyGrepOptionPrefix='<leader>vy'
"let g:EasyGrepReplaceAllPerFile=0
"let g:EasyGrepSearchCurrentBufferDir=1
"let g:EasyGrepWindowPosition='botright'
"Powerline setup
"let g:Powerline_symbols = 'fancy'
"supertab setting
"####################################################################################################
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-n>"
"####################################################################################################

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"
"let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"let g:UltiSnipsListSnippets="<c-l>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            html indentation                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
"-----------------------------------------------------------------------------
"the fswitch setting
"-----------------------------------------------------------------------------
au BufEnter *.cc,*.cpp let b:fswitchlocs = 'reg:/src/include/,ifrel:|/src/|../include|,./' | let b:fswitchdst = 'h, hpp'
au BufEnter *.h let b:fswitchdst = 'cc,cpp' | let b:fswitchlocs = 'reg:/include/src/,ifrel:|/include/|../src|,./'
"auto tag generation, UpdateTypesFile provide a better ctag generation
"au BufWritePost,FileWritePost *.[ch],*.[ch]pp,*.cc :UpdateTypesFileOnly
au CursorHold *.[ch],*.[ch]pp,*.cc :ReadTypes
"let &mp = 'ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q'
nmap <silent> <leader>h :FSSplitRight<CR>
"set file encoding list order.
set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,latin1
set encoding=utf-8
":noremap <leader>o :TlistToggle<CR>
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
map <leader>tt :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"nmap<leader>ec :e ~/.vim/bundle/EasyColor/colors/desert_thl.txt<CR>
" If the current buffer has never been saved, it will have no name,
" " call the file browser to save it, otherwise just save it.
nnoremap <F2> :w<CR>
inoremap <F2> <ESC>:w<CR>
"highlight python
let python_highlight_all=1
"plugin related settings
let g:SimpylFold_docstring_preview=1
"let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
"mark white space as bad:
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"youcompleteme autocompletion support
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 1

