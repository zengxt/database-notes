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

CONCAT(char1, char2)

```sql
-- 拼接字符串
SELECT 'ab' || 'cd', CONCAT('ab', 'cd') FROM dual;
SELECT empno || ename, CONCAT(empno, ename) FROM emp;
```

<br/>

## 5、去除子串函数

TRIM(c2 FROM c1)：从字符串c1中去除c2，c2只能是单个字符

LTRIM(c1 [, c2])：从字符串c1头部去除c2，c2只能是单个字符，如果头部有多个c2，都去除

RTRIM(c1 [, c2])：从字符串c1尾部去除c2，c2只能是单个字符，如果尾部有多个c2，都去除

TRIM(c1)：TRIM中只有一个参数，去除c1首尾的空格，LTRIM和RTRIM类似。

```sql
-- 去除子字符
SELECT TRIM('a' FROM 'abcd') FROM dual;  -- bcd
SELECT LTRIM('ababaa', 'a') FROM dual;  -- babaa
SELECT LTRIM('aaababaa', 'a') FROM dual;  -- babaa
SELECT RTRIM('ababaa', 'a') FROM dual;  -- abab
```

<br/>

## 6、替换函数

REPLACE(char, s_string[, r_string])：char：要替换的字符串，s_string：要被替换的字符串中的字符，r_string：s_string替换成r_string，省略r_string用空格替换。

```sql
-- 替换函数
SELECT REPLACE('abscd', 'a', 'A') FROM dual;  -- Abscd
SELECT REPLACE('abscd', 'a') FROM dual;  -- bscd
-- 与trim函数的区别，replace函数可以同时操作多个字符
SELECT REPLACE('abscd', 'ab', 'A') FROM dual; -- Ascd
SELECT ename, REPLACE(ename, 'A', 'a') from emp;
```

<br/>



# 三、日期函数

## 1、系统时间

SYSDATE：获取系统时间

```sql
-- 系统时间
-- sysdate 返回系统当前时间，并且以年月日的形式显示
SELECT SYSDATE FROM dual;  -- 默认时间格式是 DD-MON-RR 日月年

-- 虽然时间显示的时候是年月日，但是实际使用的时候还是 日月年
SELECT * FROM emp WHERE hiredate = '17-12月-1980';
```

<br/>



## 2、日期操作

1、ADD_MONTHS(date, i)：返回在指定日期上添加的月份，i如果为小数，系统会自动截取整数并进行运算。如果i为负数，则将给定的时间减去相应的月数。

```sql
-- add_months 为某个日期加上指定的月数
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3), ADD_MONTHS(SYSDATE, -3) FROM dual;

SELECT empno, 
       hiredate "雇用日期", 
       (hiredate + 90) "粗略的转正日期", 
       ADD_MONTHS(hiredate, 3) "精确的转正日期"
FROM emp;
```

2、NEXT_DAY(date, char)：下周星期几

3、LAST_DAY(date)：指定日期当月的最后一天

```sql
-- next_day 从现在开始的下个指定日期
select sysdate "当前日期",
       next_day(sysdate, '星期一') 下周星期一,
       next_day(sysdate, '星期二') 下周星期二,
       next_day(sysdate, '星期三') 下周星期三,
       next_day(sysdate, '星期四') 下周星期四,
       next_day(sysdate, '星期五') 下周星期五,
       next_day(sysdate, '星期六') 下周星期六,
       next_day(sysdate, '星期日') 下周星期日
from dual;

-- last_day 指定日期当月的最后一天
select ename, hiredate, last_day(hiredate) from emp;
```









<br/>

# 四、转换函数









