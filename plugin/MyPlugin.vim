" 自定义函数{{{1

" 防止重新载入脚本{{{2
"------------------------------------------------------------------------------"
if exists('g:loaded_myplugin')
    finish
endif
let g:loaded_myplugin = 1
"------------------------------------------------------------------------------"
"}}}

" 更换主题{{{2
"------------------------------------------------------------------------------"
function! ToggleColorScheme(...)
    if a:0 == 0
        "取得所有配色
        "if g:platform == 'win'
            "let dir = $VIM . '/vimfiles/colors/'
        "else
            "let dir = expand('~/.vim/colors/')
        "endif
        "let colors = GetAllFilesInDir(dir, 'vim')
        "去掉路径及扩展名
        "for i in range(len(colors))
            "let colors[i] = fnamemodify(colors[i], ':t:r')
        "endfor
        let g:colors = []
        for fname in split(globpath(&runtimepath, 'colors/*.vim'), '\n')
            call add(g:colors, fnamemodify(fname, ':t:r'))
        endfor
        "从g:colors_name得到当前配色的索引
        let i = index(g:colors, g:colors_name)
        "取下一个配色方案
        let i = (i+1) % len(g:colors)
        "加载配色方案
        exe 'colorscheme ' . get(g:colors, i)
    elseif a:0 == 1
        let color = a:1
        "加载配色方案
        exe 'colorscheme ' . color
        " 重新高亮状态栏
        "call SetMyStatusLine()
    endif

    "Notice:如果要看当前配色，echo g:colors_name

endfunction
command! -nargs=0 ToggleColorScheme :call ToggleColorScheme() | silent! echo g:colors_name

fun! AutoChangeColorScheme()
    if &filetype == 'txt'
        call ToggleColorScheme('colorful')
    else
        call ToggleColorScheme('bluechia')
    endif
endfun
"------------------------------------------------------------------------------"
"}}}

" 更换行号/相对行号 {{{2
"------------------------------------------------------------------------------"
function! ToggleNuMode()
    if version >= 703
        if(&rnu == 1)
            let &rnu = 0
        else
            set rnu
        endif
    end
endfunction
command! -nargs=0 ToggleNuMode :call ToggleNuMode()
"------------------------------------------------------------------------------"
"}}}

" 把当前文件另存到桌面 {{{2
"------------------------------------------------------------------------------"
function! SaveCurrentFileToDesktop()
    "let filename = fnamemodify(getcwd(), "%:t")
    let filename = expand("%")
    if g:platform == 'win'
        let save_name = $HOME . '\Desktop\' . filename
        if exists('g:computer_enviroment')
            if g:computer_enviroment == "grundfos"
                let save_name = 'c:/users/55602/Desktop/' . filename
            endif
        endif
    elseif g:platform == 'mac'
        let save_name = $HOME . '/Desktop/' . filename
    else
        let save_name = $HOME . '/桌面/' . filename
    endif
    if filereadable(save_name)
        let l:inputkey = input("File Exist! Overwrite? (Y/N) ")
        if l:inputkey == 'y' || l:inputkey == 'Y' || l:inputkey ==# ""
            exe ":w! ". save_name
        endif
    else
        exe ":w ". save_name
    endif
endfunction
command! -nargs=0 SaveCurrentFileToDesktop :call SaveCurrentFileToDesktop()
"------------------------------------------------------------------------------"
"}}}

