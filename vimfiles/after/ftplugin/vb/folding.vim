let markerStart = "'region"
let markerEnd = "'endregion"
let markers = markerStart.','.markerEnd

setlocal foldmethod=marker
execute "setlocal foldmarker=".markers

" Si l'on veut fonctionner par expression, commenté ce qu'il a au dessus
" et décommenter ce qui vient en dessous. Il faudra aussi adapter VBSFoldText
"function! VBSFolds()
"  let thisline = getline(v:lnum)
"  if match(thisline, "^'####") >= 0
"    return ">4"
"  elseif match(thisline, "^'###") >= 0
"    return ">3"
"  elseif match(thisline, "^'##") >= 0
"    return ">2"
"  elseif match(thisline, "^'#") >= 0
"    return ">1"
"  else
"    return "="
"  endif
"endfunction
"setlocal foldmethod=expr
"setlocal foldexpr=VBSFolds()

function! VBSFoldText(markerStart)
  let foldsize = (v:foldend-v:foldstart)
  let description = strpart(getline(v:foldstart), strlen(a:markerStart) + 1)
  return description.' ('.foldsize.' lines)'
endfunction
setlocal foldtext=VBSFoldText(markerStart)