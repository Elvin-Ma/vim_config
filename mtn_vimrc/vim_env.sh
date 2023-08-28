#!/bin/bash
cd && mkdir -p .vim && cd .vim

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim 8.2(optional)
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
ctags --fields=+iaS --extra=+q -R -f ~/.vim/tags /usr/include /usr/local/include

echo "alias cs_get='find `pwd` -name *.cpp -o -name *.h -o -name *.hpp > cscope.files && cscope -Rbq'" >> ~/.bashrc
echo "alias ct_get='ctags -R .'" >> ~/.bashrc
echo "alias cc_get='ctags -R && find `pwd` -name *.cpp -o -name *.h -o -name *.hpp > cscope.files && cscope -Rbq'" >> ~/.bashrc

# install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb

