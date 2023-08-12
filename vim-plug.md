# 1 download src file
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# .vimrc
```python
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'call
plug#end()
```

# install plugin
```.vimrc
$ vim        #打开vim
:PlugStatus  #查看插件状态
:PlugInstall #安装之前在配置文件中声明的插件
:PlugUpdate   #更新插件
:PlugDiff     #查看插件的变化状态，简单地回滚有问题的插件。
:PlugClean    #删除插件
```

# 参考文献
[参考文献1](https://github.com/junegunn/vim-plug)
[参考安装插件](https://zhuanlan.zhihu.com/p/145793963)
