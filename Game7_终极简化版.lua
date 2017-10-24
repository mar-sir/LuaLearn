--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 20:42
-- To change this template use File | Settings | File Templates.
--

module(..., package.seeall);

function Play()
    print("游戏开始...");
end

function Quit()
    print("游戏结束...");
end
--注意，前面的几行代码都没了，只留下了一个module函数的调用。
--module函数的调用已经相当于调用了:
--==========================================================================
--local M = {};
--local modelName = ...;
--_G[modelName] = M;
--setmetatable(M, {__index = _G});
--setfenv(1, M);
--==========================================================================
--而package.seeall参数的作用就是让原来的_G依然生效，相当于调用了：
-- setmetatable(M, {__index = _G});
--再次留意一下，代码末尾的return M也不见了，因为module函数的存在，已经不需要
-- 我们主动去返回这个模块的table了