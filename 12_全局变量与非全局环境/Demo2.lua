--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 19:58
-- To change this template use File | Settings | File Templates.
--
print("=======================用__index保存原来的_G=====================");
gName="哎呦，很挫哦";
--一个新table,即将成为新的环境
local newG={};
setmetatable(newG,{__index=_G});
--将当前全局环境重新设置为新的table
setfenv(1,newG);
gName="咦，此时肚子疼！！";
print(gName);
print(_G.gName);
--我们给新的table设置一个元表，这个元表的__index元方法就是_G。
--于是，当新的环境里找不到print字段时，就会去_G里寻找。