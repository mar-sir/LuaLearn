--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 15:32
-- To change this template use File | Settings | File Templates.
--
--算术类元方法
--元方法名
--lua规定好的算术类元方法名:
--__add；加法
--__sub：减法
--__mul：乘法
--__div：除法
--__unm：相反数
--__mod：取模
--__pow：乘幂
--只要在自定义元表的时候，给这些元方法名赋予新的函数就可以实现自定义操作了。如:

--创建一个元表
local mt = {};
mt.__add = function(t1, t2)
    local result = "";
    if t1.sex == "boy" and t2.sex == "girl" then
        result = "完美的家庭";
    elseif t1.sex == "girl" and t2.sex == "girl" then
        result = "哇哈哈";
    else
        result = "有病";
    end
    return result;
end

--运用
local t1={name="Hello",sex="boy"};
local t2={name="Nice",sex="girl"};
-- 给两个table设置新的元表
for k,v in pairs(t1) do
    print("k: "..k.."\t,v:"..v);
end
setmetatable(t1,mt);
setmetatable(t2,mt);
local result=t1+t2;
--local result=t1-t2;
print(result);
--### 元表知识点补充
-- 1.两个具有不同元表的值进行算术操作
--如果两个table或者两个进行相加操作的值，具有不同的元表的情况:
--a.如果第一个值有元表，就以这个元表为准
--b.否则，如果第二个值有元表，就用第二个值的元表
--c.如果两个值都没有元表，或者没有对于的元方法，那么，就会报错

--### 关系类的元方法
--除了加法减法这些算术类的操作之外，大于小于等这些关系类的操作也是
-- 有元方法的：
--__eq：等于
--__lt：小于
--__le：小于等于
--如果对两个具备不同元表的值进行这些比较操作，就会报错，
-- 一定要注意，这和加减法的规则不一样。（狗与猪不能比较，因为类型不同）

--### 保护元素
--setmetatable和getmetatable可以分别设置和获得元表。
--当你的元表不希望别人修改的时候,就给元表的__metatable赋值,如
--mt.__metatable ="我的元表不容修改";然后当有print(getmetatable(s1));
--setmetatable(s1, mt);则会输出提示.