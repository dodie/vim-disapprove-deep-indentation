" Vim plugin to disapprove deeply indented lines.
" Maintainer:           David Csakvari
" URL:                  https://github.com/dodie/vim-disapprove-deep-indentation
" License:              MIT
" ----------------------------------------------------------------------------
scriptencoding utf-8

function! g:DisapproveDeepIndent()
    if !&modifiable
        return
    endif

    silent! syn clear LookOfDisapproval

    " Backward compatible fix for a typo in the API.
    if !exists('g:LookOfDisapprovalSpaceThreshold') && exists('g:LookOfDisapprovalSpaceTreshold')
        let g:LookOfDisapprovalSpaceThreshold=g:LookOfDisapprovalSpaceTreshold
    endif
    if !exists('g:LookOfDisapprovalTabThreshold') && exists('g:LookOfDisapprovalTabTreshold')
        let g:LookOfDisapprovalTabThreshold=g:LookOfDisapprovalTabTreshold
    endif

    " Setting the defaults.
    if !exists('g:LookOfDisapprovalSpaceThreshold') || (g:LookOfDisapprovalSpaceThreshold > 0 && g:LookOfDisapprovalSpaceThreshold < 5)
        let l:SpaceThreshold=(&tabstop*5)
    else
        let l:SpaceThreshold=g:LookOfDisapprovalSpaceThreshold
    endif
    if !exists('g:LookOfDisapprovalTabThreshold') || (g:LookOfDisapprovalTabThreshold > 0 && g:LookOfDisapprovalTabThreshold < 5)
        let l:TabThreshold=5
    else
        let l:TabThreshold=g:LookOfDisapprovalTabThreshold
    endif

    " If the plugin is not disabled, then place the look of disapproval for deeply indented lines.
    if l:TabThreshold <= 0 && l:SpaceThreshold <= 0
        return
    endif

    syn match LookOfDisapprovalLeftEye contained '\%1c\s' conceal cchar=ಠ
    syn match LookOfDisapprovalMouth contained '\%2c\s' conceal cchar=_
    syn match LookOfDisapprovalRightEye contained '\%3c\s' conceal cchar=ಠ
    syn match LookOfDisapprovalPadding contained '\%4c\s' conceal cchar= 

    if l:SpaceThreshold > 0
        execute 'syn match LookOfDisapproval /^\zs\s\s\s\s\ze\s\{'.(l:SpaceThreshold-4).'\}/ contains=LookOfDisapprovalLeftEye,LookOfDisapprovalMouth,LookOfDisapprovalRightEye,LookOfDisapprovalPadding'
    endif

    if l:TabThreshold > 0
        execute 'syn match LookOfDisapproval /^\zs\t\t\t\t\ze\t\{'.(l:TabThreshold-4).'\}/ contains=LookOfDisapprovalLeftEye,LookOfDisapprovalMouth,LookOfDisapprovalRightEye,LookOfDisapprovalPadding'
    endif

    set conceallevel=1 concealcursor=nvic
    hi conceal ctermfg=red ctermbg=NONE guifg=red guibg=NONE


    "
    " There can be problems if the existing syntax rules use
    " contains=ALL or contains=ALLBUT.
    " The ಠ_ಠ shouldn't be applied, except for deeply indented lines,
    " but these rules sabotage this goal because they make the
    " plugins contained rules match.
    "
    " Because it affects many common syntax highlight setups
    " I decided to put a quick and dirty fix here,
    " where we check the current syntax and the presence of a known
    " rule that breaks the plugin.
    "
    " More info:
    " https://github.com/dodie/vim-disapprove-deep-indentation/issues/2
    "

    " fix for the default SQL syntax
    if hlexists('sqlFold') && &syntax ==# 'sql'
        syn region sqlFold start='^\s*\zs\c\(Create\|Update\|Alter\|Select\|Insert\)' end=';$\|^$' transparent fold contains=ALLBUT,LookOfDisapprovalLeftEye,LookOfDisapprovalRightEye,LookOfDisapprovalMouth,LookOfDisapprovalPadding
    endif

    " fix for the default Ruby syntax
    if hlexists('rubyLocalVariableOrMethod') && &syntax ==# 'ruby'
        syn cluster rubyNotTop add=LookOfDisapprovalLeftEye,LookOfDisapprovalRightEye,LookOfDisapprovalMouth,LookOfDisapprovalPadding
    endif

    " fix for the default Python syntax
    if hlexists('pythonDoctest') && &syntax ==# 'python'
        syn region pythonDoctest
          \ start="^\s*>>>\s" end="^\s*$"
          \ contained contains=ALLBUT,pythonDoctest,@Spell,LookOfDisapprovalLeftEye,LookOfDisapprovalRightEye,LookOfDisapprovalMouth,LookOfDisapprovalPadding
    endif

    " fix for the default CMake syntax
    if hlexists('cmakeArguments') && &syntax ==# 'cmake'
        syn region cmakeArguments start="(" end=")" contains=ALLBUT,cmakeCommand,cmakeCommandConditional,cmakeCommandRepeat,cmakeCommandDeprecated,cmakeArguments,cmakeTodo,LookOfDisapprovalLeftEye,LookOfDisapprovalRightEye,LookOfDisapprovalMouth,LookOfDisapprovalPadding
    endif
endfunction

autocmd BufEnter,BufNewFile,BufReadPost * call g:DisapproveDeepIndent()
