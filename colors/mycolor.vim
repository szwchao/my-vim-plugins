" Theme: MyColor
" Author: szwchao <szwchao@gmail.com>
" License: MIT
" Origin: http://github.com/szwchao/
"
hi clear
syntax reset
let g:colors_name = "mycolor"

let s:is_dark=(&background == 'dark')
" Helper Functions: {{{
" Sets the highlighting for the given group
fun s:HL(group, fg, bg, attr)
  let fg = s:is_dark ? a:fg[0] : a:fg[2]
  let bg = s:is_dark ? a:bg[0] : a:bg[2]
  let ctfg = s:is_dark ? a:fg[1] : a:fg[3]
  let ctbg = s:is_dark ? a:bg[1] : a:bg[3]
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" . fg . " ctermfg=" . ctfg
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" . bg . " ctermbg=" . ctbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun
" }}}

" Color Palette: {{{
"                      dark gui, term,  light gui, term
let s:red          = ['#dc322f', '160', '#df0000', '160']
let s:green        = ['#859900', '106', '#008700', '28']
let s:blue         = ['#5fafdf', '74' , '#4271ae', '25']
let s:pink         = ['#ff5faf', '205', '#d7005f', '161']
let s:olive        = ['#76BEB0', '73' , '#718c00', '64']
let s:navy         = ['#4682B4', '67' , '#005f87', '24']
let s:orange       = ['#cb4b16', '166', '#d75f00', '166']
let s:purple       = ['#af87af', '139', '#8959a8', '97']
let s:aqua         = ['#00afaf', '37' , '#3e999f', '73']
let s:wine         = ['#af8787', '138', '#870087', '90']

" Basics:
let s:foreground   = ['#abb2af', '145', '#444444', '238']
let s:background   = ['#002b36', '235', '#F8F8FF', '231']
let s:nontext      = ['#333333', '236', '#dfafff', '183']
let s:window       = ['#3a3a3a', '237', '#e4e4e4', '254']
let s:divider      = ['#5f8787', '66' , '#4271ae', '25' ]
" TODO 已经自定义了comment_fg，comment_bg，但仍然有些地方用到comment，所以先保留原来主题里的comment
let s:comment      = ['#586e75', '242', '#878787', '102']
let s:todo         = ['#d33682', '162', '#ff0000', '196']
let s:error        = ['#dc322f', '160', '#ff0000', '196']
let s:matchparen   = ['#ef008c', '198', '#ef008c', '198']
let s:title        = ['#eb7aa0', '211', '#4271ae', '25']

let s:constant_fg  = ['#859900', '106', '#8B0000', '88']
let s:constant_bg  = ['#002b36', '235', '#fee6ff', '225']
let s:string_fg    = ['#76BEB0', '73' , '#8B0000', '88']
let s:string_bg    = ['#002b36', '235', '#fee6ff', '225']
let s:number_fg    = ['#859900', '106', '#00c226', '34']
let s:number_bg    = ['#002b36', '235', '#dbf8e3', '194']
let s:identifier   = ['#CDB38B', '180', '#005f87', '24']
let s:function     = ['#4682B4', '67' , '#0070ff', '27']
let s:statement_fg = ['#f19dae', '211', '#F06F00', '202']
let s:statement_bg = ['#002b36', '235', '#FCECE0', '255']
let s:condition_fg = ['#f19dae', '211', '#F06F00', '202']
let s:condition_bg = ['#002b36', '235', '#FCECE0', '255']
let s:operator     = ['#FF0080', '198', '#FF0080', '198']
let s:preproc_fg   = ['#b294bb', '139', '#BA8C00', '136']
let s:preproc_bg   = ['#002b36', '235', '#FFF5CF', '230']
let s:macro        = ['#b294bb', '139', '#9A32CD', '128']
let s:type_fg      = ['#cb4b16', '166', '#b91f49', '161']
let s:type_bg      = ['#002b36', '235', '#ffe3e5', '224']
let s:underlined_fg= ['#E6BC4B', '178', '#000000', '16']
let s:underlined_bg= ['#002b36', '235', '#FF6EB4', '205']

