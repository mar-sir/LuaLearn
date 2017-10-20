--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 15:04
-- To change this template use File | Settings | File Templates.
--### 元方法
--元方法:各自类型变量之间进行特殊操作的函数,方法。
--比如，数字的相加，它可能仅仅是一个函数。
--比如：1+1  ，在底层里，它可能是这样的：add(1, 1)。
-- 而add函数就是用来计算两个数字间相加的结果。
--再如：10X15，它可能是这样的：mul(10, 15)。mul函数就能返回两个数字
-- 相乘的结果。
--（可能这例子不太恰当，但就是这么个意思~）
--最后，如果是两个table呢？
--local t1 = {};
--local t2 = {};
--t1 + t2;
--它可能就是这样的：？？？？
--没错，Lua中不存在可以计算两个table相加的函数，也就是说，不存在这样的元方法。
--## 元表
--元表本身并没有什么作用，它是用来存放元方法的一个table.如
local yuanbiao = {};
yuanbiao.__yuanfangfa = function()
    print("哈哈，我是一个元方法");
end
--那我们如何能让两个表可以相加呢：如:
--创建一个元表

local mt = {};
mt.__add = function(t1, t2)
    print("两表相加的元方法");
end
mt.__mul = function(t1, t2)
    print("两表相乘的元方法");
end

local t1 = {};
local t2 = {};
-- 给两个table设置新的表
setmetatable(t1, mt);
setmetatable(t2, mt);
--两表相加
local go = t1 +t2;
local go1=t1*t2;
--首先创建了一个table变量mt，给这个table新增一个元素__add，
-- 这个table就拥有了作为元表的资格了。
--然后创建两个新的table变量，使用setmetatable函数给table设置新的元表，
-- 此时，两个table变量就以mt作为元表了。最后，对t1和t2进行加法操作，
-- 这时就会从元表中查找__add元方法，如果找到的话，就调用这个元方法对
-- 两个变量进行加法操作。

--### 注意:
-- 创建一个新的table变量时，它是不存在元表的（可以用getmetatable函数获取某个对象的元表，
-- 就能知道这个对象有没有元表存在了）
-- 在Lua中，只能设置table的元表，其他类型的值的元表，只能通过C代码来完成