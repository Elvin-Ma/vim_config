# 1. 安装jedi-vim
- 在.vimrc 中vundle begin and end 之间插入：
```python
Pulgin 'davidhalter/jedi-vim'
```
- vim 打开文件
```python
:PluginInstall
```
- conda 环境中执行：
```python
conda install jedi
```

# 2. 常见配置

```python
let mapleader=";"
let g:jedi#goto_command = "<leader>d" "跳转到定义
let g:jedi#goto_assignments_command = "<leader>g" #当前光标下标志符的定义位置
let g:jedi#documentation_command = "K" "查看python的文档
let g:jedi#usages_command = "<leader>n" "当前缓冲区中查找下一个
let g:jedi#completions_command = "<C-Space>" "触发代码补全
let g:jedi#rename_command = "<leader>r" " 重命名标识符(在整个代码中)
let g:jedi#force_py_version = 3  " 使用 Python 3.x 解析器
let g:jedi#python_path = '/home/mtn/miniconda3/bin/python' #解释器路径设置
```

# 3. 直接在vim中导入一个模块
```python
:Pyimport os
```

# 4. vim自带的跳转指令
- gd # 在当前缓存区内跳转到光标所在标识符的定义位置
- ctrl + o # 返回上一个光标的位置
- ctrl + i # 前进到下一个光标的位置
- ctrl + T # 返回上一个跳转的位置
- ctrl + [ / ] # 尝试跳转到标识符的定义位置
- ：jumps # 显示跳转列表，按下相应变化即可跳转
- "*" # 跳转到下个单词
- "#" # 跳转到上个单词

# 5. 帮助文档
```vim
:h jedi-vim
```

# 6. 官方仓库
[官方仓库](https://github.com/davidhalter/jedi-vim)
[官方文档](https://jedi.readthedocs.io/en/latest/)