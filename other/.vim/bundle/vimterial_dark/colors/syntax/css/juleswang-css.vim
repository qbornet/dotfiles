" Vim color file
"
" This file is part of the vimterial_dark colorscheme by
" Lorenzo Ruiz <lars.bs@hotmail.com>. See full
" LICENSE for details.
"
" Maintainer: Lorenzo Ruiz <lars.bs@hotmail.com>
" URL: https://github.com/larsbs/vimterial_dark


" CSS Highlighting "{{{
" ================
" Common
Hi cssProp                  g:paleblue          g:ignore
"hi cssAttr
hi link cssTagName          Statement
"hi cssIdentifier
"hi cssDefinition
Hi cssClassName             g:blue              g:ignore
hi link cssPseudoClass      cssClassName
hi link cssPseudoClassId    cssClassName
hi link cssNoise            Noise
" JulesWang plugin
hi link cssBraces           Noise
" }}}
