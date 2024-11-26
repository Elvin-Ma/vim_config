# 0 安装插件管理器
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;常见的有两种vim 的插件管理器:  Vundle 和 vim-plug, 我们这里推荐用vim-plug.

```shell
#!/bin/bash
cd && mkdir -p .vim && cd .vim

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim 8.2(optional) 当vim版本较低时可选择性安装
#git clone git@github.com:vim/vim.git
#cd vim
#git checkout v8.2.0108
##./configure --prefix=$HOME/.local --enable-python3interp=yes
#./configure --enable-python3interp=yes
#make -j16
#sudo make install

# ctags + taglist + cscope prepare
sudo apt-get install -y exuberant-ctags
sudo apt-get install cscope
# wget https://sourceforge.net/projects/vim-taglist/files/vim-taglist/4.6/taglist_46.zip/download
# unzip download
ctags -R --c++-kinds=+p --fields=+aiKSz --extra=+q -f ~/.vim/tags /usr/include /usr/local/include

pip install jedi # install vim-jedi for python

# install ripgrep
# curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
# sudo dpkg -i ripgrep_13.0.0_amd64.deb
```

# 1 ctags 和 cscope 生成
- 生成标准库里的ctags
```shell
ctags -R --c++-kinds=+p --fields=+aiKSz --extra=+q -f ~/.vim/tags /usr/include /usr/local/include
```
*注释：tags 用-f 指定生成路径，而具体的文件路径要用绝对路径，否则会找不到* <br>

- cscope 生成c++ 标准库cscope
```shell
find /usr/include/c++/ -name '*.h' -o -name '*.hpp' > cscope.files
find other/path -name *.h >> cscope.files

```

- 快捷的生成方式
```shell
alias cc_get='ctags -R --c++-kinds=+p --fields=+aiKSz --extra=+q --exclude=build `pwd` && find `pwd` -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.py" | grep -v /build/ | grep -v third-party > cscope.files && cscope -Rbq'
# mv ctags cscope.*  ~/.vim/projects/ # 移动到标准位置
alias cc_del='rm -rf cscope.*; rm tags'
```
*注释：以上两条可以加到~/.bashrc 里，用以快速生成cscope 和 ctags，注意用 `pwd` 获取绝对路径，这样生成的文件经过copy后照样可以使用* <br>

- 指定CSCOPE_DB 和 CTAGS_DB 环境变量
*注释：.vimrc 里规定了使用环境变量来查找ctags 和 cscope，我们可以通过这两个环境变量快捷加载相关数据文件* <br>
*注意：cscope 路径不需要指定到cscope.out 文件，但ctags的路径需要制定到具体的tags文件* <br>

- 可以将cscope 和 ctags 安装项目放到 ~/.vim/projects 里，方便查找

# 2 常用指令
- 文件内查找并替换
```
: %s/old_token/new_token/gc
```
- 全局查找并替换(一定要用l: 只显示文件名，n 会加行号)
```shell
grep -wlr "index_fill_" | xargs perl -pi -e 's/index_fill_/index_fill_mtn/g'
```
- 查看代码作者(git-blame 插件)
```shell
; + s
```

- 将一个文件视为其它文件类型
```shell
: set filetype=cpp
```

- vim 常用跳转指令
```shell
- gd # 在当前缓存区内跳转到光标所在标识符的定义位置
- ctrl + o # 返回上一个光标的位置
- ctrl + i # 前进到下一个光标的位置
- ctrl + T # 返回上一个跳转的位置
- ctrl + [ / ] # 尝试跳转到标识符的定义位置
- ：jumps # 显示跳转列表，按下相应变化即可跳转
- "*" # 跳转到下个单词
- "#" # 跳转到上个单词
```

- jedi python 跳转快捷键
```shell
命令 ： h jedi # 查看帮助文档
命令 ：Pyimport  --> e.g. :Pyimport os shows os.py in VIM
快捷键：<Ctrl-Space> --> 补全
快捷键：<leader>d --> 转到定义
快捷键：<leader>g --> Go to assignment (跳转到赋值)
快捷键：<leader>s --> Go to stub
快捷键：<leader>n --> 多少处使用一个name(Show usages of a name).
快捷键：<leader>r --> 替换名称(Rename variables)
快捷键：<leader>R --> 不删除替换名称
快捷键：<K> --> Show pydoc documentation
```

