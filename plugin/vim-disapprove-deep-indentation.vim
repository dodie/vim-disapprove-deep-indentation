" Vim plugin file
" Maintainer:           David Csakvari
" URL:                  https://github.com/dodie/vim-disapprove-deep-indentation
" License:              MIT
" ----------------------------------------------------------------------------
function! g:DisapproveDeepIndent()
    if !exists("g:LookOfDisapprovalSpaceTreshold") || (g:LookOfDisapprovalSpaceTreshold > 0 && g:LookOfDisapprovalSpaceTreshold < 4)
        let g:LookOfDisapprovalSpaceTreshold=(&tabstop*4)
    endif

    if !exists("g:LookOfDisapprovalTabTreshold") || (g:LookOfDisapprovalTabTreshold > 0 && g:LookOfDisapprovalTabTreshold < 4)
        let g:LookOfDisapprovalTabTreshold=4
    endif

    syn match LookOfDisapprovalLeftEye contained '\%1c\s' conceal cchar=ಠ
    syn match LookOfDisapprovalMouth contained '\%2c\s' conceal cchar=_
    syn match LookOfDisapprovalRightEye contained '\%3c\s' conceal cchar=ಠ

    if g:LookOfDisapprovalSpaceTreshold > 0
        execute 'syn match LookOfDisapproval /^\s\s\s\s\{'.(g:LookOfDisapprovalSpaceTreshold-3).'\}/ contains=LookOfDisapprovalLeftEye,LookOfDisapprovalMouth,LookOfDisapprovalRightEye'
    endif

    if g:LookOfDisapprovalTabTreshold > 0
        execute 'syn match LookOfDisapproval /^\t\t\t\{'.(g:LookOfDisapprovalTabTreshold-2).'\}/ contains=LookOfDisapprovalLeftEye,LookOfDisapprovalMouth,LookOfDisapprovalRightEye'
    endif

    set conceallevel=1 concealcursor=nvic
    hi conceal ctermfg=red ctermbg=none guifg=red guibg=none
endfunction

autocmd BufNewFile,BufReadPost * call DisapproveDeepIndent()