" Cursor 光标:
let s:cursorline   = ['#303035', '236', '#e4e4e4', '254']
let s:cursorlinenr = ['#cfddea', '253', '#af0000', '124']
let s:cursorcolumn = ['#303035', '236', '#e4e4e4', '254']
let s:colorcolumn  = ['#0a4d5e', '24',  '#ff0000', '196']
let s:cursorim_fg  = ['#3a553a', '22',  '#f8f8f8', '231']
let s:cursorim_bg  = ['#d2ff00', '190', '#8000ff', '93']

" PMenu 弹出菜单:
let s:pmenu_fg     = ['#000000', '16',  '#444444', '238']
let s:pmenu_bg     = ['#b7ba6b', '143', '#bddfff', '153']
let s:pmenusel_fg  = ['#abb2af', '145', '#444444', '238']
let s:pmenusel_bg  = ['#224b8f', '25',  '#ffa500', '214']

" Comment 注释:
let s:comment_fg   = ['#586e75', '242', '#4682B4', '67']
let s:comment_bg   = ['#002b36', '235', '#F0F6FF', '255']

" Spelling 拼写:
let s:spellbad     = ['#8B3A62', '125', '#ffafdf', '218']
let s:spellcap     = ['#5f005f', '53',  '#ffffaf', '229']
let s:spellrare    = ['#005f00', '22',  '#afff87', '156']
let s:spelllocal   = ['#00005f', '17',  '#dfdfff', '189']

" Tabline:
let s:tabline_bg             = ['#212121', '234', '#ffafdf', '218']
let s:tabline_active_fg      = ['#cfddea', '253', '#444444', '238']
let s:tabline_active_bg      = ['#000000', '16',  '#e4e4e4', '254']
let s:tabline_inactive_fg    = ['#a9ce49', '149', '#F8F8FF', '231']
let s:tabline_inactive_bg    = ['#000000', '16',  '#3e999f', '73']

" Statusline 状态栏:
let s:statusline_active_fg   = ['#cfddea', '253', '#e4e4e4', '254']
let s:statusline_active_bg   = ['#4E4E4E', '239', '#005f87', '24']
let s:statusline_inactive_fg = ['#a9ce49', '149', '#444444', '238']
let s:statusline_inactive_bg = ['#4E4E4E', '239', '#d0d0d0', '252']

" LineNumber 行号:
let s:linenumber_fg = ['#696969', '242', '#6495ED', '69']
let s:linenumber_bg = ['#073642', '236', '#FDF5E6', '255']

" Search 搜索:
let s:search_fg     = ['#282c34', '236', '#444444', '238']
let s:search_bg     = ['#b58900', '136', '#ffe270', '221']
let s:incsearch_fg  = ['#4682B4', '67' , '#000080', '18']
let s:incsearch_bg  = ['#ffffff', '231', '#F8F8FF', '231']

" Visual 可视化区域:
let s:visual_fg     = ['#000000', '16',  '#F8F8FF', '231']
let s:visual_bg     = ['#8787af', '103', '#4271ae', '25']

" 目录名
let s:directory_fg  = ['#4682B4', '67',  '#000080', '18']
let s:directory_bg  = ['#002b36', '235', '#FFE9E3', '224']

" Folded 折叠:
let s:folded_fg     = ['#686f9a', '60' , '#005f87', '24']
let s:folded_bg     = ['#1e2132', '235', '#afdfff', '153']

" WildMenu:                                                
let s:wildmenu_fg   = ['#1e2132', '235', '#444444', '238']
let s:wildmenu_bg   = ['#d2ff00', '190', '#ffff00', '226']

