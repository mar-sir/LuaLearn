--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 18:05
-- To change this template use File | Settings | File Templates.
--
-- ###全局变量的原形
print("============================全局变量===========================");
-- 在lua中，申明全局变量，就是在定义变量的时候，前面不要加local。
--这个神秘的全局变量，其实本质上也是一个table，它把我们创建的全局
--变量都保存到一个table里了。
--而这个table的名字是：_G,例:

--定义一个全局变量
globalName="哈哈，我是全局变量";
print(globalName);
print(_G["globalName"]);
print(_G.globalName);
--由此可以说明一些问题;
--但我们都知道，全局变量尽量少用，所以lua有一种比较特殊的机制:非全局环境。
print("=======================setfenv函数改变函数的全局变量环境===========================");
--将当前全局环境重新设置为新的table
--setfenv(1,{});--先注释一下
--输出值
print(globalName);-- attempt to call global 'print' (a nil value) 报错
--这是因为我们已经把当前函数范围内的全局变量环境改变了，全局变量默认是保存在_G中
-- 的，而现在的全局变量是在一个新的table里。
--## setfenv参数
--1). 第一个参数，可以是即将要改变环境的函数，也可以是一个数字。
-- 数字1代表当前函数，数字2代表调用当前函数的函数，后面以此类推。
--2).第二个参数，新的全局环境table。
print("=======================保存原来的_G===========================");
--将当前全局环境重新设置为新的table
setfenv(1,{g=_G});
--输出值
g.print(globalName);--nil
-- 再次定义一个全局变量
globalName="哈哈，我是新定义的全局变量";
-- 再次输出值
g.print(globalName);
-- 输出原来的值
g.print(g.globalName);
--三次输出的结果都不一样