" 重命名 {{{2
"------------------------------------------------------------------------------"
fun! Rename(name, bang)
    let l:name    = a:name
	let l:oldfile = expand('%:p')

	if bufexists(fnamemodify(l:name, ':p'))
		if (a:bang ==# '!')
			silent exe bufnr(fnamemodify(l:name, ':p')) . 'bwipe!'
		else
			echohl ErrorMsg
			echomsg 'A buffer with that name already exists (use ! to override).'
			echohl None
			return 0
		endif
	endif

	let l:status = 1

	let v:errmsg = ''
	silent! exe 'saveas' . a:bang . ' ' . l:name

	if v:errmsg =~# '^$\|^E329'
		let l:lastbufnr = bufnr('$')

		if expand('%:p') !=# l:oldfile && filewritable(expand('%:p'))
			if fnamemodify(bufname(l:lastbufnr), ':p') ==# l:oldfile
				silent exe l:lastbufnr . 'bwipe!'
			else
				echohl ErrorMsg
				echomsg 'Could not wipe out the old buffer for some reason.'
				echohl None
				let l:status = 0
			endif

			if delete(l:oldfile) != 0
				echohl ErrorMsg
				echomsg 'Could not delete the old file: ' . l:oldfile
				echohl None
				let l:status = 0
			endif
		else
			echohl ErrorMsg
			echomsg 'Rename failed for some reason.'
			echohl None
			let l:status = 0
		endif
	else
		echoerr v:errmsg
		let l:status = 0
	endif

	return l:status
endfun
command! -nargs=* -complete=file -bang Rename call Rename(<q-args>, '<bang>')
"------------------------------------------------------------------------------"
"}}}

" 插入日期时间 {{{2
"------------------------------------------------------------------------------"
fun! InsertDateTime()
    silent! execute "normal a".strftime("%c")."\<ESC>"
endfun
"------------------------------------------------------------------------------"
"}}}

" 显示rgb.txt里所有颜色 {{{2
"------------------------------------------------------------------------------"
fun! DisplayAllColors()
   let bname = '_All_Colors_'
   " If the window is already open, jump to it
   let winnum = bufwinnr(bname)
   if winnum != -1
      if winnr() != winnum
         " If not already in the window, jump to it
         exe winnum . 'wincmd w'
      endif
      setlocal modifiable
      " Delete the contents of the buffer to the black-hole register
      silent! %delete _
   else
      let bufnum = bufnr(bname)
      if bufnum == -1
         let wcmd = bname
      else
         let wcmd = '+buffer' . bufnum
      endif
      exe 'silent! topleft ' . '15' . 'split ' . wcmd
   endif
   " Mark the buffer as scratch
   setlocal buftype=nofile
   "setlocal bufhidden=delete
   setlocal noswapfile
   setlocal nowrap
   setlocal nobuflisted
   setlocal winfixheight
   setlocal modifiable

   " Setup the cpoptions properly for the maps to work
   let old_cpoptions = &cpoptions
   set cpoptions&vim
   " Create a mapping
   " Restore the previous cpoptions settings
   let &cpoptions = old_cpoptions
   " Display the result
   silent! %delete _

   let fname = $VIMRUNTIME . g:slash . 'rgb.txt'
   let rgb_pattern = '^\s*\zs\(\d\+\s*\)\{3}\ze\w*$'
   let color_pattern = '^\s*\(\d\+\s*\)\{3}\zs\w*$'
   let result = []
   for line in readfile(fname)
       " 匹配到的颜色rgb数值
       let match_rgb = matchstr(line, rgb_pattern)
       " 匹配到的颜色字符串
       let match_color_str = matchstr(line, color_pattern)
       " 去掉所有包含grey的行
       let grey_str = matchstr(line, '^\s*\(\d\+\s*\)\{3}\zs.*grey.*$')
       if len(grey_str) > 1
           continue
       endif
       if match_rgb
           let _match_color_str_ = '_' . match_color_str . '_'
           if &background == 'light'
               exec 'hi col_'.match_color_str.' guifg='.match_color_str
               exec 'hi col_'._match_color_str_.' guibg='.match_color_str.' guifg=black'
           else
               exec 'hi col_'.match_color_str.' guifg='.match_color_str
               exec 'hi col_'._match_color_str_.' guibg='.match_color_str.' guifg=black'
           endif
           exec 'syn keyword col_'.match_color_str.' '.match_color_str
           exec 'syn keyword col_'._match_color_str_.' '._match_color_str_
           let rgb_words = split(match_rgb, '\s\+')
           let r = rgb_words[0]
           let g = rgb_words[1]
           let b = rgb_words[2]
           let r_hex = printf("%02X", r)
           let g_hex = printf("%02X", g)
           let b_hex = printf("%02X", b)
           let rgb_hex = '#'.r_hex.g_hex.b_hex
           " 输出得更整齐一点
           let str1 = match_rgb . rgb_hex . '    ' . match_color_str
           let len1 = len(str1)
           let str2 = _match_color_str_
           let len2 = len(str2)
           let space_len = 70 - len1 - len2
           let i = 1
           let space = " "
           while i < space_len
               let space = space . " "
               let i = i + 1
           endw
           let output = str1 . space . str2
           call add(result, output)
       endif
   endfor
   silent! 0put =result

   " Delete the last blank line
   silent! $delete _
   " Move the cursor to the beginning of the file
   normal! gg
   setlocal nomodifiable
endfun
command! -nargs=* DisplayAllColors call DisplayAllColors()
"------------------------------------------------------------------------------"
"}}}

" 自动修改Modified后面的时间 {{{2
"------------------------------------------------------------------------------"
function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([20, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,50}Modified: \).*#\1' .
                    \ strftime('%c') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun
"------------------------------------------------------------------------------"
"}}}

" {{{2 进制转换
"------------------------------------------------------------------------------"
function! ConvertDigital()
    let word = expand("<cword>")
python << EOF
import vim, os, string

def isDec(s):
   if s.isdigit():
      return True
   else:
      return False

def isHex(s):
    if not s.startswith('0x'):
       return False
    s = s.lstrip('0x')
    hex_digits = set("0123456789abcdefABCDEF")
    for char in s:
        if not (char in hex_digits):
            return False
    return True

def hex2dec(string_num):
    """十六进制转十进制"""
    return str(int(string_num.upper(), 16))

def hex2bin(string_num):
    """十六进制转二进制"""
    b = bin(int(hex2dec(string_num.upper())))
    b = b.lstrip('0b')
    if len(b) <= 16:
        b = b.zfill(16)
        b = b[0:4] + ' ' + b[4:8] + ' ' + b[8:12] + ' ' + b[12:16]
    else:
        b = b.zfill(32)
        b = b[0:4] + ' ' + b[4:8] + ' ' + b[8:12] + ' ' + b[12:16] + ' ' + b[16:20] + ' ' + b[20:24] + ' ' + b[24:28] + ' ' + b[28:32]
    return b

def dec2hex(string_num):
    """十进制转十六进制"""
    h = hex(int(string_num))
    h = h.lstrip('0x')
    h = h.upper()
    if len(h) <= 4:
       h = h.zfill(4)
    else:
       h = h.zfill(8)
    return '0x' + h

def dec2bin(string_num):
    """十进制转二进制"""
    b = bin(int(string_num))
    b = b.lstrip('0b')
    if len(b) <= 16:
        b = b.zfill(16)
        b = b[0:4] + ' ' + b[4:8] + ' ' + b[8:12] + ' ' + b[12:16]
    else:
        b = b.zfill(32)
        b = b[0:4] + ' ' + b[4:8] + ' ' + b[8:12] + ' ' + b[12:16] + ' ' + b[16:20] + ' ' + b[20:24] + ' ' + b[24:28] + ' ' + b[28:32]
    return b

word = vim.eval("word")
if isDec(word):
    str1 = "十六进制: " + dec2hex(word)
    str2 = "二进制: " + dec2bin(word)
    output_str = str1 + "     " + str2
elif isHex(word):
    str1 = "十进制: " + hex2dec(word)
    str2 = "二进制: " + hex2bin(word)
    output_str = str1 + "     " + str2
else:
    output_str = "非数字!"
print output_str
EOF
endfunction
command! -nargs=* ConvertDigital call ConvertDigital()
"------------------------------------------------------------------------------"
"}}}

" {{{2 有道翻译
"------------------------------------------------------------------------------"
function! Translate(word)
    if a:word == ''
        let word = expand("<cword>")
    else
        let word = a:word
    endif
python << EOF
# -*- coding: utf-8 -*-
import vim,requests,collections,xml.etree.ElementTree as ET
WARN_NOT_FIND = " 找不到该单词的释义"
ERROR_QUERY = " 有道翻译查询出错!"
def get_word_info(word):
    if not word:
        return ''
    r = requests.get("http://dict.youdao.com" + "/fsearch?q=" + word)
    if r.status_code == 200:
        doc = ET.fromstring(r.content)
        info = collections.defaultdict(list)
        if not len(doc.findall(".//content")):
            return WARN_NOT_FIND.decode('utf-8')
        for el in doc.findall(".//"):
            if el.tag in ('return-phrase','phonetic-symbol'):
                if el.text:
                    info[el.tag].append(el.text.encode("utf-8"))
            elif el.tag in ('content','value'):
                info[el.tag].append(el.text.encode("utf-8"))
        for k,v in info.items():
            info[k] = ' | '.join(v) if k == "content" else ' '.join(v)
        tpl = ' %(return-phrase)s'
        if info["phonetic-symbol"]:
            tpl = tpl + ' [%(phonetic-symbol)s]'
        tpl = tpl +' %(content)s' 
        return tpl % info
    else:
        return  ERROR_QUERY.decode('utf-8')

word = vim.eval('word').decode('utf-8')
info = get_word_info(word)
vim.command('echo "'+ info +'"')
EOF
endfunction
"command! -nargs=* YD call Translate(expand("<cword>"))
command! -nargs=* YD call Translate(<q-args>)
"------------------------------------------------------------------------------"
"}}}

" {{{2 块移动，自动调整缩进
"------------------------------------------------------------------------------"
function! s:ResetCursor()
    normal! gv
    normal! =
    normal! gv
    normal! ^
endfunction

function! s:MoveBlockDown() range
    let next_line = a:lastline + 1
    if v:count > 0
        let next_line = next_line + v:count - 1
    endif

    if next_line > line('$')
        call s:ResetCursor()
        return
    endif
    execute a:firstline "," a:lastline "m " next_line
    call s:ResetCursor()
endfunction

function! s:MoveBlockUp() range
    let prev_line = a:firstline - 2
    if v:count > 0
        let prev_line = prev_line - v:count + 1
    endif
    if prev_line < 0
        call s:ResetCursor()
        return
    endif
    execute a:firstline "," a:lastline "m " prev_line
    call s:ResetCursor()
endfunction

function! s:MoveLineUp() range
    let distance = 2
    if v:count > 0
        let distance = distance + v:count - 1
    endif
    if (line('.') - distance) < 0
        execute 'm 0'
        normal! ==
        return
    endif
    execute 'm-' . distance
    normal! ==
endfunction

function! s:MoveLineDown() range
    let distance = 1
    if v:count > 0
        let distance = distance + v:count - 1
    endif
    echom distance
    if (line('.') + distance) > line('$')
        execute 'm $'
        normal! ==
        return
    endif
    execute 'm+' . distance
    normal! ==
endfunction

vnoremap <silent> <Plug>MoveBlockDown :call <SID>MoveBlockDown()<CR>
vnoremap <silent> <Plug>MoveBlockUp   :call <SID>MoveBlockUp()<CR>
nnoremap <silent> <Plug>MoveLineDown  :call <SID>MoveLineDown()<CR>
nnoremap <silent> <Plug>MoveLineUp    :call <SID>MoveLineUp()<CR>

vmap <C-Down> <Plug>MoveBlockDown
vmap <C-Up> <Plug>MoveBlockUp
nmap <C-Down> <Plug>MoveLineDown
nmap <C-Up> <Plug>MoveLineUp
"}}}

" vim:fdm=marker:fmr={{{,}}} foldlevel=1:
"}}}
