--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/19
-- Time: 19:26
-- To change this template use File | Settings | File Templates.
--

--lua方法创建

function Method1()
    print("hello word:".."  我是方法一");
    print("==============================华丽分割线========================");
end

Method1();

function Method2(name,age)
    print("我是:"..name);
    print("我的年龄是:"..age);
    print("==============================华丽分割线========================");
end

Method2("小白",18);
Method1("小白"); --lua参数可变，可多，可少，少了的用nil（空）代替
Method2("小白",18,23,43);

print("lua多返回值");
--返回两个值
function Method3(name,age)
    return name,age;
end

local name=Method3("姓名","年龄");
print("返回值1:"..name);

local name,age,hehe=Method3("姓名","年龄");
--local name,age,hehe=Method3("姓名","年龄");
--对于多出的变量，会赋予nil值，虽然这不会造成编译错误，但是也可能会造成运行时错误。
print("返回值1:"..name.."\t返回值2:"..age);
--print("返回值1:"..name.."\t返回值2:"..age.."\t返回值3:"..hehe);

--多重返回值的重点
--1.多值返回的方法必须是表达式的最后一个元素才能返回多值，否则返回一个
--2.强制返回一个值的写法

--多重返回值的特点1——必须是表达式的最后一个元素,例如
local a,b,c="first",Method3("小白",23);
print("返回值1:"..a.."\t返回值2:"..b.."\t返回值3:"..c);

--但是，换个顺序,此时方法3返回的值只会有一个，c值将为空所以说多重返回值的特点1——必须是表达式的最后一个元素
local a,b,c=Method3("小白",23),"first";
print("返回值1:"..a.."\t返回值2:"..b);
--print("返回值1:"..a.."\t返回值2:"..b.."\t返回值3:"..c);
--强制返回一个值,此时b的值为空
print("\n=====强制返回一个值,此时b的值为空=====");
local a,b=(Method3("小白"));
--print("返回值1:"..a.."\t返回值2:"..b);
print("返回值1:"..a);
print("\n=====lua具名参数(名字参数)=====");
--为解决方法参数过多，不容易记忆，例：

function Method4(args)
    return args.name,args.age;
end

local args={name="小白",age=23};
print("具名参数例子\t"..Method4(args));

