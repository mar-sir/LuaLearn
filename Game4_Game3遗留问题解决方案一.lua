--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 20:33
-- To change this template use File | Settings | File Templates.
--
local M = {};

local modelName = ...;
_G[modelName] = M;

-- 方法1：使用继承
setmetatable(M, {__index = _G});

setfenv(1, M);

function Play()
    print("游戏开始...");
end

function Quit()
    print("游戏结束!!!!!");
end

return M;

--使用__index元方法就能解决这个问题了，
-- 当找不到print等函数时，就会去原来的_G里查找。