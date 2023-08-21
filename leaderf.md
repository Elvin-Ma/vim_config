# leaderf 指令 : 目前验证失败

## installl
```vimrc
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' } " CExtension is faster
```

##
```shell
:Leaderf file # 从根目录内的文件中查找
:Leaderf function #
```

## user guide
```shell
<leader>b : 在已打开的缓冲区切换文件
<C-C>, <ESC> : 退出
<C-R> : 在模糊查询和正则表达式模式间切换
<C-F> : 在全路径搜索和名字搜索模式间切换
<Tab> : 切换成normal模式
<C-V>, <S-Insert> : 从剪切板里copy字符串进行查询
<C-U> : 清除已经打出的字符
<C-J>, <C-K> : 在结果列表中移动
<Up>, <Down> : 从历史记录里调出上一次/下一次的输入pattern
<2-LeftMouse> or <CR> : 打开在光标处的文件或者被选择的多个文件
<F5>  : 刷新缓存
<C-P> : 预览选中结果
<C-Up> : 在预览popup窗口里滚动向上
<C-Down> : 在预览popup窗口里滚动向下
<Ctrl-n>：在 LeaderF 界面中，按下 <Ctrl-n> 键可以切换到下一个匹配项。
<Ctrl-p>：在 LeaderF 界面中，按下 <Ctrl-p> 键可以切换到上一个匹配项。
<Ctrl-f>：在 LeaderF 界面中，按下 <Ctrl-f> 键可以向下翻页。
<Ctrl-b>：在 LeaderF 界面中，按下 <Ctrl-b> 键可以向上翻页。
<Ctrl-u>：在 LeaderF 界面中，按下 <Ctrl-u> 键可以向上滚动半页。
<Ctrl-d>：在 LeaderF 界面中，按下 <Ctrl-d> 键可以向下滚动半页。
<Ctrl-g>：在 LeaderF 界面中，按下 <Ctrl-g> 键可以显示当前文件的路径。
<Esc>：在 LeaderF 界面中，按下 <Esc> 键可以退出 LeaderF
```

## 结合 ripgrep 扩展功能
### install ripgrep
```shell
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
```

### ripgrep 常用选项
- w : 匹配整个字符串
- i : 忽略大小写
- F : 正常模式，不是正则表达式
- e : 多个搜索模式设定
- v : 反转匹配
- n ：显示行号
- l ：仅列出匹配文件
- g ：要搜索的文件模式 (rg -g "*.txt" "search_pattern")
- t ：限制要搜索的文件类型 (rg -t java "search_pattern")
- --hidden ：需要搜索隐藏文件
- --glob ： 指定要排除的文件模式



**vim 配置**
```vim
nmap <leader>F :Leaderf rg<CR> # 查找当前单词
```

## Leaderf 常用配置
```python
g:Lf_ShowHidden 设置1则显示隐藏文件. 默认值0.
g:Lf_PreviewInPopup 设置成1, 预览(preview)会在弹出(popup)窗口里显示, 而不会在原来的文件所在的窗口里显示. 默认值是0.
g:Lf_WindowHeight 设置窗口高度
g:Lf_CacheDirectory 设置缓存路径
g:Lf_StlColorscheme 设置状态栏配色方案
g:Lf_PreviewResult 设置哪几个功能自动显示preview
g:Lf_ReverseOrder 设置为1, 结果从下到上显示, 跟fzf/CtrlP一致, 默认是0, 从上倒下显示.
```
```shell
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<c-l>'
noremap <leader>f :LeaderfSelf<cr>
noremap <leader>fm :LeaderfMru<cr>
noremap <leader>ff :LeaderfFunction<cr>
noremap <leader>fb :LeaderfBufTagAll<cr>
noremap <leader>ft :LeaderfBufTag<cr>
noremap <leader>fl :LeaderfLine<cr>
noremap <leader>fw :LeaderfWindow<cr>
```
**对应的vimrc配置**
```vimrc
if has('nvim')
    let s:cachedir = expand(stdpath('cache'))
    let s:configdir = expand(stdpath('config'))
else
    "vim will share same folder with nvim
    if has('win32')
        let s:cachedir = expand('~/AppData/Local/Temp/cache/nvim')
        let s:configdir = expand('~/AppData/Local/nvim')
    else
        let s:cachedir = expand('~/.cache/nvim')
        let s:configdir = expand('~/.config/nvim')
    endif
endif
let g:Lf_PreviewInPopup = 1
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = s:cachedir
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {
        \ 'File': 0,
        \ 'Buffer': 0,
        \ 'Mru': 0,
        \ 'Tag': 0,
        \ 'BufTag': 1,
        \ 'Function': 1,
        \ 'Line': 1,
        \ 'Colorscheme': 0,
        \ 'Rg': 0,
        \ 'Gtags': 0
        \}
```

## 参考文献
[LeaderF 官方仓库](https://github.com/Yggdroot/LeaderF) <br>
[参考博文](https://retzzz.github.io/dc9af5aa/)<br>
[ripgrep 博文](https://www.cnblogs.com/niubidexiebiao/p/15828534.html)<br>
[ripgrep 中文文档](https://github.com/chinanf-boy/ripgrep-zh/blob/master/rg-0.10.0-h.zh.md)<br>
[Leaderf rg 配置](https://retzzz.github.io/dc9af5aa/) <br>
[Leaderf 简单文档](https://blog.csdn.net/fqbqrr/article/details/117821247) <br>
