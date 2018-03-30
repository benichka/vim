set nocompatible

" Placement du fichier _viminfo où l'on veut
set viminfo='1000,n$VIM/viminfo

let $UTILS="C:/00\ -\ Data/zz\ -\ Utilitaires"

" redéfinition de la touche leader, et par effet de bord de la touche , par
" défaut pour bien gérer la recherche avec "f"
let mapleader=','
noremap \ ,

" gestion des ressources externes
" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin
" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" gestion des tabs et spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" gestion des plugins
filetype plugin on

" pas de undofile
set noundofile

" gestion des fichiers temporaires et de backup
" set backupdir=C:\\00\ -\ Data\\temp\\
set backupdir=$VIM\temp

set langmenu=en_GB.UTF-8    " sets the language of the menu (gvim)
let $LANG = 'en_GB'         " sets the language of the messages / ui (vim)

" réglage de la taille de la fenêtre
set lines=60 columns=150

" affichage du numéro de ligne
set number

" gestion des fichiers xml
au FileType xml setlocal equalprg=\"$VIM\"\\lib\\bin\\xmllint\ --format\ --recover\ -\ 2>/dev/null

" gestion de l'encoding par défaut
set encoding=utf-8

" positionnement automatique sur le répertoire où l'on se trouve
set autochdir

" changement du répertoire de travail
cd C:\00\ -\ Data\temp

" gestion de l'encodage des fichiers (vim va les essayer tous et voir celui
" qui convient)
set fileencodings=ucs-bom,utf-8,cp1252,latin1

" par défaut, on crée un fichier au format UNIX
set fileformats=unix,dos

" La touche espace provoque le toggle des fold
nnoremap <Space> za

" changement de la couleur et de la police par défaut
if has("gui_running")
  set guifont=Consolas
  " gestion de l'affichage des caractères invisibles
  set list
  set listchars=tab:→→,eol:¬,trail:·
  set background=light
  colors peaksea 
" Attention : ne fonctionne que avec ConEmu
else
" highlight Normal ctermfg=grey ctermbg=darkblue
  set term=xterm
  set lines=60 columns=150
  set t_Co=256
  set background=light
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  " gestion de l'affichage des caractères invisibles : vérifier avant que la
  " console est avec la police Consolas, ou que les caractères sont bien gérés
  " par la police choisie
  set list
  set listchars=tab:→→,eol:¬,trail:·

  " Problème avec la touche backspace sur ConEmu
  inoremap <Char-0x07F> <BS>
  nnoremap <Char-0x07F> <BS>

  colorscheme peaksea
endif

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ "\<cmd"
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" remap de la touche ~ pour comportement à la Word pour le case switch
" (fonctionne sur la sélection)
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

