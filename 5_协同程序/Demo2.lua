--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 13:24
-- To change this template use File | Settings | File Templates.
--
--coroutine(协同程序resume-yield间的数据返回)
--### resume的参数
-- resume函数除了第一个参数是协同程序外，还能继续传其他参数，如:
print("=======================resume的参数======================");
local go = coroutine.create(function(name,age)
    print("我的协程名字是:" .. name..",\t年龄:"..age);
end);
coroutine.resume(go,"哈哈",23);
--resume的第二个返回值
--之前我们说resume第一个值代表协同程序是否正常执行，第二个返回值自然是代表错误信息。
--没错，但是这里还有一点就是:
-- yield函数的参数可以传递到resume的第二个返回值里,如:
local go1=coroutine.create(function(name,age)
    print("我的协程名字是:" .. name..",\t年龄:"..age);
    coroutine.yield("我可以是resume的第二个返回值");
end);
local result,msg=coroutine.resume(go1,"呵呵",20);
print("msg:"..msg);
--加了一句yield的调用，同时yield函数我们传递了一个参数进去。
--而这个参数将作为resume的第二个返回值，前提是，resume函数的第一个返回值是true。
print("=======================yield的返回值======================");
--## yield的返回值
local go2=coroutine.create(function(name)
    for i=1,2,1 do
        print("我的协程名字是:" .. name);
        print("go2:"..coroutine.yield("挂起参数"));
    end
end);
for i=1,2,1 do--逐渐从1增加for的循环次数,看输出结果
    print("=============第"..i.."次执行");
    local result,msg=coroutine.resume(go2,"resume参数");
    print("msg:"..msg);
end
--第一次执行的时候，协同程序第一次被挂起，所以yield的返回要等待第二次resume被调用时才能得到。
--于是，第二次调用resume时，首先就得到了上一次yield的返回值了，这个返回值正是resume的第二个参数。
--### 简单的得出结论:resume的返回值是yield的参数，yield的返回值是resume的参数。
--### 同时，resume的第二个参数也能传递给协同程序的函数。
print("=======================协同程序结束后，主函数的返回值=================");
local go3=coroutine.create(function(name)
    for i=1,2,1 do
        print("协同的名字:"..name);
        print("go3:"..coroutine.yield("yield参数"));
    end
    return "协同程序执行结束!";
end);
for i=1,3,1 do
    print("=====第"..i.."次执行======");
    local result,msg=coroutine.resume(go3,"resume参数");
    print("msg:"..msg);
end
--第三次执行的时候特殊:这里是不会继续执行 print("协同的名字:"..name);这句代码的，
-- 也就是说，整个协同程序函数的for循环是不会被执行的。
--最后，协同程序函数返回一个字符串，这个字符串做成为resume函数的第二个返回值。
--当协同程序执行完毕时，resume的第二个返回值就不再是yield的参数了。