- ctags 跳转指令
```shell
- 命令 ：tag tagname --> 跳转到tagname的定义处，即使它在另一个文件中;
- 命令 ：tags --> 列出层访问过的tag的列表
- 快捷键 Ctrl+] --> 取出当前光标下的单词作为tag进行跳转
- 快捷键 Ctrl+T --> 跳转到前一次的tag处
- 命令 ：stag name --> 在分裂出的窗口跳转到指定的tag
- 快捷键 Ctrl + W + ] --> 同上
- 命令 ：set tags=./tags, ../tags --> 设置多个tags, 会覆盖之前的tags
- 命令 ：set tag? --> 查看之前设置的tags
```

- cscope 跳转指令
```shell
's'   symbol: find all references to the token under cursor (查找函数名、宏、枚举值等出现的地方)
'g'   global: find global definition(s) of the token under cursor (查找函数、宏、枚举等定义的位置，类似ctags所提供的功能)
'c'   calls:  find all calls to the function name under cursor (查找调用本函数的函数)
't'   text:   find all instances of the text under cursor (查找指定的字符串)
'e'   egrep:  egrep search for the word under cursor (安装egrep 查找token，但查找速度快)
'f'   file:   open the filename under cursor (查找并打开文件)
'i'   includes: find files that include the filename under cursor (查找包含文件名的文件)
'd'   called: find functions that function under cursor calls

# 使用方法1(命令)
: cs find g name

# 使用方法2(快捷键)
<leader>cg
```

# 3 vim-Plug 常用操作
```shell
:PlugInstall to install the plugins
:PlugUpdate to install or update the plugins
:PlugDiff to review the changes from the last update
:PlugClean to remove plugins no longer in the list
```

# 4 ctags 和 cscope 常用配置 
## 4.1 ctags 参数配置
- --languages=<language>: 指定要生成标签的编程语言，可以是特定语言（如 C、C++、Python 等）或使用 --exclude 排除特定语言。
- --exclude=<pattern>: 排除匹配某个模式的文件或目录，通常用于避免生成不必要的标签。
- --output-format=<format>: 指定输出格式，可以是 compact、exuberant 等，控制生成标签文件的格式。
- --fields=<field>: 用于选择或排除某些字段，如前面提到的 i、a、S 等。
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i 表示如果有继承，要标明父类；<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a 表示如果是类的成员，要标明其access属性（即是public的还是private的）；<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S 表示如果是函数，要标明函数的signature；<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K 表示要显示语法元素类型的全称；<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; z 表示在显示语法元素的类型时，使用格式kind:type。<br>
- --extra=<field>: 用于选择额外的描述信息，比如类名加函数名。
- --verbose: 在生成标签时显示更多的信息，在调试时非常有用。
- --sort: 选择标签的排序方式，可以选择 0（不排序）、1（按字母排序）等。
- --no-warn: 禁用警告信息的显示，主要用于减少输出信息。
- -f <filename>: 指定生成的标签文件的名称，默认是 tags。
- -R: 递归地处理目录，适合处理大型项目。
- --c++-kinds=+p : 生成的标签文件将包含 C++ 中的类原型信息，便于开发者理解和使用类的方法

## 4.2 ctags 命令和快捷键
- 命令 ：tag tagname --> 跳转到tagname的定义处，即使它在另一个文件中;
- 命令 ：tags --> 列出层访问过的tag的列表
- 快捷键 Ctrl+] --> 取出当前光标下的单词作为tag进行跳转
- 快捷键 Ctrl+T --> 跳转到前一次的tag处
- 命令 ：stag name --> 在分裂出的窗口跳转到指定的tag
- 快捷键 Ctrl + W + ] --> 同上
- 命令 ：set tags=./tags, ../tags --> 设置多个tags, 会覆盖之前的tags
- 命令 ：set tag? --> 查看之前设置的tags

# 4.3 cscope 配置
- 查看帮助文件
  cscope -h

- 命令启动格式
```shell
cscope [-bcCdehklLqRTuUvV] [-f file] [-F file] [-i file] [-I dir] [-s dir]
              [-p number] [-P path] [-[0-8] pattern] [source files]
```

