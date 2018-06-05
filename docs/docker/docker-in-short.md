# Docker in short

[学习文档](https://github.com/yeasy/docker_practice)

## 基本概念

### 镜像

Docker 镜像是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）。镜像不包含任何动态数据，其内容在构建之后也不会被改变。

### 容器

容器的实质是进程，但与直接在宿主执行的进程不同，容器进程运行于属于自己的独立的 命名空间。因此容器可以拥有自己的 root 文件系统、自己的网络配置、自己的进程空间，甚至自己的用户 ID 空间。容器内的进程是运行在一个隔离的环境里，使用起来，就好像是在一个独立于宿主的系统下操作一样。这种特性使得容器封装的应用比直接在宿主运行更加安全。

数据卷的生存周期独立于容器，容器消亡，数据卷不会消亡。因此，使用数据卷后，容器删除或者重新运行之后，数据却不会丢失。

## 安装

[文档](https://yeasy.gitbooks.io/docker_practice/content/install/ubuntu.html)

## 镜像

从 docker hub 拉取镜像：

```zsh
docker pull [选项] [Docker Registry 地址[:端口号]/]仓库名[:标签]
```

`docker images` 列表中的镜像体积总和并非是所有镜像实际硬盘消耗。由于 Docker 镜像是多层存储结构，并且可以继承、复用，因此不同镜像可能会因为使用相同的基础镜像，从而拥有共同的层。由于 Docker 使用 Union FS，相同的层只需要保存一份即可，因此实际镜像硬盘占用空间很可能要比这个列表镜像大小的总和要小的多。

查看镜像、容器、数据卷所占用的空间：

```zsh
sudo docker rm $(sudo docker ps -aq)
```

删除悬虚镜像：

```
docker image prune
```

指定输出格式：

```
docker image ls --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"
```

### 打标签

```
docker tag IMAGE[:TAG] [REGISTRY_HOST[:REGISTRY_PORT]/]REPOSITORY[:TAG]
```


## 容器

删除所有容器：

```zsh
sudo docker rm $(sudo docker ps -aq)
```

查看容器的日志输出：

```
docker logs [container_id]
```

使用 `-d` 参数让容器在后台运行

### 进入容器

在 attach 中推出会导致容器推出，exec 不会。

```
docker attach
```

```
docker exec
```

### 导入导出容器

```
docker export
```

```
docker import
```

## docker 系统

查看基本的 docker 系统信息：

```
sudo docker system info
```

## 数据卷

- 数据卷可在多个容器间共享
- 数据卷的修改马上生效
- 数据卷的更改不影响镜像
- 数据卷默认会一直存在，即使容器已被删除

```sh
docker volume
```

删除容器同时删除数据卷：

```sh
docker rm -v [container_id]
```

清除无主的数据卷：

```sh
docker volume prune
```

使用 `--mount` 或 `-v` 挂载数据卷，将主机的 `/src/webapp` 映射为容器的 `/opt/webapp`：

```sh
docker run -d \
    --name web \
    # -v /src/webapp:/opt/webapp \
    --mount type=bind,source=/src/webapp,target=/opt/webapp \
    training/webapp \
    python app.py
```

挂载只读数据卷：`--mount type=bind,source=/src/webapp,target=/opt/webapp,readonly`，如果在容器中向 `/opt/webapp` 写数据，则会出错。

挂载的数据卷不一定要是文件夹，也可以是文件，`--mount type=bind,source=$HOME/.bash_history,target=/root/.bash_history`。

## 网络

使用 `-P` 或者 `ip::containerPort` 进行随机端口映射。

`-p` 进行指定端口的映射：

- `-p 5000:5000`
- `-p 127.0.0.1:5000:5000`
- `-p 127.0.0.1::5000`
- `-p 127.0.0.1:5000:5000/tcp`

`-p` 标记可以多次使用，进行多个端口的映射。

查看端口映射信息：

```sh
docker port CONTAINER [PRIVATE_PORT[/PROTO]]
```

使用 `--dns 8.8.8.8` 是指定容器使用的 DNS。

可以在 `/etc/docker/deamon.json` 中添加关于 DNS 的内容，指定所有容器所使用的 DNS 配置：

```json
{
  "dns" : [
    "114.114.114.114",
    "8.8.8.8"
  ]
}
```


## 查看相关信息

```sh
docker inspect [container|image|volume|...]
```

## compose

Compose 管理一组容器，方便地进行容器的生命周期管理。

因为 Compose 项目是由 Python 编写的，通过调 Docker API 完成容器的管理，所以 Compose 可以通过 pip 安装。

    