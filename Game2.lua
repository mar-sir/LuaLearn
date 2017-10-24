--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 20:24
-- To change this template use File | Settings | File Templates.
--
--实际上，我们可以更加得偷懒，以后修改模块名，
-- 只需要修改模块的文件名就可以了，文件内容可以不管，具体怎么实现:s
local M={};
local modelName=...;
_G[modelName]=M;
function M.Play()
    print("游戏开始...");
end

function M.Quit()
    print("游戏结束...");
end

return M;

