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
wget https://sourceforge.net/projects/vim-taglist/files/vim-taglist/4.6/taglist_46.zip/download
unzip download
ctags -R --c++-kinds=+p --fields=+aiKSz --extra=+q --exclude=build -f ~/.vim/tags /usr/include /usr/local/include

# 在当前目录下上次cscope 和 ctags
#echo "alias cs_get='find `pwd` -name *.cpp -o -name *.h -o -name *.hpp -o -name *.py | grep -v 'build/'> cscope.files && cscope -Rbq'" >> ~/.bashrc
echo "alias cs_get='find `pwd` -name *.cpp -o -name *.h -o -name *.hpp -o -name *.py | grep -v /build/ | cscope -Rbq'" >> ~/.bashrc
echo "alias ct_get='ctags -R --c++-kinds=+p --fields=+aiKSz --extra=+q --exclude=build'" >> ~/.bashrc
echo "alias cc_get='ctags -R --c++-kinds=+p --fields=+aiKSz --extra=+q --exclude=build && find `pwd` -name *.cpp -o -name *.h -o -name *.hpp -o -name *.py | grep -v /build/ | cscope -Rbq'" >> ~/.bashrc
echo "alias cc_del='rm -rf cscope.*; rm tags'"

# install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
```

# 1 vim-Plug 常用操作
```shell
:PlugInstall to install the plugins
:PlugUpdate to install or update the plugins
:PlugDiff to review the changes from the last update
:PlugClean to remove plugins no longer in the list
```

# 2 ctags 和 cscope 常用配置 
## 2.1 ctags 参数配置
- --languages=<language>: 指定要生成标签的编程语言，可以是特定语言（如 C、C++、Python 等）或使用 --exclude 排除特定语言。
- --exclude=<pattern>: 排除匹配某个模式的文件或目录，通常用于避免生成不必要的标签。
- --output-format=<format>: 指定输出格式，可以是 compact、exuberant 等，控制生成标签文件的格式。
- --fields=<field>: 用于选择或排除某些字段，如前面提到的 i、a、S 等。
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i 表示如果有继承，要标明父类；
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a 表示如果是类的成员，要标明其access属性（即是public的还是private的）；
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S 表示如果是函数，要标明函数的signature；
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K 表示要显示语法元素类型的全称；
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; z 表示在显示语法元素的类型时，使用格式kind:type。
- --extra=<field>: 用于选择额外的描述信息，比如类名加函数名。
- --verbose: 在生成标签时显示更多的信息，在调试时非常有用。
- --sort: 选择标签的排序方式，可以选择 0（不排序）、1（按字母排序）等。
- --no-warn: 禁用警告信息的显示，主要用于减少输出信息。
- -f <filename>: 指定生成的标签文件的名称，默认是 tags。
- -R: 递归地处理目录，适合处理大型项目。
- --c++-kinds=+p : 生成的标签文件将包含 C++ 中的类原型信息，便于开发者理解和使用类的方法

## 2.2 ctags 命令和快捷键
- 命令 ：tag tagname --> 跳转到tagname的定义处，即使它在另一个文件中;
- 命令 ：tags --> 列出层访问过的tag的列表
- 快捷键 Ctrl+] --> 取出当前光标下的单词作为tag进行跳转
- 快捷键 Ctrl+T --> 跳转到前一次的tag处
- 命令 ：stag name --> 在分裂出的窗口跳转到指定的tag
- 快捷键 Ctrl + W + ] --> 同上
- 命令 ：set tags=./tags, ../tags --> 设置多个tags, 会覆盖之前的tags
- 命令 ：set tag? --> 查看之前设置的tags

# 2.2 cscope 配置



# 3 vim 内置跳转快捷键
- gd # 在当前缓存区内跳转到光标所在标识符的定义位置
- ctrl + o # 返回上一个光标的位置
- ctrl + i # 前进到下一个光标的位置
- ctrl + T # 返回上一个跳转的位置
- ctrl + [ / ] # 尝试跳转到标识符的定义位置
- ：jumps # 显示跳转列表，按下相应变化即可跳转
- "*" # 跳转到下个单词
- "#" # 跳转到上个单词


# 4 参考文献
- [参考文献1](https://www.linuxmi.com/ubuntu-vim-8-2-python-ide.html)
- [参考文献2](https://learnku.com/articles/36344)
- [配置c++环境](https://www.zhihu.com/question/47691414/answer/373700711)
- [vim快捷键大全](https://vim.rtorr.com/lang/zh_cn)
- [vim tutorial](https://www.openvim.com/tutorial.html)
