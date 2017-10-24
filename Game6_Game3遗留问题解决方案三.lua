--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 20:39
-- To change this template use File | Settings | File Templates.
--
local M = {};

local modelName = ...;
_G[modelName] = M;

-- 方法3：保存需要使用到的模块
local print = print;

setfenv(1, M);

function Play()
    print("那么，开始吧");
end

function Quit()
    print("你走吧，我保证你不会出事的，呵，呵呵");
end

return M;
--这种方法的缺点更明显了，所有用到的模块都要用局部变量声明一次
--但，就速度而言，第三种方案比第二种方案快，第二种方法又比第一种快。

