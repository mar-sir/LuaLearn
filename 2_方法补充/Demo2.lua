--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 8:52
-- To change this template use File | Settings | File Templates.
--
--闭合函数，非全局函数和函数的尾调用
--### 闭合函数：一个函数加上该函数所需访问的所有”非局部的变量“例：
print("====================闭合函数=====================");
-- 闭合函数
function count()
    local i = 0;
    return function()
        i = i + 1;
        return i;
    end
end

--count函数会返回另外一个函数，而这个返回的函数会使用count函数的局部变量i;
local func = count();
print(func()); --1
print(func()); --2
print(func()); --3

local myfunc = count();
print(myfunc()); --1
-- local i就属于一个非局部变量，因为它既不是全局变量，也不是单纯的
-- 局部变量（因为另外一个函数可以反问到它）。count函数里的那个函数，
-- 加上非局部变量i，就构成了一个闭合函数了
--##### 对于闭合函数而已，属于它的非局部变量，并不是在调用它的时候临时产生的，
-- 而是和它一起存在的。所以每次调用闭合函数，非局部变量的值都不会被重置。
-- 修改一下count函数如下：

function count1()
    return function()
        local i = 99;
        i = i + 1;
        return i;
    end
end

local func1 = count1();
print(func1()); --100
print(func1()); --100
print(func1()); --100
--此时变量i完全属于局部变量,每次调用他的话，i都会被重新赋值;

print("====================非全局函数=====================");
-- ###非全局函数:需要注意函数之间定义的先后顺序;
-- 非全局函数：局部函数(就是定义的时候加了local修饰符),如:
local function method1()
end

--就是一个非全局函数，也可以这样写:
local method1;
method1 = function() end
--函数名称也就相当于一个变量名;

-- 测试
function Test1()
    print("全局函数的调用测试");
    return Test2();
end

function Test2()
    print("Test1() 先与Test2()定义，但仍然能调用到Test2(),全局函数调用和顺序没关系");
end

Test1();
print("我们来看看非全局函数的调用");
local function LocalTest4() --后写
    print("我是局部函数4,局部3想用我是不可能的");
end

local function LocalTest3()
    print("非全局函数调用测试");
    return LocalTest4();
end

local function LocalTest4() --先写
    print("我是局部函数4,局部3想用我是不可能的,");
end

LocalTest3(); --此时运行出错，因为LocalTest3调用的时候LocalTest4()还未定义，我们可以试着先定义LocalTest4;在运行LocalTest3();
--这样就没有问题.或者我们还可以这样写:

local localTest5;
local localTest6;

localTest5 = function()
    print("我是局部函数localTest5,我要调用局部函数localTest6");
    localTest6();
end

localTest6 = function()
    print("我是局部函数localTest6，虽然我后实现，但我之前就定义了，我可以被调用");
end
localTest5();
print("=======================尾调用=====================");
--###  尾调用:函数A调用函数B,此时如果函数B是函数A的最后一个作时，就属于尾调用；好复杂的说；
--举例：尾调用
function A()
    return count();
end

--count()为A调用的最后一个操作，所以属于尾调用
--举例：非尾调用
function B()
    return count() + 1;
end

-- B调用count()之后还要做+1操作，所以为非尾调用;
--那尾调用有啥意义？
print("尾调用的意义:");
--进行尾调用时不会耗费多余的栈空间，例：

function DiGui(n)
    if (n > 0) then
        return DiGui(n-1);
    else
        return "递归结束";
    end
end
print(DiGui(1000));--递归结束
--但是换一种写法，非尾调用的写法
function DiGui1(n)
    if (n > 0) then
        return DiGui1(n-1)+0;
    else
        return "递归结束";
    end
end
--print(DiGui1(1000));--stack overflow，栈溢出，好好想想也好理解;