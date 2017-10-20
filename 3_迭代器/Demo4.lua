--
-- Created by IntelliJ IDEA.
-- User: caomin005
-- Date: 2017/10/20
-- Time: 11:29
-- To change this template use File | Settings | File Templates.
--
--迭代器扩展
print("=================迭代器扩展================");
--自定义迭代器扩展
function MyDieDaiQi(n)
    local i = 0;
    return function(s, var)
        i = i + 1;
        if (i > #n) then
            return nil;
        end
        return i, n[i];
    end, 10, 0
end

--至此我们依然依赖闭合函数来实现的迭代，但引入恒定状态和控制变量可以改变这一局面；
--非闭合函数迭代器，恒定状态和控制变量用处
function MyDieDaiQiGai(n)
    return function(s, var)
        var = var + 1; --变量
        if (var > #s) then
            return nil;
        end
        return var, s[var];
    end, n, 0;
end

--### 利用恒定状态创造更多变量
function MyDieDaiQi1(n)
    return function(s, var)
        var = var + 1;
        if (var > #s.list) then
            return nil;
        end
        s.money=s.money*s.money;
        print("呵呵，钱，对我来说，就是一个数字而已：" .. s.money);
        return var, s.list[var];
    end, { list = n, money = 10 }, 0;
end
local n={"啦啦","哈哈","呵呵","蛇经病",nil};
for k,v in MyDieDaiQi1(n) do
    print("k="..k.."\t,v="..v);
end
