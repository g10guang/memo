# 个性化 vim 的过程

参考仓库：[https://github.com/yangyangwithgnu/use_vim_as_ide](https://github.com/yangyangwithgnu/use_vim_as_ide)个性化配置 vim，使 vim 具备更多 IDE 的功能。

步骤：

1. 安装 ctags：`sudo apt install ctags`
2. 安装 Vundle 管理 vim 插件：`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
3. 拉取 .vimrc 配置文件：`curl -o ~/.vimrc https://raw.githubusercontent.com/yangyangwithgnu/use_vim_as_ide/master/.vimrc`
4. 安装插件：打开 vim，执行命令 `:PluginInstall`
5. YouCompleteMe 代码补全插件相当大，从 github 下载需要很长时间：
    1. 在 YouCompleteMe 目录下执行：`git submodule update --init --recursive`
    2. 安装 future 库：`pip install future`
    3. 执行安装文件：`~/.vim/bundle/Youcompleteme/install.py`，具体参考：[https://github.com/Valloric/YouCompleteMe/issues/914](https://github.com/Valloric/YouCompleteMe/issues/914)

