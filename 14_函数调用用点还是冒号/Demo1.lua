--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 20:50
-- To change this template use File | Settings | File Templates.
--
--看如下代码:
-- Person.SetInfo("小白",23);
-- Person:SetInfo("小白",23);
-- 一个用点，一个用冒号
Person = {
    name = "",
    age = 0,
}
function Person.SetInfo(name, age)
    Person.name = name;
    Person.age = age;
end

print("=======================第一种赋值方式======================");
Person.SetInfo("小白", 23);
print("Person的信息是" .. Person.name, Person.age);

print("=======================第二种赋值方式======================");
local person = Person;
--Person=nil;
person.SetInfo("小白", 23);
--第二种赋值方式不对,因为偷偷的把Person置为空了。所以我们就会想，把person传进来就行了。所以有：

function Person.SetInfo(self, name, age)
    self.name = name;
    self.age = age;
end

local person1 = Person;
--Person = nil;
person1.SetInfo(person1, "小白", 24);
print("Person的信息是:" .. person1.name .. "\t,年龄:" .. person1.age);
--这样就可以赋值成功了，但是每次都要多传一个person1参数，这样比较烦，所以，Lua提供了一个新的使用方式，那就是冒号定义和调用函数。
print("=======================第三种赋值方式======================");
function Person:SetInfo(name, age)
    self.name = name;
    self.age = age;
end
local person2=Person;
Person=nil;
person2:SetInfo("小白",20);
print("Person的信息是:" .. person2.name .. "\t,年龄:" .. person2.age);
--冒号定义了函数，冒号调用了函数，冒号的作用就是：定义函数时，给函数的添加隐藏的第一个参数self；调用函数时，默认把当前调用者作为第一个参数传递进去。self其实就和我们Java的this一样