" Diff:                                                    
let s:diffadd_fg    = ['#D2EBBE', '194', '#003300', '22']
let s:diffadd_bg    = ['#437019', '22' , '#b5eeb5', '157']
let s:diffdelete_fg = ['#FFF5EE', '231', '#003300', '22']
let s:diffdelete_bg = ['#70000A', '52' , '#FFDDDD', '224']
let s:difftext_fg   = ['#000000', '16' , '#003300', '22']
let s:difftext_bg   = ['#8FBFDC', '110', '#87B0FF', '111']
let s:diffchange_fg = ['#FFF5EE', '231', '#003300', '22']
let s:diffchange_bg = ['#2B5B77', '24' , '#E6E6FA', '189']

" Misc 其它                                                
let s:ignore        = ['#ef008c', '198', '#ef008c', '198']

" }}}

" Syntax Highlighting: {{{
if has("gui_running") || &t_Co == 88 || &t_Co == 256

  " Vim Highlighting
  call s:HL("Normal", s:foreground, s:background, "")

  " 窗口尾部的 '~' 和 '@'，'showbreak' 的字符和其它在文本里实际不存在的字符 (例如，代替行尾放不下的双宽字符而显示的 '>')。
  call s:HL("NonText", s:nontext, "", "")
  " :map 列出的 Meta 和特殊键，也包括文本里不可显示字符的显示和'listchars'。
  call s:HL("SpecialKey", s:orange, "", "")
  " 搜索
  call s:HL("Search", s:search_fg, s:search_bg, "")
  call s:HL("IncSearch", s:incsearch_fg, s:incsearch_bg, "")
  " 行号
  call s:HL("LineNr", s:linenumber_fg, s:linenumber_bg, "")
  " Tabs
  call s:HL("TabLine", s:tabline_inactive_fg, s:tabline_inactive_bg, "None")
  call s:HL("TabLineFill", "", s:tabline_bg, "None")
  call s:HL("TabLineSel", s:tabline_active_fg, s:tabline_active_bg, "None")

  " 当前窗口的状态行
  call s:HL("StatusLine", s:statusline_active_fg, s:statusline_active_bg, "bold")
  " 非当前窗口的状态行
  call s:HL("StatusLineNC", s:statusline_inactive_fg, s:statusline_inactive_bg, "None")
  " 窗口垂直分割线
  call s:HL("VertSplit", s:divider, s:background, "none")
  " 可视模式的选择区
  call s:HL("Visual", s:visual_fg, s:visual_bg, "")
  " 目录名
  call s:HL("Directory", s:directory_fg, s:directory_bg, "")
  " #3A9CFF, 75
  call s:HL("ModeMsg", s:olive, "", "")
  " #2E8B57, 29
  call s:HL("MoreMsg", s:olive, "", "")
  call s:HL("Question", s:olive, "", "")
  " #EB1513, 196
  call s:HL("ErrorMsg", s:background, s:pink, "")
  call s:HL("WarningMsg", s:background, s:pink, "")
  " 配对的括号
  call s:HL("MatchParen", s:background, s:matchparen, "")
  " 折叠
  call s:HL("Folded", s:folded_fg, s:folded_bg, "")
  " 在左侧有个状态条用'|'指示折叠，需set foldcolumn=x （x>0）时生效
  call s:HL("FoldColumn", "", s:background, "")
  " 'wildmenu' 补全的当前匹配，如command命令在状态栏的补全
  call s:HL("WildMenu", s:wildmenu_fg, s:wildmenu_bg, "bold")
  if version >= 700
    " 光标水平线
    call s:HL("CursorLine", "", s:cursorline, "none")
    call s:HL("CursorLineNr", s:cursorlinenr, "", "none")
    " 光标垂直线
    call s:HL("CursorColumn", "", s:cursorcolumn, "none")
    " 插入模式光标颜色
    call s:HL("CursorIM", s:cursorim_fg, s:cursorim_bg, "none")
    " 弹出菜单
    call s:HL("PMenu", s:pmenu_fg, s:pmenu_bg, "none")
    call s:HL("PMenuSel", s:pmenusel_fg, s:pmenusel_bg, "none")
    " 左侧的标志条
    call s:HL("SignColumn", s:green, s:background, "none")
  end
  if version >= 703
    " 高亮某一列，用于对齐文本。 set colorcolumn=80
    call s:HL("ColorColumn", "", s:colorcolumn, "none")
  end

  " Comment 任何注释
  call s:HL("Comment", s:comment_fg, s:comment_bg, "")
  " Constant 任何常数
  call s:HL("Constant", s:constant_fg, s:constant_bg, "")
  " String 字符串常数
  call s:HL("String", s:string_fg, s:string_bg, "")
  " Character 字符常数: 'c'、'\n'
  call s:HL("Character", s:constant_fg, s:constant_bg, "")
  " Number 数值常数: 234、0xff
  call s:HL("Number", s:number_fg, s:number_bg, "")
  " Boolean 布尔型常数: TRUE、false
  call s:HL("Boolean", s:constant_fg, s:constant_bg, "bold")
  " Float 浮点常数: 2.3e10
  call s:HL("Float", s:number_fg, s:number_bg, "")

  " Identifier 任何变量名
  call s:HL("Identifier", s:identifier, "", "")
  " Function 函数名 (也包括: 类的方法名)
  call s:HL("Function", s:function, "", "bold")
  " Statement 任何语句
  call s:HL("Statement", s:statement_fg, s:statement_bg, "none")
  " Conditional, if、then、else、endif、switch 等
  call s:HL("Conditional", s:condition_fg, s:condition_bg, "none")
  " Repeat, for、do、while 等
  call s:HL("Repeat", s:statement_fg, s:statement_bg, "bold")
  " Label, case、default 等
  call s:HL("Label", s:statement_fg, s:statement_bg, "none")
  " Operator 'sizeof'、'+'、'*' 等，再加上自定义的操作符，如'==', '->'
  call s:HL("Operator", s:operator, "", "none")
  " Keyword 其它关键字
  call s:HL("Keyword", s:blue, "", "")
  " Exception, try、catch、throw
  call s:HL("Exception", s:red, "", "")

  " PreProc 通用预处理命令
  call s:HL("PreProc", s:preproc_fg, s:preproc_bg, "")
  " Include 预处理命令 #include
  call s:HL("Include", s:preproc_fg, s:preproc_bg, "")
  " Define 预处理命令 #define
  call s:HL("Define", s:preproc_fg, s:preproc_bg, "")
  " Macro 同 Define
  call s:HL("Macro", s:macro, "", "")
  "PreCondit 预处理命令 #if、#else、#endif 等
  call s:HL("PreCondit", s:preproc_fg, s:preproc_bg, "")

  " Type, int、long、char 等
  call s:HL("Type", s:type_fg, s:type_bg, "none")
  " StorageClass, static、register、volatile 等
  call s:HL("StorageClass", s:type_fg, s:type_bg, "none")
  " Structure, struct、union、enum 等
  call s:HL("Structure", s:type_fg, s:type_bg, "none")
  " Typedef, typedef 定义
  call s:HL("Typedef", s:type_fg, s:type_bg, "none")

  " Special	任何特殊符号
  call s:HL("Special", s:red, "", "")
  " SpecialChar	常数中的特殊字符
  call s:HL("SpecialChar", s:red, "", "")
  " Tag 可以使用 CTRL-] 的项目
  call s:HL("Tag", s:green, "", "")
  " Delimiter 需要注意的字符
  call s:HL("Delimiter",s:aqua, "", "")
  " SpecialComment 注释里的特殊部分
  call s:HL("SpecialComment", s:red, "", "bold")
  "Debug 调试语句
  call s:HL("Debug", s:orange, "", "")

  " Underlined 需要突出的文本，HTML 链接
  call s:HL("Underlined", s:underlined_fg, s:underlined_bg, "underline")

  " Ignore 留空，被隐藏，如help里的 ** & ||
  call s:HL("Ignore", s:ignore, "", "")

  " Error 有错的构造
  call s:HL("Error", s:foreground, s:error, "")
  " Todo 需要特殊注意的部分；主要是关键字 TODO FIXME 和 XXX
  call s:HL("Todo", s:foreground, s:todo, "bold")

  " :set all、:autocmd 等输出的标题
  call s:HL("Title", s:title, "", "")
  call s:HL("Global", s:blue, "", "")


  " Extension {{{
  " VimL Highlighting
  call s:HL("vimCommand", s:pink, "", "none")
  call s:HL("vimVar", s:navy, "", "")
  call s:HL("vimFuncKey", s:pink, "", "")
  call s:HL("vimFunction", s:blue, "", "bold")
  call s:HL("vimNotFunc", s:pink, "", "")
  call s:HL("vimMap", s:red, "", "")
  call s:HL("vimAutoEvent", s:aqua, "", "bold")
  call s:HL("vimMapModKey", s:aqua, "", "")
  call s:HL("vimFuncName", s:purple, "", "")
  call s:HL("vimIsCommand", s:foreground, "", "")
  call s:HL("vimFuncVar", s:aqua, "", "")
  call s:HL("vimLet", s:orange, "", "")
  call s:HL("vimMapRhsExtend", s:foreground, "", "")
  call s:HL("vimCommentTitle", s:comment, "", "bold")
  call s:HL("vimBracket", s:aqua, "", "")
  call s:HL("vimParenSep", s:aqua, "", "")
  call s:HL("vimSynType", s:olive, "", "bold")
  call s:HL("vimNotation", s:aqua, "", "")
  call s:HL("vimOper", s:foreground, "", "")
  call s:HL("vimOperParen", s:foreground, "", "")
  call s:HL("vimSynType", s:purple, "", "none")
  call s:HL("vimSynReg", s:pink, "", "none")
  call s:HL("vimSynKeyRegion", s:green, "", "")
  call s:HL("vimSynRegOpt", s:blue, "", "")
  call s:HL("vimSynMtchOpt", s:blue, "", "")
  call s:HL("vimSynContains", s:pink, "", "")
  call s:HL("vimGroupName", s:foreground, "", "")
  call s:HL("vimGroupList", s:foreground, "", "")
  call s:HL("vimHiGroup", s:foreground, "", "")
  call s:HL("vimGroup", s:navy, "", "bold")

  " C Highlighting
  "call s:HL("cType", s:pink, "", "bold")
  "call s:HL("cFormat", s:olive, "", "")
  "call s:HL("cStorageClass", s:navy, "", "bold")
  "call s:HL("cBoolean", s:green, "", "")
  "call s:HL("cCharacter", s:olive, "", "")
  "call s:HL("cConstant", s:green, "", "bold")
  "call s:HL("cConditional", s:purple, "", "bold")
  "call s:HL("cSpecial", s:olive, "", "bold")
  "call s:HL("cDefine", s:blue, "", "")
  "call s:HL("cNumber", s:orange, "", "")
  "call s:HL("cPreCondit", s:aqua, "", "")
  "call s:HL("cRepeat", s:purple, "", "bold")
  "call s:HL("cLabel",s:aqua, "", "")
  "call s:HL("cDelimiter",s:blue, "", "")
  "call s:HL("cOperator",s:aqua, "", "")
  "call s:HL("cFunction", s:foreground, "", "")
  "call s:HL("cCustomParen", s:foreground, "", "")
  "call s:HL("cOctalZero", s:purple, "", "bold")

  " CPP highlighting
  call s:HL("cppBoolean", s:red, "", "")
  call s:HL("cppSTLnamespace", s:purple, "", "")
  call s:HL("cppSTLconstant", s:foreground, "", "")
  call s:HL("cppSTLtype", s:foreground, "", "")
  call s:HL("cppSTLexception", s:pink, "", "")
  call s:HL("cppSTLfunctional", s:foreground, "", "bold")
  call s:HL("cppSTLiterator", s:foreground, "", "bold")
  " call s:HL("cppSTLfunction", s:aqua, "", "bold")
  call s:HL("cppExceptions", s:red, "", "")
  call s:HL("cppStatement", s:green, "", "")
  call s:HL("cppStorageClass", s:navy, "", "bold")
  call s:HL("cppAccess",s:blue, "", "")
  " call s:HL("cppSTL",s:blue, "", "")


  " HTML Highlighting
  call s:HL("htmlTitle", s:green, "", "bold")
  call s:HL("htmlH1", s:green, "", "bold")
  call s:HL("htmlH2", s:aqua, "", "bold")
  call s:HL("htmlH3", s:purple, "", "bold")
  call s:HL("htmlH4", s:orange, "", "bold")
  call s:HL("htmlH5", s:blue, "", "bold")
  call s:HL("htmlH6", s:wine, "", "bold")
  call s:HL("htmlTag", s:comment, "", "")
  call s:HL("htmlTagName", s:wine, "", "")
  call s:HL("htmlArg", s:pink, "", "")
  call s:HL("htmlEndTag", s:comment, "", "")
  call s:HL("htmlString", s:blue, "", "")
  call s:HL("htmlScriptTag", s:comment, "", "")
  call s:HL("htmlBold", s:foreground, "", "bold")
  call s:HL("htmlItalic", s:comment, "", "bold")
  call s:HL("htmlBoldItalic", s:navy, "", "bold")
  " call s:HL("htmlLink", s:blue, "", "bold")
  call s:HL("htmlTagN", s:wine, "", "bold")
  call s:HL("htmlSpecialTagName", s:wine, "", "")
  call s:HL("htmlComment", s:comment, "", "")
  call s:HL("htmlCommentPart", s:comment, "", "")

  " CSS Highlighting
  call s:HL("cssIdentifier", s:pink, "", "")
  call s:HL("cssPositioningProp", s:foreground, "", "")
  call s:HL("cssNoise", s:foreground, "", "")
  call s:HL("cssBoxProp", s:foreground, "", "")
  call s:HL("cssTableAttr", s:purple, "", "")
  call s:HL("cssPositioningAttr", s:navy, "", "")
  call s:HL("cssValueLength", s:orange, "", "")

  call s:HL("cssFunctionName", s:blue, "", "")
  call s:HL("cssUnitDecorators", s:aqua, "", "")
  call s:HL("cssColor", s:blue, "", "bold")
  call s:HL("cssBraces", s:pink, "", "")
  call s:HL("cssBackgroundProp", s:foreground, "", "")
  call s:HL("cssTextProp", s:foreground, "", "")
  call s:HL("cssDimensionProp", s:foreground, "", "")
  call s:HL("cssClassName", s:pink, "", "")

  " Markdown Highlighting
  call s:HL("markdownHeadingRule", s:pink, "", "bold")
  call s:HL("markdownH1", s:pink, "", "bold")
  call s:HL("markdownH2", s:orange, "", "bold")
  call s:HL("markdownBlockquote", s:pink, "", "")
  call s:HL("markdownCodeBlock", s:olive, "", "")
  call s:HL("markdownCode", s:olive, "", "")
  call s:HL("markdownLink", s:blue, "", "bold")
  call s:HL("markdownUrl", s:blue, "", "")
  call s:HL("markdownLinkText", s:pink, "", "")
  call s:HL("markdownLinkTextDelimiter", s:purple, "", "")
  call s:HL("markdownLinkDelimiter", s:purple, "", "")
  call s:HL("markdownCodeDelimiter", s:blue, "", "")

  " reStructuredText Highlighting
  call s:HL("rstSections", s:pink, "", "bold")
  call s:HL("rstDelimiter", s:pink, "", "bold")
  call s:HL("rstExplicitMarkup", s:pink, "", "bold")
  call s:HL("rstDirective", s:blue, "", "")
  call s:HL("rstHyperlinkTarget", s:green, "", "")
  call s:HL("rstExDirective", s:foreground, "", "")
  call s:HL("rstInlineLiteral", s:olive, "", "")
  call s:HL("rstInterpretedTextOrHyperlinkReference", s:blue, "", "")

  " Python Highlighting
  "call s:HL("pythonImport", s:pink, "", "bold")
  "call s:HL("pythonExceptions", s:red, "", "")
  "call s:HL("pythonException", s:purple, "", "bold")
  "call s:HL("pythonInclude", s:red, "", "")
  "call s:HL("pythonStatement", s:pink, "", "")
  "call s:HL("pythonConditional", s:purple, "", "bold")
  "call s:HL("pythonRepeat", s:purple, "", "bold")
  "call s:HL("pythonFunction", s:blue, "", "bold")
  "call s:HL("pythonPreCondit", s:purple, "", "")
  "call s:HL("pythonExClass", s:orange, "", "")
  "call s:HL("pythonOperator", s:purple, "", "bold")
  "call s:HL("pythonBuiltin", s:foreground, "", "")
  "call s:HL("pythonDecorator", s:orange, "", "")

  "call s:HL("pythonString", s:olive, "", "")
  "call s:HL("pythonEscape", s:olive, "", "bold")
  "call s:HL("pythonStrFormatting", s:olive, "", "bold")

  "call s:HL("pythonBoolean", s:green, "", "bold")
  "call s:HL("pythonExClass", s:red, "", "")
  "call s:HL("pythonBytesEscape", s:olive, "", "bold")
  "call s:HL("pythonDottedName", s:purple, "", "")
  "call s:HL("pythonStrFormat", s:foreground, "", "")
  "call s:HL("pythonBuiltinFunc", s:foreground, "", "")
  "call s:HL("pythonBuiltinObj", s:foreground, "", "")


  " JavaScript Highlighting
  call s:HL("javaScriptBraces", s:blue, "", "")
  call s:HL("javaScriptParens", s:blue, "", "")
  call s:HL("javaScriptIdentifier", s:pink, "", "")
  call s:HL("javaScriptFunction", s:blue, "", "bold")
  call s:HL("javaScriptConditional", s:purple, "", "bold")
  call s:HL("javaScriptRepeat", s:purple, "", "bold")
  call s:HL("javaScriptBoolean", s:green, "", "bold")
  call s:HL("javaScriptNumber", s:orange, "", "")
  call s:HL("javaScriptMember", s:navy, "", "")
  call s:HL("javaScriptReserved", s:navy, "", "")
  call s:HL("javascriptNull", s:comment_fg, "", "bold")
  call s:HL("javascriptGlobal", s:foreground, "", "")
  call s:HL("javascriptStatement", s:pink, "", "")
  call s:HL("javaScriptMessage", s:foreground, "", "")
  call s:HL("javaScriptMember", s:foreground, "", "")

  " Json Highlighting
  " @target https://github.com/elzr/vim-json
  call s:HL("jsonKeyword", s:blue, "", "")
  call s:HL("jsonString", s:wine, "", "")
  call s:HL("jsonQuote", s:comment_fg, s:comment_bg, "")
  call s:HL("jsonNoise", s:foreground, "", "")
  call s:HL("jsonKeywordMatch", s:foreground, "", "")
  call s:HL("jsonBraces", s:foreground, "", "")
  call s:HL("jsonNumber", s:orange, "", "")
  call s:HL("jsonNull", s:purple, "", "bold")
  call s:HL("jsonBoolean", s:green, "", "bold")
  call s:HL("jsonCommentError", s:pink, s:background , "")

  " XML Highlighting
  call s:HL("xmlProcessingDelim", s:pink, "", "")
  call s:HL("xmlString", s:olive, "", "")
  call s:HL("xmlEqual", s:orange, "", "")
  call s:HL("xmlAttrib", s:navy, "", "")
  call s:HL("xmlAttribPunct", s:pink, "", "")
  call s:HL("xmlTag", s:blue, "", "")
  call s:HL("xmlTagName", s:blue, "", "")
  call s:HL("xmlEndTag", s:blue, "", "")
  call s:HL("xmlNamespace", s:orange, "", "")

  " }}}

  " Plugin: Netrw
  call s:HL("netrwVersion", s:red, "", "")
  call s:HL("netrwList", s:pink, "", "")
  call s:HL("netrwHidePat", s:olive, "", "")
  call s:HL("netrwQuickHelp", s:blue, "", "")
  call s:HL("netrwHelpCmd", s:blue, "", "")
  call s:HL("netrwDir", s:aqua, "", "bold")
  call s:HL("netrwClassify", s:pink, "", "")
  call s:HL("netrwExe", s:green, "", "")
  call s:HL("netrwSuffixes", s:comment_fg, "", "")
  call s:HL("netrwTreeBar", s:linenumber_fg, s:linenumber_bg, "")

  " Plugin: NERDTree
  call s:HL("NERDTreeUp", s:comment_fg, "", "")
  call s:HL("NERDTreeHelpCommand", s:pink, "", "")
  call s:HL("NERDTreeHelpTitle", s:blue, "", "bold")
  call s:HL("NERDTreeHelpKey", s:pink, "", "")
  call s:HL("NERDTreeHelp", s:foreground, "", "")
  call s:HL("NERDTreeToggleOff", s:red, "", "")
  call s:HL("NERDTreeToggleOn", s:green, "", "")
  call s:HL("NERDTreeDir", s:blue, "", "bold")
  call s:HL("NERDTreeDirSlash", s:pink, "", "")
  call s:HL("NERDTreeFile", s:foreground, "", "")
  call s:HL("NERDTreeExecFile", s:green, "", "")
  call s:HL("NERDTreeOpenable", s:pink, "", "bold")
  call s:HL("NERDTreeClosable", s:pink, "", "")

  " Plugin: Tagbar
  call s:HL("TagbarHelpTitle", s:blue, "", "bold")
  call s:HL("TagbarHelp", s:foreground, "", "")
  call s:HL("TagbarKind", s:pink, "", "")
  call s:HL("TagbarSignature", s:aqua, "", "")

  " Plugin: Vimdiff
  call s:HL("DiffAdd",    s:diffadd_fg,    s:diffadd_bg,    "none")
  call s:HL("DiffChange", s:diffchange_fg, s:diffchange_bg, "none")
  call s:HL("DiffDelete", s:diffdelete_fg, s:diffdelete_bg, "none")
  call s:HL("DiffText",   s:difftext_fg,   s:difftext_bg,   "none")

  " Plugin: Spell Checking
  call s:HL("SpellBad",   s:foreground, s:spellbad,   "")
  call s:HL("SpellCap",   s:foreground, s:spellcap,   "")
  call s:HL("SpellRare",  s:foreground, s:spellrare,  "")
  call s:HL("SpellLocal", s:foreground, s:spelllocal, "")

  " Plugin: Startify
  call s:HL("StartifyFile", s:red, "", "")
  call s:HL("StartifyPath", s:foreground, "", "")
  call s:HL("StartifySlash", s:navy, "", "")
  call s:HL("StartifyBracket", s:green, "", "")
  call s:HL("StartifySpecial", s:aqua, "", "")

  " Plugin: Ctrlp
  call s:HL("CtrlPMatch", s:pink, "", "")

  " Plugin: vim-bookmarks
  "Number
  call s:HL("BookmarkSign", s:green, "", "None")
  "Special
  call s:HL("BookmarkAnnotationSign", s:red, "", "None")
  "TabLineFill
  call s:HL("BookmarkLine", "", ["#003336", "23", '#E2FAE2', '194'], "None")
  "TabLine
  call s:HL("BookmarkAnnotationLine", "", ["#391B23", "52", '#FFDDDD', '224'], "None")

  "=====================================================================
  " SYNTAX HIGHLIGHTING CODE BELOW THIS LINE ISN'T TESTED FOR THIS THEME
  "=====================================================================

  " Git
  call s:HL("diffAdded", s:olive, "", "")
  call s:HL("diffRemoved", s:pink, "", "")
  call s:HL("gitcommitSummary", "", "", "bold")

endif
" }}}

" Delete Helper Functions: {{{
delf s:HL
" }}}

" vim: fdm=marker
