# leaderf 指令 : 目前验证失败

##
```shell
:Leaderf file # 从根目录内的文件中查找
:Leaderf function #
```

## user guide
```shell
- <C-C>, <ESC> : 退出 LeaderF. 
- <C-R> : 在模糊匹配和正则式匹配之间切换
- <C-F> : 在全路径搜索和名字搜索之间切换
- <Tab> : 在检索模式和选择模式之间切换
- <C-J>, <C-K> : 在结果列表里选择
- <C-X> : 在水平窗口打开
- <C-]> : 在垂直窗口打开
- <C-T> : 在新标签打开
- <C-P> : 预览结果
```

## 结合 ripgrep 功能
```shell
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
```
**vim 配置**
```vim
nmap <leader>F :Leaderf rg<CR>
```

## 官方链接
[LeaderF 官方仓库](https://github.com/Yggdroot/LeaderF)
