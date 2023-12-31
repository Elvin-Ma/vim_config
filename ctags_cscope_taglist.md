# 1 install ctags and cscope
**install from apt**
```python
sudo apt-get install ctags
sudo apt-get install cscope
sudo apt-get install -y exuberant-ctags
```
**install ctags from src code**
```python
download src code from https://ctags.sourceforge.net/
wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
tar zxvf ctags-5.8.tar.gz
cd ctags-5.8.tar.gz
./configure
make -j16
sudo make install
```

# 2 install taglist : depend on ctag
```python
git clone git@github.com:vim-scripts/taglist.vim.git
# 或者 wget https://sourceforge.net/projects/vim-taglist/files/vim-taglist/4.6/taglist_46.zip/download && unzip download
cd ~/.vim
unzip taglist.zip
```
**.vimrc**
```vimrc
filetype plugin on " 启用vim编译器的插件--> 不装好像也没啥事
let g:Tlist_Use_Right_Window = 1 " 窗口在右侧显示
nnoremap <F8> : TlistOpen<CR> " TlistOpen 快捷键
" quick key to updata ctags
nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
```

# 3 install cscope
```shell
sudo apt-get install cscope
```

# 4 user guide
## 4.1 ctags guide
```vim
ctags -R . # 生成ctags 文件
ctags -L *.txt # 采用指定文件生成ctags
: ta[g] <function> # 查找函数的定义
<Ctrl - ]> # 从函数调用 --> 函数定义
<Ctrl - t> # 从函数定义 --> 函数调用
<Ctrl - n> # 打开函数补全功能
ctags --help # shell 打开帮助文档
:help ctags # vim 中打开帮助文档
vim -t tag *.cpp # 打开文件并定位到tag位置
```
** 访问第三方库的函数**
```vimrc
# 在 ~/.vim/systags 下生成系统头文件的tag
ctags --fields=+iaS --extra=+q -R -f ~/.vim/systags /usr/include /usr/local/include
set tags+=~/.vim/systags # 将上述文件加到vimrc 中
set tags=tags;
set tags=./tags;,tags # 当前文件所在文件夹 + 当前文件夹
set autochdir # 自动向上查找
set tags+=./tags; # add current directory’s generated tags file
set tags+=~/program/tags ” add new tags file
```


## 4.2 taglist guide
```vim
:TlistOpen # 打开标签列表窗口
q # 退出taglist
p # tag 定义预览
[[ # 走到taglist 中前一个文件
]] # 走到taglist 中后一个文件
<space> # 在下方显示函数签名
o # 在新窗口中打开当前文件
F1 # 打开帮助文档
:TlistUpdate # 手动生成ctags 文件
```
## 4.3 cscope guide
**生成索引文件**
```shell
cscope -Rbq # 生成索引文件
cscope -bkq -i *.txt # 使用文件名生成 cscope 文件
# 上述代码生成的是相对路径，打开文件时会出现文件找不到，采用下面方法解决
find `pwd` -name *.cpp -o -name *.h -o -name *.hpp> cscope.files && cscope -Rbq
# cscope 生成索引参数解释
-R: 在生成索引文件时，搜索子目录树中的代码
-b: 只生成索引文件，不进入cscope的界面
-k: 在生成索引文件时，不搜索/usr/include目录
-q: 生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度
-i: 如果保存文件列表的文件名不是cscope.files时，需要加此选项告诉cscope到哪儿去找源文件列表。可以使用"-"，表示由标准输入获得文件列表。
-I dir: 在-I选项指出的目录中查找头文件
-u: 扫描所有文件，重新生成交叉索引文件
-C: 在搜索时忽略大小写
-P path: 在以相对路径表示的文件前加上的path，这样，你不用切换到你数据库文件所在的目录也可以使用它了。
```

**加载cscope 索引**
```vim
: cs add cscope.out " 可以加载多个数据库文件
: cs show # 查看加载的数据库文件
: cs -h # 查看帮助文档
: cs -f <querytype> tag
```

**cscope querytype**<br>
| 数字 | 查询类型 | 描述|
| ---- |--------- |-------------------------|
| 0    | s        | C符号出现过的地方|
| 1    | g        | 定义的地方 |
| 2    | d        | 被这个函数调用的函数列表|
| 3    | c        | 调用这个函数的函数列表|
| 4    | t        | 搜索字符串|
| 5    | e        | egrep 匹配|
| 6    | f        | 搜索文件|
| 7    | i        | 包含这个文件的文件列表|

## 4.3 生成tag cscope的快捷键设置
```python
"Generate tags and cscope.out from FileList.txt (c, cpp, h, hpp)
nmap <C-@> :!find -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" > FileList.txt<CR>
                       \ :!ctags -L -< FileList.txt<CR>
                       \ :!cscope -bkq -i FileList.txt<CR>
```

## 4.4 cscope 自动生成配置
```python
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " 添加数据库，但不添加同名但不在当前目录中的数据库
    " （比如在另一个窗口中运行 'cscope -d'）
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    if filereadable("cscope.out")
        cs add cscope.out
        " 来自 cscope 向导的 'cs add cscope.out'
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
        " 来自 cscope 向导的 'cs add $CSCOPE_DB'
    else
        " 寻找包含 'cscope.out' 的目录，从当前目录开始
        let s:root_dir = expand("%:p:h")
        while s:root_dir != '/' && !filereadable(s:root_dir . "/cscope.out")
            let s:root_dir = fnamemodify(s:root_dir, ':h')
        endwhile
        if filereadable(s:root_dir . "/cscope.out")
            cs add s:root_dir . "/cscope.out"
        endif
    endif
endif

# 首先检查是否存在 cscope 功能。
# 如果当前目录下有一个 cscope.out 文件，那么就添加它。
# 如果没有，但是环境变量 CSCOPE_DB 被设置了，那么就添加这个
# export CSCOPE_DB=/path/to/cscope.out(其它文件夹的cscope，优先级第二)
# 如果都没有，那么就向上查找包含 cscope.out 文件的目录，并添加它。
```

# 5 参考文档
[cscope guide1](https://developer.aliyun.com/article/33160)<br>

