--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 14:17
-- To change this template use File | Settings | File Templates.
--
--table.concat连接字符串
--次处主要说明concat的高效
print("=======================table.concat连接字符串=======================");
--Lua获取系统时间
local startTime=os.clock();
for i=1,99999999,1 do
end
local endTime=os.clock();
print("运行for循环消耗的时间:"..endTime-startTime.."s");
print("====================Lua中连接大量字符串==================");
local strs={};
for i=1,30000,1 do
    strs[i]="helloWorld";
end
local result="";
local startTime=os.clock();
for index,str in pairs(strs) do
    result=result..str;
end
local endTime=os.clock();
local usedTime=endTime-startTime;
print("连接字符串所消耗的时间:"..usedTime.."s");

print("====================table.concat快速连接大量字符串==================");
local strs={};
for i=1,30000,1 do
    strs[i]="helloWorld";
end
local result="";
local startTime=os.clock();
result=table.concat(strs);
local endTime=os.clock();
local usedTime=endTime-startTime;
print("连接字符串所消耗的时间:"..usedTime.."s".."呵呵，什么叫效率");
--Lua的字符串和Java的字符串差不多，都是不可变的,比如刚刚的result字符串，每一次进行
-- 连接操作之后，其实就产生了新的字符串，不再是原来的那个了。于是，不断连接，就不
-- 断产生新的字符串，产生新字符串是需要复制操作，随着连接操作的不断进行着，字符串
-- 越来越大，复制操作也就越来越耗时。