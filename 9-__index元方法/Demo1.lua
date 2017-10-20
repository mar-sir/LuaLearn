--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 16:15
-- To change this template use File | Settings | File Templates.
--
--## __index 当访问的某些属性不存在时，我们希望做一些自定义操作，于是乎，就
--用到了__index这个元方法。__index的触发调用是在正主不在的情况下才触发的。
print("============没有__index元方法的情况");
local t = {};
print(t.name); --nil，t根本就没有name属性，所以理应输出nil;
--但我们又想要做一些其他坏坏的操作，那就用__index
print("============引入__index元方法的情况");
local mt = {
    __index = function()
        print("你要访问的东西不存在，所以出发了我的调用");
    end
}
setmetatable(t, mt);
print(t.name); --nil,依然是空
--想让name不为空,简单啊，如:

local mt1 = {
    __index = { name = "小花" };
}
setmetatable(t, mt1);
print("终于访问到name了，虽然不是我的:" .. t.name);
print("\n============引入__index元方法模拟继承");

local baseClass = {
    name = "基类",
    age = 20,
    sex = "未知",
    ToString = function()
        print("基类输出ToString()方法");
    end
}
local t1={};
--定义元方法
local mt2={
    __index=baseClass;
}
setmetatable(t1,mt2);
print(t1.name);
t1.ToString();
--有点像继承的样子