" -----------------------------------------------------------------------------
" File: ruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/ruvbox
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='ruvbox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:ruvbox_bold')
  let g:ruvbox_bold=1
endif
if !exists('g:ruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:ruvbox_italic=1
  else
    let g:ruvbox_italic=0
  endif
endif
if !exists('g:ruvbox_undercurl')
  let g:ruvbox_undercurl=1
endif
if !exists('g:ruvbox_underline')
  let g:ruvbox_underline=1
endif
if !exists('g:ruvbox_inverse')
  let g:ruvbox_inverse=1
endif

if !exists('g:ruvbox_guisp_fallback') || index(['fg', 'bg'], g:ruvbox_guisp_fallback) == -1
  let g:ruvbox_guisp_fallback='NONE'
endif

if !exists('g:ruvbox_improved_strings')
  let g:ruvbox_improved_strings=0
endif

if !exists('g:ruvbox_improved_warnings')
  let g:ruvbox_improved_warnings=0
endif

if !exists('g:ruvbox_termcolors')
  let g:ruvbox_termcolors=256
endif

if !exists('g:ruvbox_invert_indent_guides')
  let g:ruvbox_invert_indent_guides=0
endif

if exists('g:ruvbox_contrast')
  echo 'g:ruvbox_contrast is deprecated; use g:ruvbox_contrast_light and g:ruvbox_contrast_dark instead'
endif

if !exists('g:ruvbox_contrast_dark')
  let g:ruvbox_contrast_dark='medium'
endif

if !exists('g:ruvbox_contrast_light')
  let g:ruvbox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#292a30', 0]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.dark1       = ['#3c3836', 235]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 7]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:gb.bright_pink  = ['#d3869b', 175]     " 211-134-155
let s:gb.bright_purple  = ['#a834eb', 177]     " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 116]     " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 209]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_pink = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_purple  = ['#a834eb', 177]     " 211-134-155
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_pink   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_purple  = ['#a834eb', 177]     " 211-134-155
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:ruvbox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:ruvbox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:ruvbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:ruvbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:ruvbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:ruvbox_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:ruvbox_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:pink = s:gb.bright_pink
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:ruvbox_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:ruvbox_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:pink = s:gb.faded_pink
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:ruvbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:pink[1] = 13
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.pink = s:pink
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_pink[0]
  let g:terminal_color_13 = s:pink[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:ruvbox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:ruvbox_hls_cursor)
endif

