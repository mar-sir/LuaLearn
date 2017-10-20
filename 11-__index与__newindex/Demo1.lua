--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 17:47
-- To change this template use File | Settings | File Templates.
--
--## rawget()此方法能屏蔽__index和__newindex的效果;
print("==========================rawget()方法的用途=========================");
local baseClass = {
    name = "none",
}
local t1 = {
    hehe = 123;
};
local mt = {
    __index = baseClass,
    __newindex = function(table, key, value)
        print("别赋值！");
    end
}
setmetatable(t1, mt);
print(rawget(t1, "name"));
print(rawget(t1, "hehe"));
rawset(t1, "name", "哈哈");
print(t1.name);
--通过rawget函数可以忽略元表的__index功效，纯粹地从t1中调用字段。
--rawget的第一个参数是要调用的table，第二个参数是table的字段名。
--因此，通过rawget调用t1的name字段，只能返回nil，而调用hehe字段，则能正确取得值。
--同样的是，rawset函数可以忽略元表的__newindex功效，纯粹地给t1赋值。