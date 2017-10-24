--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/23
-- Time: 9:17
-- To change this template use File | Settings | File Templates.
--
--Lua中类的写法
Person ={
    name=0,
    age=0,
}
function Person:SetInfo(name,age)
    self.name=name;
    self.age=age;
end
function Person:ShowInfo()
    print("姓名:"..self.name.."\t名字:"..self.age);
end
--构造
function Person:new()
    local p={};
    setmetatable(p,{__index=self});
    return p;
end
--new函数函数里创建了一个新的table，并且给新的table设置一个元表，这个元表的__index元方法就是Person本身，最后返回这个新的table。相当于构造函数了。
--于是，所有通过new生成的新table，都可以使用Person的函数和各个字段属性（因为__index的值是Person）。
local person1=Person:new();
local person2=Person:new();
person1:SetInfo("人物一",20);
person2:SetInfo("人物二",22);
person1:ShowInfo();
person2:ShowInfo();
--但是我们会觉得奇怪，因为__index的元方法指的都是Person，那为什么这里能生成两个不同的person实例,原因：
--1). 当person1里不存在SetInfo()时，回去__index元方法里查找，于是，会找到Person的SetInfo()函数
--2). 在SetInfo()函数里，使用了self.name = name，此时的self就是person1，person1中是不存在name字段的，所以，如果我们要打印self.name的值，则其实是打印了Person的name值
--3). 但是，注意，但是来了。__index元方法是用于调用的，而不是用于赋值的，因此，self.name = name这句话，其实只是给person1这个table的name字段赋值了，person1本身不存在name字段，此时给它赋值了，于是person1存在了name字段，以后person1都不会再去Person里查找name字段了。
--4). 因此，对person1和person2的name、age字段进行赋值操作时，是完全不会影响到Person的。
print("====================减少内存开销的构造函数写法=================");
function Person:new1()
    o={};
    setmetatable(o,self);
    self.__index=self;
    return o;
end
--1). 调用new1函数时，self其实就是Person本身，这里完全可以用Person代替，不过，为了给以后做铺垫，这里还是使用self吧。
--2). self.__index = self，不要被这句代码吓到了，其实还是那么一回事，设置元表的__index元方法，这里就 相当于Person.__index = Person。
--3). Person自己作为__index的值没问题么？确实没问题，Person也是一个table，table可以作为元表，元表可以有__index元方法。
print("============================继承================================");
BaseClass={
    x=0,
    y=0,
}
function BaseClass:SetInfo(x,y)
    self.x=x;
    self.y=y;
end
function BaseClass:new()
    o={};
    setmetatable(o,self);
    self.__index=self;
    return o;
end
local parent=BaseClass:new();
function parent:SetInfo(x,y)
    print("我是parent。。。。。。。");
end
parent:SetInfo(12,32);
--BaseClass仍然没变，但是，我们看看parent，按之前的理解，它是Person的一个对象。
--只是，“对象”这称呼是我们自己定的，实际上它还是一个table而已。
--此时，我们修改了parent的SetInfo函数，于是，调用parent的SetInfo函数时，与BaseClass无关了。重重点来了：

local child=parent:new();
child:SetInfo(10,20);
print("child的信息:x="..child.x.."\ty=:"..child.y);
--我们再次调用parent的new函数创建了一个新对象。
--new函数是由parent调用的，因此，self就是parent。
--于是新对象的元表就是parent，元表的__index也是parent。
--因此,调用child的setInfo函数的时候，其实也是调用了parent的SetInfo函数。
--于是，child就是是parent的对象，而parent就是BaseClass的子类。