let s:number_column = s:none
if exists('g:ruvbox_number_column')
  let s:number_column = get(s:gb, g:ruvbox_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:ruvbox_sign_column')
    let s:sign_column = get(s:gb, g:ruvbox_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:ruvbox_color_column')
  let s:color_column = get(s:gb, g:ruvbox_color_column)
endif

let s:vert_split = s:bg0
if exists('g:ruvbox_vert_split')
  let s:vert_split = get(s:gb, g:ruvbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:ruvbox_invert_signs')
  if g:ruvbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:ruvbox_invert_selection')
  if g:ruvbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:ruvbox_invert_tabline')
  if g:ruvbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:ruvbox_italicize_comments')
  if g:ruvbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:ruvbox_italicize_strings')
  if g:ruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:ruvbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:ruvbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Ruvbox Hi Groups: {{{

" memoize common hi groups
call s:HL('RuvboxFg0', s:fg0)
call s:HL('RuvboxFg1', s:fg1)
call s:HL('RuvboxFg2', s:fg2)
call s:HL('RuvboxFg3', s:fg3)
call s:HL('RuvboxFg4', s:fg4)
call s:HL('RuvboxGray', s:gray)
call s:HL('RuvboxBg0', s:bg0)
call s:HL('RuvboxBg1', s:bg1)
call s:HL('RuvboxBg2', s:bg2)
call s:HL('RuvboxBg3', s:bg3)
call s:HL('RuvboxBg4', s:bg4)

call s:HL('RuvboxRed', s:red)
call s:HL('RuvboxRedBold', s:red, s:none, s:bold)
call s:HL('RuvboxGreen', s:green)
call s:HL('RuvboxGreenBold', s:green, s:none, s:bold)
call s:HL('RuvboxYellow', s:yellow)
call s:HL('RuvboxYellowBold', s:yellow, s:none, s:bold)
call s:HL('RuvboxBlue', s:blue)
call s:HL('RuvboxBlueBold', s:blue, s:none, s:bold)
call s:HL('RuvboxPink', s:pink)
call s:HL('RuvboxPinkBold', s:pink, s:none, s:bold)
call s:HL('RuvboxPurple', s:purple)
call s:HL('RuvboxPurpleBold', s:purple, s:none, s:bold)
call s:HL('RuvboxAqua', s:aqua)
call s:HL('RuvboxAquaBold', s:aqua, s:none, s:bold)
call s:HL('RuvboxOrange', s:orange)
call s:HL('RuvboxOrangeBold', s:orange, s:none, s:bold)

call s:HL('RuvboxRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('RuvboxGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('RuvboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('RuvboxBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('RuvboxPinkSign', s:pink, s:sign_column, s:invert_signs)
call s:HL('RuvboxPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('RuvboxAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('RuvboxOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/ruvbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText RuvboxBg2
hi! link SpecialKey RuvboxBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory RuvboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title RuvboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg RuvboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg RuvboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question RuvboxOrangeBold
" Warning messages
hi! link WarningMsg RuvboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:ruvbox_improved_strings == 0
  hi! link Special RuvboxOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement RuvboxPinkBold
" if, then, else, endif, swicth, etc.
hi! link Conditional RuvboxPinkBold
" for, do, while, etc.
hi! link Repeat RuvboxPinkBold
" case, default, etc.
hi! link Label RuvboxPinkBold
" try, catch, throw
hi! link Exception RuvboxPinkBold
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword RuvboxPinkBold

" Variable name
hi! link Identifier RuvboxBlue
" Function name
hi! link Function RuvboxGreenBold

" Generic preprocessor
hi! link PreProc RuvboxAqua
" Preprocessor #include
hi! link Include RuvboxAqua
" Preprocessor #define
hi! link Define RuvboxAqua
" Same as Define
hi! link Macro RuvboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit RuvboxAqua

" Generic constant
hi! link Constant RuvboxPink
" Character constant: 'c', '/n'
hi! link Character RuvboxPink
" String constant: "this is a string"
if g:ruvbox_improved_strings == 0
  call s:HL('String',  s:orange, s:none, s:italicize_strings)
else
  call s:HL('String',  s:orange, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean RuvboxPink
" Number constant: 234, 0xff
hi! link Number RuvboxPink
" Floating point constant: 2.3e10
hi! link Float RuvboxPink

" Generic type
hi! link Type RuvboxYellow
" static, register, volatile, etc
hi! link StorageClass RuvboxOrange
" struct, union, enum, etc.
hi! link Structure RuvboxAqua
" typedef
hi! link Typedef RuvboxYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:ruvbox_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:pink)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:ruvbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd RuvboxGreenSign
hi! link GitGutterChange RuvboxAquaSign
hi! link GitGutterDelete RuvboxRedSign
hi! link GitGutterChangeDelete RuvboxAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile RuvboxGreen
hi! link gitcommitDiscardedFile RuvboxRed

" }}}
" Signify: {{{

hi! link SignifySignAdd RuvboxGreenSign
hi! link SignifySignChange RuvboxAquaSign
hi! link SignifySignDelete RuvboxRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign RuvboxRedSign
hi! link SyntasticWarningSign RuvboxYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   RuvboxBlueSign
hi! link SignatureMarkerText RuvboxPinkSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl RuvboxBlueSign
hi! link ShowMarksHLu RuvboxBlueSign
hi! link ShowMarksHLo RuvboxBlueSign
hi! link ShowMarksHLm RuvboxBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch RuvboxYellow
hi! link CtrlPNoEntries RuvboxRed
hi! link CtrlPPrtBase RuvboxBg2
hi! link CtrlPPrtCursor RuvboxBlue
hi! link CtrlPLinePre RuvboxBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket RuvboxFg3
hi! link StartifyFile RuvboxFg1
hi! link StartifyNumber RuvboxBlue
hi! link StartifyPath RuvboxGray
hi! link StartifySlash RuvboxGray
hi! link StartifySection RuvboxYellow
hi! link StartifySpecial RuvboxBg2
hi! link StartifyHeader RuvboxOrange
hi! link StartifyFooter RuvboxBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:pink[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:pink[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign RuvboxRedSign
hi! link ALEWarningSign RuvboxYellowSign
hi! link ALEInfoSign RuvboxBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail RuvboxAqua
hi! link DirvishArg RuvboxYellow

" }}}
" Netrw: {{{

hi! link netrwDir RuvboxAqua
hi! link netrwClassify RuvboxAqua
hi! link netrwLink RuvboxGray
hi! link netrwSymLink RuvboxFg1
hi! link netrwExe RuvboxYellow
hi! link netrwComment RuvboxGray
hi! link netrwList RuvboxBlue
hi! link netrwHelpCmd RuvboxAqua
hi! link netrwCmdSep RuvboxFg3
hi! link netrwVersion RuvboxGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir RuvboxAqua
hi! link NERDTreeDirSlash RuvboxAqua

hi! link NERDTreeOpenable RuvboxOrange
hi! link NERDTreeClosable RuvboxOrange

hi! link NERDTreeFile RuvboxFg1
hi! link NERDTreeExecFile RuvboxYellow

hi! link NERDTreeUp RuvboxGray
hi! link NERDTreeCWD RuvboxGreen
hi! link NERDTreeHelp RuvboxFg1

hi! link NERDTreeToggleOn RuvboxGreen
hi! link NERDTreeToggleOff RuvboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign RuvboxRedSign
hi! link CocWarningSign RuvboxOrangeSign
hi! link CocInfoSign RuvboxYellowSign
hi! link CocHintSign RuvboxBlueSign
hi! link CocErrorFloat RuvboxRed
hi! link CocWarningFloat RuvboxOrange
hi! link CocInfoFloat RuvboxYellow
hi! link CocHintFloat RuvboxBlue
hi! link CocDiagnosticsError RuvboxRed
hi! link CocDiagnosticsWarning RuvboxOrange
hi! link CocDiagnosticsInfo RuvboxYellow
hi! link CocDiagnosticsHint RuvboxBlue

hi! link CocSelectedText RuvboxRed
hi! link CocCodeLens RuvboxGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded RuvboxGreen
hi! link diffRemoved RuvboxRed
hi! link diffChanged RuvboxAqua

hi! link diffFile RuvboxOrange
hi! link diffNewFile RuvboxYellow

hi! link diffLine RuvboxBlue

" }}}
" Html: {{{

hi! link htmlTag RuvboxBlue
hi! link htmlEndTag RuvboxBlue

hi! link htmlTagName RuvboxAquaBold
hi! link htmlArg RuvboxAqua

hi! link htmlScriptTag RuvboxPink
hi! link htmlTagN RuvboxFg1
hi! link htmlSpecialTagName RuvboxAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar RuvboxOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag RuvboxBlue
hi! link xmlEndTag RuvboxBlue
hi! link xmlTagName RuvboxBlue
hi! link xmlEqual RuvboxBlue
hi! link docbkKeyword RuvboxAquaBold

hi! link xmlDocTypeDecl RuvboxGray
hi! link xmlDocTypeKeyword RuvboxPink
hi! link xmlCdataStart RuvboxGray
hi! link xmlCdataCdata RuvboxPink
hi! link dtdFunction RuvboxGray
hi! link dtdTagName RuvboxPink

hi! link xmlAttrib RuvboxAqua
hi! link xmlProcessingDelim RuvboxGray
hi! link dtdParamEntityPunct RuvboxGray
hi! link dtdParamEntityDPunct RuvboxGray
hi! link xmlAttribPunct RuvboxGray

hi! link xmlEntity RuvboxOrange
hi! link xmlEntityPunct RuvboxOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation RuvboxOrange
hi! link vimBracket RuvboxOrange
hi! link vimMapModKey RuvboxOrange
hi! link vimFuncSID RuvboxFg3
hi! link vimSetSep RuvboxFg3
hi! link vimSep RuvboxFg3
hi! link vimContinue RuvboxFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword RuvboxBlue
hi! link clojureCond RuvboxOrange
hi! link clojureSpecial RuvboxOrange
hi! link clojureDefine RuvboxOrange

hi! link clojureFunc RuvboxYellow
hi! link clojureRepeat RuvboxYellow
hi! link clojureCharacter RuvboxAqua
hi! link clojureStringEscape RuvboxAqua
hi! link clojureException RuvboxRed

hi! link clojureRegexp RuvboxAqua
hi! link clojureRegexpEscape RuvboxAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen RuvboxFg3
hi! link clojureAnonArg RuvboxYellow
hi! link clojureVariable RuvboxBlue
hi! link clojureMacro RuvboxOrange

hi! link clojureMeta RuvboxYellow
hi! link clojureDeref RuvboxYellow
hi! link clojureQuote RuvboxYellow
hi! link clojureUnquote RuvboxYellow

" }}}
" C: {{{

hi! link cOperator RuvboxPink
hi! link cStructure RuvboxOrange

" }}}
" Python: {{{

hi! link pythonBuiltin RuvboxPurple
hi! link pythonBuiltinObj RuvboxOrange
hi! link pythonBuiltinFunc RuvboxOrange
hi! link pythonFunction RuvboxAqua
hi! link pythonDecorator RuvboxRed
hi! link pythonInclude RuvboxPinkBold
hi! link pythonImport RuvboxPinkBold
hi! link pythonRun RuvboxBlue
hi! link pythonCoding RuvboxBlue
hi! link pythonOperator RuvboxRed
hi! link pythonException RuvboxRed
hi! link pythonExceptions RuvboxPink
hi! link pythonBoolean RuvboxPink
hi! link pythonDot RuvboxFg3
hi! link pythonConditional RuvboxRed
hi! link pythonRepeat RuvboxRed
hi! link pythonDottedName RuvboxGreenBold

" }}}
" CSS: {{{

hi! link cssBraces RuvboxBlue
hi! link cssFunctionName RuvboxYellow
hi! link cssIdentifier RuvboxOrange
hi! link cssClassName RuvboxGreen
hi! link cssColor RuvboxBlue
hi! link cssSelectorOp RuvboxBlue
hi! link cssSelectorOp2 RuvboxBlue
hi! link cssImportant RuvboxGreen
hi! link cssVendor RuvboxFg1

hi! link cssTextProp RuvboxAqua
hi! link cssAnimationProp RuvboxAqua
hi! link cssUIProp RuvboxYellow
hi! link cssTransformProp RuvboxAqua
hi! link cssTransitionProp RuvboxAqua
hi! link cssPrintProp RuvboxAqua
hi! link cssPositioningProp RuvboxYellow
hi! link cssBoxProp RuvboxAqua
hi! link cssFontDescriptorProp RuvboxAqua
hi! link cssFlexibleBoxProp RuvboxAqua
hi! link cssBorderOutlineProp RuvboxAqua
hi! link cssBackgroundProp RuvboxAqua
hi! link cssMarginProp RuvboxAqua
hi! link cssListProp RuvboxAqua
hi! link cssTableProp RuvboxAqua
hi! link cssFontProp RuvboxAqua
hi! link cssPaddingProp RuvboxAqua
hi! link cssDimensionProp RuvboxAqua
hi! link cssRenderProp RuvboxAqua
hi! link cssColorProp RuvboxAqua
hi! link cssGeneratedContentProp RuvboxAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces RuvboxFg1
hi! link javaScriptFunction RuvboxAqua
hi! link javaScriptIdentifier RuvboxRed
hi! link javaScriptMember RuvboxBlue
hi! link javaScriptNumber RuvboxPink
hi! link javaScriptNull RuvboxPink
hi! link javaScriptParens RuvboxFg3

" }}}
" YAJS: {{{

hi! link javascriptImport RuvboxAqua
hi! link javascriptExport RuvboxAqua
hi! link javascriptClassKeyword RuvboxAqua
hi! link javascriptClassExtends RuvboxAqua
hi! link javascriptDefault RuvboxAqua

hi! link javascriptClassName RuvboxYellow
hi! link javascriptClassSuperName RuvboxYellow
hi! link javascriptGlobal RuvboxYellow

hi! link javascriptEndColons RuvboxFg1
hi! link javascriptFuncArg RuvboxFg1
hi! link javascriptGlobalMethod RuvboxFg1
hi! link javascriptNodeGlobal RuvboxFg1
hi! link javascriptBOMWindowProp RuvboxFg1
hi! link javascriptArrayMethod RuvboxFg1
hi! link javascriptArrayStaticMethod RuvboxFg1
hi! link javascriptCacheMethod RuvboxFg1
hi! link javascriptDateMethod RuvboxFg1
hi! link javascriptMathStaticMethod RuvboxFg1

" hi! link javascriptProp RuvboxFg1
hi! link javascriptURLUtilsProp RuvboxFg1
hi! link javascriptBOMNavigatorProp RuvboxFg1
hi! link javascriptDOMDocMethod RuvboxFg1
hi! link javascriptDOMDocProp RuvboxFg1
hi! link javascriptBOMLocationMethod RuvboxFg1
hi! link javascriptBOMWindowMethod RuvboxFg1
hi! link javascriptStringMethod RuvboxFg1

hi! link javascriptVariable RuvboxOrange
" hi! link javascriptVariable RuvboxRed
" hi! link javascriptIdentifier RuvboxOrange
" hi! link javascriptClassSuper RuvboxOrange
hi! link javascriptIdentifier RuvboxOrange
hi! link javascriptClassSuper RuvboxOrange

" hi! link javascriptFuncKeyword RuvboxOrange
" hi! link javascriptAsyncFunc RuvboxOrange
hi! link javascriptFuncKeyword RuvboxAqua
hi! link javascriptAsyncFunc RuvboxAqua
hi! link javascriptClassStatic RuvboxOrange

hi! link javascriptOperator RuvboxRed
hi! link javascriptForOperator RuvboxRed
hi! link javascriptYield RuvboxRed
hi! link javascriptExceptions RuvboxRed
hi! link javascriptMessage RuvboxRed

hi! link javascriptTemplateSB RuvboxAqua
hi! link javascriptTemplateSubstitution RuvboxFg1

" hi! link javascriptLabel RuvboxBlue
" hi! link javascriptObjectLabel RuvboxBlue
" hi! link javascriptPropertyName RuvboxBlue
hi! link javascriptLabel RuvboxFg1
hi! link javascriptObjectLabel RuvboxFg1
hi! link javascriptPropertyName RuvboxFg1

hi! link javascriptLogicSymbols RuvboxFg1
hi! link javascriptArrowFunc RuvboxYellow

hi! link javascriptDocParamName RuvboxFg4
hi! link javascriptDocTags RuvboxFg4
hi! link javascriptDocNotation RuvboxFg4
hi! link javascriptDocParamType RuvboxFg4
hi! link javascriptDocNamedParamType RuvboxFg4

hi! link javascriptBrackets RuvboxFg1
hi! link javascriptDOMElemAttrs RuvboxFg1
hi! link javascriptDOMEventMethod RuvboxFg1
hi! link javascriptDOMNodeMethod RuvboxFg1
hi! link javascriptDOMStorageMethod RuvboxFg1
hi! link javascriptHeadersMethod RuvboxFg1

hi! link javascriptAsyncFuncKeyword RuvboxRed
hi! link javascriptAwaitFuncKeyword RuvboxRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword RuvboxAqua
hi! link jsExtendsKeyword RuvboxAqua
hi! link jsExportDefault RuvboxAqua
hi! link jsTemplateBraces RuvboxAqua
hi! link jsGlobalNodeObjects RuvboxFg1
hi! link jsGlobalObjects RuvboxFg1
hi! link jsFunction RuvboxAqua
hi! link jsFuncParens RuvboxFg3
hi! link jsParens RuvboxFg3
hi! link jsNull RuvboxPink
hi! link jsUndefined RuvboxPink
hi! link jsClassDefinition RuvboxYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved RuvboxAqua
hi! link typeScriptLabel RuvboxAqua
hi! link typeScriptFuncKeyword RuvboxAqua
hi! link typeScriptIdentifier RuvboxOrange
hi! link typeScriptBraces RuvboxFg1
hi! link typeScriptEndColons RuvboxFg1
hi! link typeScriptDOMObjects RuvboxFg1
hi! link typeScriptAjaxMethods RuvboxFg1
hi! link typeScriptLogicSymbols RuvboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects RuvboxFg1
hi! link typeScriptParens RuvboxFg3
hi! link typeScriptOpSymbols RuvboxFg3
hi! link typeScriptHtmlElemProperties RuvboxFg1
hi! link typeScriptNull RuvboxPink
hi! link typeScriptInterpolationDelimiter RuvboxAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword RuvboxAqua
hi! link purescriptModuleName RuvboxFg1
hi! link purescriptWhere RuvboxAqua
hi! link purescriptDelimiter RuvboxFg4
hi! link purescriptType RuvboxFg1
hi! link purescriptImportKeyword RuvboxAqua
hi! link purescriptHidingKeyword RuvboxAqua
hi! link purescriptAsKeyword RuvboxAqua
hi! link purescriptStructure RuvboxAqua
hi! link purescriptOperator RuvboxBlue

hi! link purescriptTypeVar RuvboxFg1
hi! link purescriptConstructor RuvboxFg1
hi! link purescriptFunction RuvboxFg1
hi! link purescriptConditional RuvboxOrange
hi! link purescriptBacktick RuvboxOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp RuvboxFg3
hi! link coffeeSpecialOp RuvboxFg3
hi! link coffeeCurly RuvboxOrange
hi! link coffeeParen RuvboxFg3
hi! link coffeeBracket RuvboxOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter RuvboxGreen
hi! link rubyInterpolationDelimiter RuvboxAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier RuvboxRed
hi! link objcDirective RuvboxBlue

" }}}
" Go: {{{

hi! link goDirective RuvboxAqua
hi! link goConstants RuvboxPink
hi! link goDeclaration RuvboxRed
hi! link goDeclType RuvboxBlue
hi! link goBuiltins RuvboxOrange

" }}}
" Lua: {{{

hi! link luaIn RuvboxRed
hi! link luaFunction RuvboxAqua
hi! link luaTable RuvboxOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp RuvboxFg3
hi! link moonExtendedOp RuvboxFg3
hi! link moonFunction RuvboxFg3
hi! link moonObject RuvboxYellow

" }}}
" Java: {{{

hi! link javaAnnotation RuvboxBlue
hi! link javaDocTags RuvboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen RuvboxFg3
hi! link javaParen1 RuvboxFg3
hi! link javaParen2 RuvboxFg3
hi! link javaParen3 RuvboxFg3
hi! link javaParen4 RuvboxFg3
hi! link javaParen5 RuvboxFg3
hi! link javaOperator RuvboxOrange

hi! link javaVarArg RuvboxGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter RuvboxGreen
hi! link elixirInterpolationDelimiter RuvboxAqua

hi! link elixirModuleDeclaration RuvboxYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition RuvboxFg1
hi! link scalaCaseFollowing RuvboxFg1
hi! link scalaCapitalWord RuvboxFg1
hi! link scalaTypeExtension RuvboxFg1

hi! link scalaKeyword RuvboxRed
hi! link scalaKeywordModifier RuvboxRed

hi! link scalaSpecial RuvboxAqua
hi! link scalaOperator RuvboxFg1

hi! link scalaTypeDeclaration RuvboxYellow
hi! link scalaTypeTypePostDeclaration RuvboxYellow

hi! link scalaInstanceDeclaration RuvboxFg1
hi! link scalaInterpolation RuvboxAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 RuvboxGreenBold
hi! link markdownH2 RuvboxGreenBold
hi! link markdownH3 RuvboxYellowBold
hi! link markdownH4 RuvboxYellowBold
hi! link markdownH5 RuvboxYellow
hi! link markdownH6 RuvboxYellow

hi! link markdownCode RuvboxAqua
hi! link markdownCodeBlock RuvboxAqua
hi! link markdownCodeDelimiter RuvboxAqua

hi! link markdownBlockquote RuvboxGray
hi! link markdownListMarker RuvboxGray
hi! link markdownOrderedListMarker RuvboxGray
hi! link markdownRule RuvboxGray
hi! link markdownHeadingRule RuvboxGray

hi! link markdownUrlDelimiter RuvboxFg3
hi! link markdownLinkDelimiter RuvboxFg3
hi! link markdownLinkTextDelimiter RuvboxFg3

hi! link markdownHeadingDelimiter RuvboxOrange
hi! link markdownUrl RuvboxPink
hi! link markdownUrlTitleDelimiter RuvboxGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType RuvboxYellow
" hi! link haskellOperators RuvboxOrange
" hi! link haskellConditional RuvboxAqua
" hi! link haskellLet RuvboxOrange
"
hi! link haskellType RuvboxFg1
hi! link haskellIdentifier RuvboxFg1
hi! link haskellSeparator RuvboxFg1
hi! link haskellDelimiter RuvboxFg4
hi! link haskellOperators RuvboxBlue
"
hi! link haskellBacktick RuvboxOrange
hi! link haskellStatement RuvboxOrange
hi! link haskellConditional RuvboxOrange

hi! link haskellLet RuvboxAqua
hi! link haskellDefault RuvboxAqua
hi! link haskellWhere RuvboxAqua
hi! link haskellBottom RuvboxAqua
hi! link haskellBlockKeywords RuvboxAqua
hi! link haskellImportKeywords RuvboxAqua
hi! link haskellDeclKeyword RuvboxAqua
hi! link haskellDeriving RuvboxAqua
hi! link haskellAssocType RuvboxAqua

hi! link haskellNumber RuvboxPink
hi! link haskellPragma RuvboxPink

hi! link haskellString RuvboxGreen
hi! link haskellChar RuvboxGreen

" }}}
" Json: {{{

hi! link jsonKeyword RuvboxGreen
hi! link jsonQuote RuvboxGreen
hi! link jsonBraces RuvboxFg1
hi! link jsonString RuvboxFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! RuvboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! RuvboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
