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
: cs add cscope.out
: cs -h # 查看帮助文档
```

## 4.3 生成tag cscope的快捷键设置
```python
"Generate tags and cscope.out from FileList.txt (c, cpp, h, hpp)
nmap <C-@> :!find -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" > FileList.txt<CR>
                       \ :!ctags -L -< FileList.txt<CR>
                       \ :!cscope -bkq -i FileList.txt<CR>
```

# 5 参考文档
[cscope guide1](https://developer.aliyun.com/article/33160)<br>

