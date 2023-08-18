# 1 install ctags and cscope
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

