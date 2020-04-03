set nocompatible
filetype off

"{{ 插件安装 vim-plug
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
"PlugInstall
Plug 'scrooloose/nerdtree'                " 目录树
Plug 'jsfaint/gen_tags.vim'               " 自动生成 tags
Plug 'mhinz/vim-grepper'                  " 文件内容搜索
Plug 'yssl/QFEnter'                       " quick-fix 窗口快捷键
Plug 'tpope/vim-fugitive'                 " git 操作
Plug 'ncm2/ncm2'                          " 自动补全
Plug 'roxma/nvim-yarp'                    " for ncm2
Plug 'ncm2/ncm2-bufword'                  " ncm2
Plug 'ncm2/ncm2-path'                     " ncm2
Plug 'Yggdroot/LeaderF'                   " 文件列表和函数列表
Plug 'skywind3000/vim-preview'            " 预览代码

Plug 'git@gitlab.rd.175game.com:qn/qtz-pastec-vim.git'

Plug 'lifepillar/vim-solarized8'          " solarized 主题
Plug 'vim-airline/vim-airline'            " 状态栏
Plug 'vim-airline/vim-airline-themes'     " 状态栏主题
Plug 'edkolev/tmuxline.vim'               " 生成 tmuxline color
Plug 'edkolev/promptline.vim'             " 生成 bash path color
call plug#end()
"}} 插件安装结束

filetype plugin indent on

"{{ 主题
syn enable
set background=dark
"set background=light
syn on                                 "语法支持
"colorscheme solarized8_dark_high       "设置颜色主题
colorscheme one-dark
"}}

"{{ 通用配置
set ai                      "自动缩进
set si
set bs=2                    "在insert模式下用退格键删除
set showmatch               "代码匹配
set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
set shiftwidth=4
set tabstop=4
set softtabstop=4
"set cursorline              "为光标所在行加下划线
"set cursorcolumn            "为光标所在行加下划线
set number                  "显示行号
set autoread                "文件在Vim之外修改过，自动重新读入
set autowriteall            "设置自动保存
"set autochdir
set tags=tags;/
set ignorecase              "检索时忽略大小写
set encoding=utf-8
set fileencoding=utf-8      "使用utf-8新建文件
set fileencodings=utf-8,gbk "使用utf-8或gbk打开文件
let &termencoding=&encoding "
set hls                     "检索时高亮显示匹配项
set helplang=cn             "帮助系统设置为中文
"set foldmethod=syntax      "代码折叠
set nofoldenable            "关闭代码折叠
"set term=screen
set clipboard=unnamed       " use the system clipboard
set nois                    " 设置搜索不自动跳转
set mouse=a                 " 支持鼠标滚动
"}} 通用配置结束

"{{ 快捷键配置
"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
let mapleader = ','
nnoremap <C-l> gt
nnoremap <C-h> gT

"大写字母
inoremap <c-u> <esc>gUiwea
"}} 快捷键配置结束

"{{ 插件配置

"airline{ 状态栏的配置
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#promptline#enabled = 0
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
"}

"nerdtree{ 目录树配置
map <C-T> :NERDTree<CR>
"}

"gen_tags{
" 将自动生成的 tags 文件全部放入 ~/.cache/tags_dir 目录中，避免污染工程目录
let g:gen_tags#use_cache_dir = 1

"disable gtags
let g:loaded_gentags#gtags = 1
"auto ctags
let g:gen_tags#ctags_auto_gen = 1
"disable map
let g:gen_tags#gtags_default_map = 0

"配置 ctags 的参数
let g:gen_tags#ctags_opts = ['--fields=+niazS', '--extra=+q'] 
let g:gen_tags#ctags_opts += ['--c++-kinds=+px']
let g:gen_tags#ctags_opts += ['--c-kinds=+px']

"auto update .tags
let g:gen_tags#ctags_prune = 1
"}


