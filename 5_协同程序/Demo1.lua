--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 12:38
-- To change this template use File | Settings | File Templates.
--
--协同程序 coroutine
print("====================协同程序=================");
-- 协同程序：一个协同程序在运行的时候，其他协同程序是无法获得执行的机会的。
--           只有正在运行的协同程序主动挂起时，其他协同程序才有机会执行。
--线程: 即使不主动休眠，也很有可能因为CPU轮片时间到达而把执行机会让给其他线程。
--#### 协同程序的创建

local go = coroutine.create(function() print("hello coroutine!!") end);
--因为协同被创建之后默认是挂起状态，所以此时它是不会自己运行的;
--协同的四种状态:挂起状态(suspended);运行状态(running);死亡状态(dead);正常状态(normal)
--让协同运行起来:
coroutine.resume(go);
-- 继续
function func()
    for i = 0, 6, 1 + 2 do
        print("呵呵" .. i);
    end
end

local go1 = coroutine.create(func);
coroutine.resume(go1);

--让协同程序挂起
print("====================协同程序挂起=================");
local go2 = coroutine.create(function()
    for i = 0, 6, 1 + 2 do
        print("呵呵" .. i);
        coroutine.yield(); --协同挂起
    end
end);
coroutine.resume(go2);
print(coroutine.status(go2) .. "（挂起）");
coroutine.resume(go2);
print(coroutine.status(go2) .. "（挂起）");
coroutine.resume(go2);
print(coroutine.status(go2) .. "（挂起）");
coroutine.resume(go2);
print(coroutine.status(go2) .. "（死亡）");

print("====================协同程序状态详解=================");
local go3 = coroutine.create(function()
    for i = 0, 6, 1 + 2 do
        print("呵呵" .. i);
        coroutine.yield(); --协同挂起
        print("一次循环结束");
    end
    print("协同程序结束");
end);
coroutine.resume(go3);
print(coroutine.status(go3) .. "挂起");
coroutine.resume(go3);
print(coroutine.status(go3) .. "挂起");
coroutine.resume(go3);
print(coroutine.status(go3) .. "挂起");
coroutine.resume(go3);
print(coroutine.status(go3) .. "死亡");
--细细看输出结果:
--在协同程序里调用yield函数时，会被挂起，而yield函数的返回要等下一次调用
-- resume函数时才能得到所以，yield函数下面的print语句在下一次的resume调用
-- 时才被执行。又所以，当for循环第3次执行时，协同程序被挂起，需要等待再一
-- 次resume时，for循环才能真正执行完毕。
print("====================resume操作的返回值=================");
local go4 = coroutine.create(function()
    for i = 1, 2, 1 do
        coroutine.yield();
    end
end);
local result, msg = coroutine.resume(go4);
print(result);
print(msg);
-- resume返回两个值，第一个值代表协同程序是否正常执行，
-- 第二个返回值自然是代表错误信息。
local go5 = coroutine.create(function()
    error("哈哈，大傻逼，我要你去死...");
end);
local result, msg = coroutine.resume(go5);
print(result);
print(msg);