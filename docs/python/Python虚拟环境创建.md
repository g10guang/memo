# Python 虚拟环境创建

## 尝试一

```bash
➜  test git:(master) ✗ python -m venv env
Error: Command '['/home/g10guang/Public/test/env/bin/python', '-Im', 'ensurepip', '--upgrade', '--default-pip']' returned non-zero exit status 1.
```

## 尝试二

按照[文档](https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda/)，采用 conda 的方式创建虚拟环境：

```bash
➜  test git:(master) ✗ conda create -n note
```

因为 conda 的源是国外的，如果没有翻墙，有可能会造成某些 HTTP 连接超时等问题。

问题如上，**使用 Anaconda 创建虚拟环境失败。**

## 解决方案

```bash
pyvenv --without-pip my_venv_dir
source my_venv_dir/bin/activate
curl https://bootstrap.pypa.io/get-pip.py | python
deactivate
source my_venv_dir/bin/activate
```

创建虚拟环境时指定不带 pip，然后再重新下载 pip 到本地重新安装。
