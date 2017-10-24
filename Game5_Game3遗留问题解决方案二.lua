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

-- 方法2：使用局部变量保存_G
local _G = _G;

setfenv(1, M);

function play()
    _G.print("游戏开始...");
end

function quit()
    _G.print("游戏结束...");
end

return M;
--这种方法的缺点比较明显，那就是，每次调用print等函数时，都要使用_G前缀。