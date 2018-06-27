# Makefile

[http://wiki.ubuntu.org.cn/跟我一起写Makefile](http://wiki.ubuntu.org.cn/跟我一起写Makefile)

Unix:

| Windows | Unix | 作用 |
| ------ | ------ | ----- |
| .obj | .o | 编译后生成的目标文件，一个源文件对应一个目标文件 |
| .dll | .so | 动态链接库，运行时包含 |
| .lib | .a | 静态链接库，链接生成可执行程序时包含 |

头文件中应该只出现声明，头文件有可能被多个源文件 include，cpp 中声明可以进行多次，但是定义只能够出现一次。

C/C++ 的寻址方式不完全一样，`extern "C"`。

正是由于由链接这一步存在，才可以分开编译多个源文件，需要生成可执行程序的时候才进行链接合并，所以在修改某个文件后，只需要重新编译修改过的文件即可。

create dependency auto 

```makefile
%.d: %.c
	@set -e; rm -f $@; \
         $(CC) -M $(CPPFLAGS) $< > $@.$$$$; \
         sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
         rm -f $@.$$$$

sources = foo.c bar.c
<!-- replace .c to .d. eg: foo.c ==> foo.d -->
include $(sources:.c=.d)
```

If we place a - before a command, it means no matter the presuccess command execute successfully or not, execute this command any way.

comment #

Makefile will print the command it executes default.

@command to hide the info.

```makefile
@echo This message will show
```

If we want to make last command make an effect of the next command, we combine them together just like below.

Example 1: don't work:

```makefile
exec:
    cd /home/g10guang
    pwd
```

Example 2: work:

```makefile
exec:
    cd /home/g10guang; pwd
```

Make will check every command return code. If the code is not 0, make will stop. Use `-` before the command to execute to n matter what return code of previous commands.

```makefile
clean:
    -rm -f *.o
```

In a big project, write how to compile the project is to complicate. 
So most of time, we will create a Makefile in every subdir to declare how to compile the file of this directory.

Declare the next Makefile can access the variable or not.

```makefile
export <variable ...>;

unexport <variable ...>;
```

export statement follow with nothing means export all variable.

```makefile
export
```

Variable in Makefile is just like the macro of C. Variable is the text and it will be replace just as the macro.
The magic thing is we can use the variable which we define after.

Two way to define a variable in Makefile:

1. foo = bar
2. foo := bar

The second way is better, because it tells can not use variables which declare after foo.

Run a command and get the return string:

```makefile
cur-dir := $(shell pwd)
whoami := $(shell whoami)
host-type := $(shell arch)
```

If FOO has been defined, do nothing. Else set FOO = bar.

```makefile
FOO ?= bar
```

Use define keyword to declare a multi-line variable.

```makefile
define two-lines
echo foo
echo $(bar)
endef
```

```makefile
ifeq ($(CC),gcc)
    $(CC) -o foo $(objects) $(libs_for_gcc)
else
    $(CC) -o foo $(objects) $(normal_libs)
```

```makefile

ifdef foo
    bar = defined
else
    bar = undefined
endif
```

```makefile
ifndef foo
    bar = undefined
else
    bar = defined
endif
```

- $<: dependency file
- $@: target file

