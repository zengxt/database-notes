# 一、数值函数

## 1、四舍五入

ROUND(n [,m])

n：需要四舍五入的数

省略m：0

m > 0：小数点后m位

m < 0：小数点前m位

```sql
-- 四舍五入
select round(45.943, 2) "小数点后两位", -- 45.94
       round(45.943, 0) "个位",         -- 46
       round(45.943) "个位",            -- 46
       round(45.943, -1) "十位"         -- 50
from dual;
```

<br/>

## 2、取整函数

```sql
select ceil(45.143) from dual;        -- 向上取整 46
select floor(45.943) from dual;       -- 向下取整 45
```

<br/>

floor(n)：

## 3、常用计算

ABS：求绝对值

MOD(m, n)：m除以n的余数，如果m和n中有一个值为null，则结果返回null值。

POWER(m, n)：表示返回m的n次幂

SQRT(n)：求平方根

TRUNC(n [,m])：截断

```sql
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
```

<br/>

## 4、三角函数

SIN(n)、ASIN(N)、COS(n)、ACOS(n)、TAN(n)、ATAN(n)

<br/>



# 二、字符函数

## 1、大小写转化函数

UPPER(char)：转换为大写

LOWER(char)：转换为小写

INITCAP(char)：首字母大写

```sql
SELECT UPPER('assd'), LOWER('JHHSs'), INITCAP('asdd') FROM dual;  -- ASSD, jhhss, Asdd
SELECT ename, INITCAP(ename) FROM emp WHERE INITCAP(ename) = 'Smith';

SELECT * FROM emp WHERE LOWER(ename) = 'smith';
SELECT * FROM emp WHERE ename = UPPER('smith');
```

<br/>

## 2、获取子字符串函数

SUBSTR(char, [m [,n]])：

m：从哪个字符开始截取，为0时表示从首字母开始，若m为负数，表示从字符串的尾部开始截取。

n：子串的长度，n可以省略，当n省略时表示从m的位置截取到字符串末尾。

```sql
SELECT SUBSTR('abcde', 2, 3),         -- bcd
       SUBSTR('abcde', 2),            -- bcde
       SUBSTR('abcde', -2, 1)         -- d
FROM DUAL;

SELECT ename, SUBSTR(ename, 2, 2) FROM emp;
```

<br/>

## 3、获取字符串长度函数

```sql
-- 获取字符串长度
SELECT ename, LENGTH(ename) FROM emp;
```

<br/>

## 4、字符串连接函数





## 5、去除子串函数



## 6、替换函数





