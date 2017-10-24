--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 20:27
-- To change this template use File | Settings | File Templates.
--

--## 利用非全局环境制作更简洁和安全的模块
local M = {};

local modelName = ...;
_G[modelName] = M;

setfenv(1, M);

function Play()
    print("游戏开始...");
end

function Quit()
    print("游戏结束...");
end

return M;
--我们把Game3.lua这个模块里的全局环境设置为M，于是，我们直接定义函数的时候，
-- 不需要再带M前缀。
--因为此时的全局环境就是M，不带前缀去定义变量，就是全局变量，这时的全局变量
-- 是保存在M里。所以，实际上，Play和Quit函数仍然是在M这个table里。
--于是，我们连前缀都不用写了，另外，由于当前的全局环境是M，所以， 在这里不需
--要担心重新定义了已存在的函数名，因为外部的全局变量与这里无关了。
--当然，如果大家现在就运行代码，肯定会报错了。
--因为我们的全局环境改变了，所以print函数也找不到了。
--为了解决这个问题，我们看看Game4.lua