# 《c++ primer》

wchar_t 宽字符型，2字节，可用于存储宽字符。

在不同位数的机器上、或者不同操作系统上，short、int、long表现有所不同，占用不同的内存长度。

C++支持两种初始化方式：

1. 复制初始化：`int ival = 1024;`
2. 直接初始化：`int ival(1024);`

尽可能减少程序的不确定性（未定义行为），在声明变量时，尽可能进行初始化操作。

在声明类变量时，如果没有显示地初始化变量，则会执行默认构造函数。

声明与定义不是一码事：

- 定义（define）：为变量分配存储空间，还可以为变量指定初始值。
- 声明（declare）：向程序声明变量的类型和名字，也就是声明后可以还未为变量分配存储空间。

C++中变量必须且只能定义一次。

C++中的作用域：

1. 方法 Function
2. 类
3. statement scope
4. 文件
5. 全局

文件方法外定义的变量：

1. 非const变量默认为extern
2. 如果const变量需要被其他文件访问，需要指定为extern

引用类型必须在声明时初始化，而且初始化只能通过别的对象实现：

```cpp
int ival = 1024;
int &refVal = ival; // ok
int &refVal2;   // error
int &refVal3 = 1024;    // error
```

非常引用类型只能够引用同类型的引用，错误代码：

```cpp
double val = 1;
int &refval = val;  // error
```

但是常引用可以引用不同类型：

```cpp
double val = 1;
const int *refval = val;    //ok，相当于执行了 int t = val; const int &refval = t;
```

枚举 enum 中不同的变量可以拥有相同的值，如果对他们进行 == 比较得到的最后结果也是相等的。

在对数据进行封装可以使用两种方法：

1. struct：从C中继承而来，在第一个访问控制符（private/public）前，默认为public。
2. class：在第一个访问控制符前，默认为private。

Any way，尽可能地显示声明，尽可能减少隐式。

头文件（header file）是进行接口等数据声明，具体实现在 .cpp .cc 等文件实现。

使用编译器可以实现分开多个文件进行编译，产生目标文件 .o，下次在修改了某个文件后，不需要重新编译整个项目，

## 标准库

- string：可变长的字符串
- vector：可变长的数组

