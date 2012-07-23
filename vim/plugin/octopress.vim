" Octopress blog engine (http://octopress.org/) stuff for Vim.
" Some commands assume you have Vimux: https://github.com/benmills/vimux/
"
" By Henrik Nyh <http://henrik.nyh.se> under the MIT license.

let s:base_url = "http://octopress.dev"

" :OPonly to generate only the current post.
command! OPonly call VimuxRunCommand("rake generate_only[".expand("%:t:r")."]")
nmap <leader>oo :OPonly<CR>

" :OPgendep to generate everything and deploy.
command! OPgendep call VimuxRunCommand("rake gen_deploy")
nmap <leader>og :OPgendep<CR>

" :OPwatch to regenerate changed CSS.
command! OPwatch call VimuxRunCommand("compass watch")
nmap <leader>ow :OPwatch<CR>

" If you need to ctrl+c from OPwatch.
nmap <leader>oc :VimuxInterruptRunner<CR>

" :OPbrowse to open in a browser.
" Opens the current post if you're editing one, otherwise the root.
" Uses s:base_url, defined above.
command! OPbrowse call <SID>OPbrowse()
nmap <leader>ob :OPbrowse<CR>


function! s:OPbrowse()
  let l:url = s:base_url."/"
  if match(expand("%"), "source/_posts/") == 0
    let l:url .= substitute(expand("%:t:r"), "\\v(\\d{4})-(\\d{2})-\\d{2}-(.+)", "\\1/\\2/\\3/", "")
  endif

  exe "silent! ! open '".l:url."'"
  redraw!
endfunction
