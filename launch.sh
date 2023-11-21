apt-get install silversearcher-ag
pip3 install pynvim
sudo apt install ripgrep

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
source ~/.config/nvim/init.vim