- -b: 仅构建交叉引用(对代码中的符号（如函数、变量、类等）的引用关系进行分析和记录的过程);
- -C: 在搜索时忽略字母大小写;
- -c: 在交叉引用文件中仅使用 ASCII 字符（不压缩）;
- -d: 不更新交叉引用;
- -e: 在文件之间抑制 <Ctrl>-e 命令提示符;
- -F symfile: 从 symfile 中读取符号引用行;
- -f reffile: 使用 reffile 作为交叉引用文件名，而不是 cscope.out;
- -h: 显示帮助屏幕;
- -I incdir: 在 incdir 中查找任何 #include 文件;
- -i namefile: 浏览 namefile 中列出的文件，而不是 cscope.files;
- -k: 内核模式 - 不使用 /usr/include 作为 #include 文件;
- -L: 进行单次搜索并输出行导向结果;
- -l: 行导向界面;
- -num pattern: 转到输入字段 num（从 0 开始计数）并查找模式;
- -P path: 将路径添加到预构建交叉引用文件中的相对文件名;
- -p n: 显示最后 n 个文件路径组件;
- -q: 为快速符号搜索构建反向索引;
- -R: 递归目录以查找文件;
- -s dir: 在 dir 中查找额外的源文件;
- -T: 仅使用前八个字符匹配 C 符号;
- -U: 检查文件时间戳;
- -u: 无条件构建交叉引用文件;
- -v: 在行模式下提供更多详细信息;
- -V: 打印版本号;

## 4.4 cscope 常见指令
- 's'   symbol: find all references to the token under cursor (查找函数名、宏、枚举值等出现的地方)
- 'g'   global: find global definition(s) of the token under cursor (查找函数、宏、枚举等定义的位置，类似ctags所提供的功能)
- 'c'   calls:  find all calls to the function name under cursor (查找调用本函数的函数)
- 't'   text:   find all instances of the text under cursor (查找指定的字符串)
- 'e'   egrep:  egrep search for the word under cursor (安装egrep 查找token，但查找速度快)
- 'f'   file:   open the filename under cursor (查找并打开文件)
- 'i'   includes: find files that include the filename under cursor (查找包含文件名的文件)
- 'd'   called: find functions that function under cursor calls

**使用方式**<br>
```shell
命令 : cs find g name
```

# 5 标准vimrc 配置
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
set listchars=space:· "空格以点来显示
filetype plugin on

let mapleader=";"
let g:python3_host_prog = '/usr/bin/python3'
set hlsearch
highlight search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo "记录光标位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif "重新打开光标位置不变

" window size ctrl
nmap <C-j> <C-W>+
nmap <C-k> <C-W>-
nmap <C-h> <C-W><
nmap <C-l> <C-W>>

" plugged ______________
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/taglist.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline' "增强 Vim 状态栏的外观和功能
Plug 'Yggdroot/LeaderF'
Plug 'bfrg/vim-cpp-modern' "c++ 函数名等会有颜色
Plug 'zivyangll/git-blame.vim'
Plug 'jiangmiao/auto-pairs' "括号自动补全
Plug 'azabiong/vim-highlighter'
Plug 'davidhalter/jedi-vim' "python 补全和跳转
call plug#end()

autocmd FileType python let g:autoformatpython_enabled = 1

" ================== nerdtree ===========
map <leader>t :NERDTreeToggle<CR>
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"nn <leader>[ :exec("NERDTree ".expand('%:h'))<CR>
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
map <leader><space> :FixWhitespace<cr>

" ====================   Leaderf  ================
"let g:Lf_WindowPosition = 'popup'
let g:Lf_WorkingDirectoryMode='AF'
let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.project', '.root']
" 搜索时候排除如下
let g:Lf_WildIgnore={
    \ 'dir':['.svn', '.git', '.cache', '.gitIgnore', 'tags'],
    \ 'file':['*.idx', '*.so', '*.o', '.bak']
    \}
let g:Lf_UseVersionControlTool=1 "这个是默认选项, 可以不写
let g:Lf_DefaultSearchDir = system('git rev-parse --show-toplevel 2>/dev/null') " find from project other than file path
let g:Lf_DefaultExternalTool='rg'
let g:Lf_ShortcutF = '<c-p>'
" let g:Lf_ShortcutB = '<c-l>'
noremap <leader>fb :<C-U><C-R>=printf("Leaderf! buffer %s", "")<CR><CR>
" file opend recently
noremap <leader>fm :<C-U><C-R>=printf("Leaderf! mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf! bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf! line %s", "")<CR><CR>
noremap <leader>ff :<C-U><C-R>=printf("Leaderf! function %s", "")<CR><CR>
noremap <leader>fw :<C-U><C-R>=printf("Leaderf! window  %s", "")<CR><CR>
"noremap <leader>ff :<C-U><C-R>=printf("Leaderf! file  %s", "")<CR><CR>
"noremap <leader>f :LeaderfSelf<cr>
"noremap <leader>fm :LeaderfMru<cr>
"noremap <leader>ff :LeaderfFunction<cr>
"noremap <leader>fb :LeaderfBufTagAll<cr>
"noremap <leader>ft :LeaderfBufTag<cr>
"noremap <leader>fl :LeaderfLine<cr>
"noremap <leader>fw :LeaderfWindow<cr>

" ====================  ripgrep set ==============
" find word for self defined
" nmap <leader>F :Leaderf rg<CR>
nmap <unique> <leader>f <Plug>LeaderfRgPrompt
noremap <leader>b :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <leader>wf :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <leader>wa :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", expand("<cword>"))<CR>
noremap <leader>wb :<C-U><C-R>=printf("Leaderf! rg -F -w -e %s ", expand("<cword>"))<CR>
noremap <leader>wc :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <leader>wd :<C-U><C-R>=printf("Leaderf! rg -w -e %s ", expand("<cword>"))<CR> " ____
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR> " ________________
"nmap <unique> <leader>wa <Plug>LeaderfRgCwordLiteralNoBoundary
"nmap <unique> <leader>wb <Plug>LeaderfRgCwordLiteralBoundary
"nmap <unique> <leader>wc <Plug>LeaderfRgCwordRegexNoBoundary
"nmap <unique> <leader>wd <Plug>LeaderfRgCwordRegexBoundary
" alt + b, noremap--> only use for this command
" search visually selected text literally


" ================ ctags+taglist+cscope =====================
let g:Tlist_Use_Right_Window = 1
nnoremap <F8> : TlistOpen<CR>
nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=./tags;,tags "可以不在当前tag路径下运行
set autochdir
"set tags +=/root/.vim/projects/base/tags " default not load
if $CTAGS_DB != ""
    set tags+=$CTAGS_DB
endif

if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0 "先查cscope 再查 ctags
  set cst
  set nocsverb
  set cscopetag

  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
       "cs add /root/.vim/projects/br_pytorch/cscope.out
       "cs add /root/.vim/projects/base/cscope.out
      cs add $CSCOPE_DB
      let cscope_db_list = split($CSCOPE_DB, ":")
      for cscope_db in cscope_db_list
        execute 'cs add' cscope_db
      endfor
  endif
  set csverb
  set cscopeverbose " show msg when any other cscope db added
endif

noremap <leader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>
noremap <leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>
noremap <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
noremap <leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>
noremap <leader>ce :cs find e <C-R>=expand("<cword>")<CR><CR>
noremap <leader>cf :cs find f <C-R>=expand("<cfile>")<CR><CR>
noremap <leader>ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
noremap <leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>

" ======================= Auto format ================
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_c_cpp_clangformat = 'clang-format'

" =================== window cut ===============
noremap <Leader>g1 :call win_gotoid(win_getid(1))<CR>
noremap <Leader>g2 :call win_gotoid(win_getid(2))<CR>
noremap <Leader>g3 :call win_gotoid(win_getid(3))<CR>
noremap <Leader>g4 :call win_gotoid(win_getid(4))<CR>
noremap <Leader>g5 :call win_gotoid(win_getid(5))<CR>
noremap <Leader>g6 :call win_gotoid(win_getid(6))<CR>
noremap <Leader>g7 :call win_gotoid(win_getid(7))<CR>
noremap <Leader>g8 :call win_gotoid(win_getid(8))<CR>

" ==================== git blame ===========
nnoremap <Leader>p :<C-u>call gitblame#echo()<CR>

" ==================== tab list ============
let g:Tlist_File_Fold_Auto_Close=1
let g:Tlist_Show_One_File=1
```

# 6 参考文献
- [参考文献1](https://www.linuxmi.com/ubuntu-vim-8-2-python-ide.html)
- [参考文献2](https://learnku.com/articles/36344)
- [配置c++环境](https://www.zhihu.com/question/47691414/answer/373700711)
- [vim快捷键大全](https://vim.rtorr.com/lang/zh_cn)
- [vim tutorial](https://www.openvim.com/tutorial.html)
- [cscope 配置](https://cscope.sourceforge.net/cscope_maps.vim)
