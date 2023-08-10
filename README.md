# 1 安装插件管理器
- Vundle
- Vim-plug

## 1.1 下载Vundle 到指定路径
```python
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## 1.2 在.vimrc 中编辑如下内容
```python
set nocompatible "去除vim一致性，必须
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim "安装的目录
call vundle#begin()

" ... 其他插件配置 ...
" 安装github 上的插件格式为：Plugin 'a/b'
"eg: https://github.com/VundleVim/Vundle.vim.git
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'

call vundle#end()
filetype plugin indent on "加载vim自带和插件相应的语法和文件类型相关脚本，必须
```

## 1.3 安装插件
- vim 指令打开vim
- :PluginInstall

## 1.4 卸载插件
- 在.vimrc 中删除对应行
- 打开vim
- :BundleClean

# 安装jedi
conda install jedi

# 2 参考文献
[参考文献1](https://www.linuxmi.com/ubuntu-vim-8-2-python-ide.html)
