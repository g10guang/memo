# dotfile 执行

- `/etc/rc.locale`：This script is executed at the end of each multiuser runlevel.

- `/etc/profile`：execute only for interactive shell.

- `/etc/bashrc`：execute for both interactive and non-interactive shell.

- `/etc/profile.d/`：

- `~/.profile`：executed by the command interpreter for login shells. 通过 shell 登陆执行的脚本

- `~/.bashrc`：每次启动 bash terminal 执行的脚本；

- `~/.zshrc`：每次启动 zsh terminal 执行的脚本

- `~/.xsession`：the role of ~/.profile and ~/.xinitrc combined

- `~/.xinitrc`：X 启动后执行的脚本

- `/etc/init.d/`


linux 下查看所有环境变量：`env`