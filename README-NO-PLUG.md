```vimrc
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set showmode
set cursorline
set nocompatible
set colorcolumn=0
set backspace=indent,eol,start
set encoding=utf-8
set nu
set updatetime=200
set list " set nolist to disable
set listchars=space:· "space display as .
set splitright
set hlsearch " : noh/nohlsearch to disable

let mapleader=";"
let g:python3_host_prog = '/usr/bin/python3'
highlight search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo "记录光标位置
augroup BasicFileBehavior
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
  autocmd BufNewFile,BufRead *.cu set filetype=cpp
augroup END

" window size ctrl
" left -- right
nnoremap <C-g> 5<C-w><
nnoremap <C-h> 5<C-w>>

" up -- down
nnoremap <C-j> 5<C-w>-
nnoremap <C-k> 5<C-w>+

nnoremap <leader>p :call <SID>FindCurrentPythonSymbols()<CR>
nnoremap <leader>c :call <SID>FindCurrentCodeSymbols()<CR>


" =================== window cut =====================
noremap <Leader>g1 :call win_gotoid(win_getid(1))<CR>
noremap <Leader>g2 :call win_gotoid(win_getid(2))<CR>
noremap <Leader>g3 :call win_gotoid(win_getid(3))<CR>
noremap <Leader>g4 :call win_gotoid(win_getid(4))<CR>
noremap <Leader>g5 :call win_gotoid(win_getid(5))<CR>
noremap <Leader>g6 :call win_gotoid(win_getid(6))<CR>
noremap <Leader>g7 :call win_gotoid(win_getid(7))<CR>
noremap <Leader>g8 :call win_gotoid(win_getid(8))<CR>

" =================== delete file name display =======
function! QfNoFilename(info) abort
  let l:qf = getqflist({'id': a:info.id, 'items': 1, 'context': 1})
  let l:items = l:qf.items
  let l:hide_filename = get(get(l:qf, 'context', {}), 'hide_filename', 0)
  let out = []
  for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
    let item = l:items[idx]
    if l:hide_filename
      call add(out, item.lnum . ': ' . item.text)
    else
      let l:filename = bufname(item.bufnr)
      if empty(l:filename)
        call add(out, item.lnum . ':' . item.col . ': ' . item.text)
      else
        let l:display = fnamemodify(l:filename, ':.')
        call add(out, l:display . '|' . item.lnum . ':' . item.col . '| ' . item.text)
      endif
    endif
  endfor
  return out
endfunction

function! s:FinalizeCurrentFileQuickfix() abort
  let l:items = sort(getqflist(), {a, b -> a.lnum - b.lnum})
  call setqflist([], 'r', {
        \ 'items': l:items,
        \ 'context': {'hide_filename': 1}
        \ })
  vertical copen
  wincmd L
  vertical resize 60
endfunction

function! s:SearchCurrentFilePatterns(patterns) abort
  let l:bufnr = bufnr('%')
  let l:items = []
  let l:lines = getline(1, '$')

  for l:lnum in range(1, len(l:lines))
    let l:text = l:lines[l:lnum - 1]
    for l:pattern in a:patterns
      if l:text =~ l:pattern
        call add(l:items, {
              \ 'bufnr': l:bufnr,
              \ 'lnum': l:lnum,
              \ 'col': 1,
              \ 'text': l:text
              \ })
        break
      endif
    endfor
  endfor

  if empty(l:items)
    echohl WarningMsg
    echom 'No symbol match in current file.'
    echohl None
    return
  endif

  call setqflist([], 'r', {'items': l:items})
  call <SID>FinalizeCurrentFileQuickfix()
endfunction

function! s:FindCurrentPythonSymbols() abort
  call <SID>SearchCurrentFilePatterns([
        \ '^\s*def ',
        \ '^\s*async\s\+def ',
        \ '^\s*class '
        \ ])
endfunction

function! s:FindCurrentCodeSymbols() abort
  call <SID>SearchCurrentFilePatterns([
        \ '^\s*class\s\+[A-Za-z_][A-Za-z0-9_]*',
        \ '^\s*class\s\+[A-Z_][A-Z0-9_]*\s\+[A-Za-z_][A-Za-z0-9_]*',
        \ '^\s*struct\s\+[A-Za-z_][A-Za-z0-9_]*',
        \ '^\s*struct\s\+[A-Z_][A-Z0-9_]*\s\+[A-Za-z_][A-Za-z0-9_]*',
        \ '^\s*[A-Za-z_~][A-Za-z0-9_:<>,*& \t]*\s\+[A-Za-z_~][A-Za-z0-9_:]*\s*(.*)\s*\(const\s*\)\?\(noexcept\s*\)\?{',
        \ '^\s*[A-Za-z_~][A-Za-z0-9_:<>,*& \t]*\s\+[A-Za-z_~][A-Za-z0-9_:]*\s*(.*)\s*\(const\s*\)\?\(noexcept\s*\)\?$',
        \ '^\s*[A-Za-z_~][A-Za-z0-9_:<>,*& \t]*\s\+[A-Za-z_~][A-Za-z0-9_:]*\s*($'
        \ ])
endfunction

set quickfixtextfunc=QfNoFilename

" ================== max window and recover : <leader>m  ========
function! ToggleMaximizeWindow()
    if exists('t:maximized') && t:maximized
        execute t:restorecmd
        let t:maximized = 0
    else
        let t:restorecmd = winrestcmd()
        wincmd _
        wincmd |
        let t:maximized = 1
    endif
endfunction

nnoremap <leader>m :call ToggleMaximizeWindow()<CR>

" ============================================================
" Git fuzzy file finder, no plugin
" ============================================================

" Improve command-line completion experience
set wildmenu
set wildmode=longest:full,full

" Case-insensitive fuzzy search
set ignorecase
set nosmartcase

" Ignore common generated files/directories
set wildignore+=*.o,*.so,*.pyc,*.class
set wildignore+=.git/*,node_modules/*,build/*,dist/*,__pycache__/*

" Limit :find to the current repo root, or the current file directory when
" editing outside a git repository.
function! s:FindBaseDir() abort
  let l:dir = expand('%:p:h')

  if empty(l:dir)
    let l:dir = getcwd()
  endif

  let l:root = systemlist(
        \ 'git -C ' . shellescape(l:dir) .
        \ ' rev-parse --show-toplevel 2>/dev/null'
        \ )

  if v:shell_error || empty(l:root)
    return l:dir
  endif

  return l:root[0]
endfunction

function! s:UpdateFindPath() abort
  let l:base = s:FindBaseDir()
  let &l:path = fnameescape(l:base) . '/**'
endfunction

augroup DynamicFindPath
  autocmd!
  autocmd BufEnter,BufWinEnter * call <SID>UpdateFindPath()
augroup END

function! s:GitRoot() abort
  let l:start = expand('%:p:h')

  if empty(l:start)
    let l:start = getcwd()
  endif

  let l:root = systemlist(
        \ 'git -C ' . shellescape(l:start) .
        \ ' rev-parse --show-toplevel 2>/dev/null'
        \ )

  if v:shell_error || empty(l:root)
    return getcwd()
  endif

  return l:root[0]
endfunction

function! s:GitFiles() abort
  let l:root = s:GitRoot()

  " List tracked and untracked files, excluding ignored files
  let l:cmd = 'git -C ' . shellescape(l:root) .
        \ ' ls-files --cached --others --exclude-standard'

  let l:files = systemlist(l:cmd)

  return [l:root, l:files]
endfunction

function! s:FuzzyMatch(files, query) abort
  let l:q = tolower(a:query)

  if empty(l:q)
    return a:files
  endif

  " Prefer Vim built-in fuzzy matcher if available
  if exists('*matchfuzzy')
    let l:items = []

    for l:i in range(0, len(a:files) - 1)
      call add(l:items, {
            \ 'path': a:files[l:i],
            \ 'lower': tolower(a:files[l:i])
            \ })
    endfor

    let l:matched = matchfuzzy(l:items, l:q, {'key': 'lower'})
    return map(l:matched, 'v:val.path')
  endif

  " Fallback implementation if matchfuzzy() is not available
  " abc => a.*b.*c
  let l:chars = split(l:q, '\zs')
  let l:pat = join(map(l:chars, 'escape(v:val, "\\.^$~[]")'), '.*')

  return filter(copy(a:files), 'tolower(v:val) =~ l:pat')
endfunction

function! s:GitFuzzyFind(query) abort
  let [l:root, l:files] = s:GitFiles()

  if empty(l:files)
    echohl WarningMsg
    echom 'No git files found.'
    echohl None
    return
  endif

  let l:q = a:query

  if empty(l:q)
    let l:q = input('Git file fuzzy> ')
  endif

  let l:matches = s:FuzzyMatch(l:files, l:q)

  if empty(l:matches)
    echohl WarningMsg
    echom 'No match: ' . l:q
    echohl None
    return
  endif

  " Show only the first 200 results to avoid an oversized quickfix list
  let l:items = []

  for l:file in l:matches[:199]
    call add(l:items, {
          \ 'filename': l:root . '/' . l:file,
          \ 'lnum': 1,
          \ 'col': 1,
          \ 'text': l:file
          \ })
  endfor

  call setqflist([], 'r', {
        \ 'items': l:items,
        \ 'context': {'hide_filename': 0}
        \ })
  botright copen
endfunction

command! -nargs=* GitFiles call <SID>GitFuzzyFind(<q-args>)

" Shortcut, similar to LeaderF
nnoremap <silent> <leader>f :GitFiles<CR>

" Optional quickfix shortcuts
augroup GitFuzzyQuickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer> q :cclose<CR>
  autocmd FileType qf nnoremap <buffer> <C-j> j
  autocmd FileType qf nnoremap <buffer> <C-k> k
  autocmd FileType qf nnoremap <buffer> <CR> <CR>
augroup END


" ============================================================
" Git grep by native Vim vimgrep, no plugin
" Reuses s:GitRoot() and s:GitFiles() defined above.
" ============================================================

function! s:GitGrep(query) abort
  let [l:root, l:files] = s:GitFiles()

  if empty(l:files)
    echohl WarningMsg
    echom 'No git files found.'
    echohl None
    return
  endif

  let l:q = a:query

  if empty(l:q)
    let l:q = input('Git grep> ')
  endif

  if empty(l:q)
    return
  endif

  " Literal search + ignore case
  " \V means very nomagic, so the query is treated as plain text
  " \c means case-insensitive
  let l:pattern = '\V\c' . escape(l:q, '\/')

  " Clear quickfix list
  call setqflist([], 'r', {'context': {'hide_filename': 0}})

  let l:save_cwd = getcwd()

  try
    execute 'lcd ' . fnameescape(l:root)

    " Search files in batches to avoid an oversized Vim command line
    let l:batch_size = 80

    for l:i in range(0, len(l:files) - 1, l:batch_size)
      let l:chunk = l:files[l:i : l:i + l:batch_size - 1]
      let l:escaped_files = map(copy(l:chunk), 'fnameescape(v:val)')

      execute 'silent! noautocmd vimgrepadd /' .
            \ l:pattern .
            \ '/gj ' .
            \ join(l:escaped_files, ' ')
    endfor

  finally
    execute 'lcd ' . fnameescape(l:save_cwd)
  endtry

  if empty(getqflist())
    echohl WarningMsg
    echom 'No match: ' . l:q
    echohl None
    return
  endif

  botright copen
endfunction

command! -nargs=* GitGrep call <SID>GitGrep(<q-args>)

" Shortcut, similar to grep search in LeaderF
nnoremap <silent> <leader>g :GitGrep<CR>

" Optional quickfix shortcuts
augroup GitGrepQuickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer> q :cclose<CR>
  autocmd FileType qf nnoremap <buffer> <C-j> :cnext<CR>
  autocmd FileType qf nnoremap <buffer> <C-k> :cprevious<CR>
augroup END
```
