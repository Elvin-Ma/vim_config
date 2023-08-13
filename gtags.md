# gtag install guide

## 1.1 env prepare
```shell
pip install pygments
sudo apt-get install global
sudo apt-get install exuberant-ctags python-pygments
sudo apt install libncurses5-dev libncursesw5-dev
```

## 1.2 install gtags
```shell
wget https://ftp.gnu.org/pub/gnu/global/global-6.6.5.tar.gz
tar xzvf global-6.6.5.tar.gz
cd global-6.6.5
./configure --with-exuberant-ctags=/usr/bin/ctags
make -j16 && sudo make install
```

## 1.3 env variable set
```shell
print(typ, tag, lnum, path.encode('utf-8'), image)
export GTAGSLABEL=pygments
export $GTAGSLABEL = 'native-pygments'
export $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
cp /usr/local/share/gtags/gtags.conf ~/.globalrc
```

## 1.4 gtags use guide
- gtags # 生成整个目录的索引文件
- global -u # 更新目录的索引文件(不用重新生成)  
- global kernel-name# 查询函数
- 
