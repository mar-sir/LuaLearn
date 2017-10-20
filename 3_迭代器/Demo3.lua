--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 10:01
-- To change this template use File | Settings | File Templates.
--
--迭代器与闭合函数
print("===================迭代器与闭合函数与for循环================");
--迭代器：就是遍历集合的一种方式,如lua中常用的pairs：
local n = { "小白", "哇哈哈" };
for k, v in pairs(n) do
    print("k=" .. k .. "\t,v=" .. v);
end
--k=1	,v=小白
--k=2	,v=哇哈哈
--自己写一个迭代器
function MyDieDaiQi(n)
    --闭合函数的运用
    local i = 0;
    return function()
        i = i + 1;
        return n[i];
    end
end

--运用自己写的迭代器
print("\n自己写的迭代器:");
local iter = MyDieDaiQi(n);
while true do
    local value = iter();
    --因为闭合函数的特点，i变量是会一直增加的，
    -- 所以每次调用iter函数，返回的都是下一个table元素。
    if (nil == value) then
        break;
    end
    print(value);
end
--简化迭代器
for value in MyDieDaiQi(n) do
    print("value:" .. value);
end
--此处for循环只会调用一次MyDieDaiQi函数，然后把它的返回值保存起来。
--此时用while写了好多行代码，而for就一行搞定，for循环和迭代器有什么勾当呢;
--之前手写的迭代器都只能返回value,而pairs同时能返回k,时候优化了：

function MyDieDaiQi2(n)
    local i = 0;
    return function()
        i = i + 1;
        if i > #n then
            --#n表示获取长度
            --此处,大家可以把if这个判断删了，再调用一次，看看问题所在
            --最原始的时候我也没写这个判断
            return nil;
        end
        return i, n[i]; --函数的多值返回，方便吧
    end
end

local n={"啦啦","哈哈","呵呵","蛇经病",nil};
for k,v in MyDieDaiQi2(n) do
    print("k="..k.."\t,value="..v);
end
-- for..in..do 背后偷偷做的事情; 最开始的while不是白写的,毕竟程序员那么懒;
print("\nfor..in..do 与while转换");
do
   -- local _f,_s,_var=MyDieDaiQi2(n);旧
   local _f=MyDieDaiQi2(n);--新
    while true do
    --local k,v=_f(_s,_var);旧
    local k,v=_f();--新
        _var=k;
        if _var==nil then
            break;
        end
        print("k="..k.."\t,value="..v);
    end
    --有点抽象
    --细细看MyDieDaiQi2返回值就一个
    --标注新的是简化版的，标注旧的是复杂版的
end
--for..in..do 就是用来简化迭代器的
-- ### 迭代器函数、恒定状态、控制变量初值
print("===================迭代器函数、恒定状态、控制变量初值================");
--看旧代码 local _f,_s,_var=MyDieDaiQi2(n);旧
--三个返回值分别代表迭代器函数(_f)、恒定状态(_s)、控制变量初值(_var);
--#### 迭代器函数:就是我们的MyDieDaiQi2返回的闭合函数;iter();
--#### 恒定状态:就是不变的状态变量，table的长度=>#n;
--#### 控制变量初值:就是改变的变量=>i;

--#### while代码的详细解析 local _f,_s,_var=MyDieDaiQi2(n);旧
--1.比如我们的MyDieDaiQi2函数，它只有一个返回值，就是那个闭合函数，所以，_s和_var都是nil。
--2.接着调用local k, v = _f(_s, _var); 这实际上就是调用了闭合函数，并且将恒定值和变量值都作为参数传递进去。
--3.Lua的函数是很自由的，即使_f函数本身没有参数，也可以传参数进去，不会影响什么，所以，两个nil值传进去了，没有任何事情发生，就像是直接调用_f()一样。
--4.再下一句代码：_var = k;  这是把闭合函数（_f）的第一个返回值保存起来，因为每次调用闭合函数（_f）返回值都是下一个迭代值，所以_var每次都是不一样的值。
--5.如果_var的值为nil，则停止循环，结束迭代。
--到此你知道MyDieDaiQi2()中if 删掉为什么会有问题了么;
--如果我们让MyDieDaiQi2函数返回恒定状态和控制变量初值，又是什么样的情况呢？

function MyDieDaiQi3(n)
    local i = 0;
    return function(s,var)
        i = i + 1;
        if i > #n then
            --#n表示获取长度
            --此处,大家可以把if这个判断删了，再调用一次，看看问题所在
            --最原始的时候我也没写这个判断
            return nil;
        end
        print("恒定值=" .. s .. ", 变量值=" .. var);
        return i, n[i]; --函数的多值返回，方便吧
    end,100,0;
end
print("三返回值迭代器:");
for k,v in MyDieDaiQi3(n) do
    print("k=" .. k .. ", v=" .. v);
end