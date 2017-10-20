--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 17:12
-- To change this template use File | Settings | File Templates.
--
-- __index元方法是用于处理调用table中不存在的字段
-- __newindex的运用场景:当想对table不存在的字段进行赋值的时候,我们想做一些额外的操作
-- ### __index用于查询,__newindex用于更新
print("========================普通情况下的赋值========================");
local baseClass={
    name="基类",
    id=12321323,
    ToString=function ()
      print("基类输出toString()");
    end
}
--定义元表操作
local mt={__index=baseClass; }
local t1={};
setmetatable(t1,mt);
t1.ToString=function()
    print("重新赋值之后的toString()");
end
t1.ToString();--重新赋值之后的toString()
--我们发现赋值居然成功了。讲道理也应该能成功;
print("========================监控赋值========================");
--此时重新定义一个元表
local t2={};
local mt1={
    __index=baseClass,
    __newindex=function(table,key,value)
        print(key.."字段虽然能被访问到，但最开始的table里面并没有该"..key);
    end
}
setmetatable(t2,mt1);
t2.ToString=function()
    print("重新赋值之后的toString()");
end
t2.ToString();
--ToString字段赋值失败，因为给ToString字段赋值的时候，
-- 调用了__newindex元方法，代替了赋值操作。
-- ###注:
--这里有一个地方要注意的，t2中确实是不存在ToString字段的，
-- 它只是因为有元表存在，而元表里的__index元方法的值是baseClass这个table。
--从而，可以在t2找不到ToString字段的时候，去baseClass中寻找。
--但，实际上，t2确实是不存在ToString字段的,因此，当试图给t2的ToString字段赋值
-- 时，Lua判定ToString字段是不存在的，所以会去调用元表里的__newindex元方法。
--__newindex元方法被调用的时候会传入3个参数：table本身、字段名、想要赋予的值
print("====================__newindex通过一个table给另一个table的字段赋值======");
local otherBaseClass={
    name="另一个基类的名字"
}

local mt2={
    __index=baseClass,
    __newindex=otherBaseClass;
}

local t3={}
setmetatable(t3,mt2);
print("otherBaseClass的名字，赋值前：" .. otherBaseClass.name);
t3.name = "喝喝";
print("otherBaseClass的名字，赋值后：" .. otherBaseClass.name);
print("t3的名字：" .. t3.name);
--## 总结
--a.如果__newindex是一个函数，则在给table不存在的字段赋值时，会调用这个函数。
--b.如果__newindex是一个table，则在给table不存在的字段赋值时，会直接给__newindex的table赋值。