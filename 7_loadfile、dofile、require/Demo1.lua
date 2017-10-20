--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 14:43
-- To change this template use File | Settings | File Templates.
--
--loadfile、dofile、require初探
--## loadfile：只编译，不运行

local path="D:/LuaExample/LuaLearn/Test.lua";

function TestLoadfile()
    loadfile(path);
    print("end");
end
print("======================测试loadfile=================");
TestLoadfile();

print("======================测试dofile=================");
--dofile 加载并且执行.lua文件的代码;
function TestDofile()
    dofile(path);
    print("end");
end
TestDofile();
print("======================测试require=================");
--require和dofile有点像，不过又很不一样，
-- require在第一次加载文件的时候，会执行里面的代码。
--但是，第二次之后，再次加载文件，则不会重复执行了,如
for i = 1, 2, 1 do
    require("Test");
end
print("end");