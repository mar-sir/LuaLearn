--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 11:58
-- To change this template use File | Settings | File Templates.
--
--## 异常捕获

function test()
    print(a[1]);
end

--异常捕获 pcall
if (pcall(test)) then
    print("正常,嘿嘿");
else
    print("报错!!!!!!!!!!!!!!");
end
-- pcall 还能还能返回报错信息
local status, err = pcall(test);
if (status) then
    print("正常,呵呵");
else
    print(err);
end

-- 断言 assert

--local name=io.read();
--local result=assert(name=="123","输入正确");

--主动报错 error
error("主动的我知道错了");