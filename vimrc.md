# vimrc 指令解读

```shell

map  # 是在普通模式下创建键盘映射的命令。
xmap # 是在可视模式下创建键盘映射的命令
inoremap  # 在插入模式下创建键盘映射。
nnoremap  # 在普通模式下创建快捷键映射
inoremap <C-j> <Esc> # 在插入模式下将 <Esc> 映射到 <Ctrl-j>
<CR> # vim 编辑器中用于表示回车键的特殊符号

#这是 Vim 中用于定义函数的关键字，！表示重新定义，即使定义过了。
# s 开头表示局部函数
function! s:show_documentation()

<silent> # 这是一个修饰符，用于在执行映射时禁止显示命令行消息
<nowait> # 这是一个修饰符，用于在执行映射后立即返回而不等待其他键入
<expr> #这是一个修饰符，用于表示映射的右手边是一个 Vim 表达式（expression），而不是普通的按键序列
```



