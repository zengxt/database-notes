-- 数值函数
-- 1、四舍五入
select ROUND(45.943, 2) "小数点后两位", -- 45.94
       ROUND(45.943, 0) "个位",         -- 46
       ROUND(45.943) "个位",            -- 46
       ROUND(45.943, -1) "十位"         -- 50
from dual;


-- 2、取整函数
select CEIL(45.143) from dual;        -- 向上取整 46
select FLOOR(45.943) from dual;       -- 向下取整 45


-- 3、常用计算
-- abs 取绝对值
select ABS(45.143) from dual;          -- 45.143
select ABS(-45.143) from dual;         -- 45.143
select ABS(0) from dual;               -- 0

-- 求余
select MOD(5, 2) from dual;            -- 1
select MOD(5, null) from dual;         -- null

-- 求幂
select POWER(2, 3), POWER(null, 3) from dual; -- 8 null

-- 求平方根
select SQRT(16) from dual;         -- 4

-- 截断
select TRUNC(45.943, 2) "小数点后两位",       -- 45.94
       TRUNC(45.943, 0) "个位",               -- 45
       TRUNC(45.943) "个位",                  -- 45
       TRUNC(45.943, -1) "十位"               -- 40
from dual;


-- 4、三角函数
select SIN(3.14) from dual;