"neocomplcache{ 自动补全
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><space>  pumvisible() ? neocomplcache#close_popup() : "\<SPACE>"
"}

"Align{ 字符对齐
vmap gn :Align=<CR>
"}

"grepper{
function! FindProjectRoot(lookFor)
    let pathMaker='%:p'
    while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
        let pathMaker=pathMaker.':h'
        let fileToCheck=expand(pathMaker).'/'.a:lookFor
        if filereadable(fileToCheck)||isdirectory(fileToCheck)
            return expand(pathMaker)
        endif
    endwhile
    return expand('%:p:h')
endfunction
let g:root_dir = FindProjectRoot('.git')
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
let g:grepper = {}
let g:grepper.ag = {}
let g:grepper.ag.grepprg = 'ag --vimgrep $* '.g:root_dir
"}

"QFEnter{
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']
"}

"promptline{
":PromptlineSnapshot ~/.shell_prompt.sh airline
"let g:promptline_symbols = {
"            \ 'truncation'     : '…'
"            \}
"let g:promptline_preset = {
"            \'a' : [ promptline#slices#user() ],
"            \'c' : [ promptline#slices#cwd() ],
"            \'y' : [ promptline#slices#vcs_branch() ],
"            \'warn' : [ promptline#slices#last_exit_code() ]
"            \}
"}

"tmuxline{
":Tmuxline airline
":TmuxlineSnapshot ~/.tmux/tmuxline.conf
let g:tmuxline_preset = {
            \'a'    : '#S',
            \'win'  : '#I #W',
            \'cwin' : '#I #W #F',
            \'x'    : '%Y-%m-%d',
            \'y'    : '%H:%M:%S',
            \'z'    : '#h',
            \'options': {
            \'status-justify':'left'}
            \}
"}

"tagbar{
map tb :TagbarToggle<cr>
xmap tb :TagbarToggle<cr>
"}

"ctrlp{
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links'
            \ }
"}

let g:quickr_cscope_use_qf_g = 1
let g:quickr_cscope_autoload_db = 0
"cscope{
if has("cscope")
    "silent cs kill 0
    "silent exe 'cs add '.g:root_dir.'/cscope.out -P '.g:root_dir
    "cs add /home/liguanrui/logic/cscope.out /home/liguanrui/logic

    set csto=1
    set cst
    "set nocscopeverbose
    "let g:cscope_out = g:root_dir.'/cscope.out'
    "if filereadable(g:cscope_out)
    "    silent exe 'cs add '.g:cscope_out.' '.g:root_dir
    "endif

    "set csprg=/usr/bin/cscope
    "set csto=1
    "set cst
    "set csverb
    "set cspc=3
    "set nocscopeverbose
    "set cscopequickfix=s-,c-,d-,i-,t-,e-
    "if filereadable("cscope.out")
        "cs add cscope.out
    "else
    "    let cscope_file=findfile("cscope.out", ".;")
    "    let cscope_pre=matchstr(cscope_file, ".*/")
    "    if !empty(cscope_file) && filereadable(cscope_file)
            "exe "cs add" cscope_file cscope_pre
    "    endif
    "endif
endif
"}

"}} 插件配置结束

" 保存时自动删除行尾空格
func! DeleteTrailingWS()
    %ret! 4
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
    :w
endfunc
"autocmd BufWrite * :call DeleteTrailingWS()
command W call DeleteTrailingWS()

" 记住上次编辑的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" 保存执行ctags
func! UPDATE_TAGS()
    "exe "!cd ".g:root_dir
    exe '!find `pwd` -name "*.c" -o -name "*.h" > cscope.files'
    exe "!ctags -R"
    exe "!cscope -bR -i cscope.files"
    "exe "!cscope -Rbqk"
    :cs reset <CR><CR>
endfunc
"autocmd BufWrite *.cpp,*.h,*.c,*.lua call UPDATE_TAGS()
command Ctags call UPDATE_TAGS()

