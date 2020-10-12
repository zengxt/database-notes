# Oracle中的系统函数

1、Oracle 中的函数必须有返回值；

2、单行函数：每次取一条记录，作为函数的参数，得到这条记录的单个结果；

3、多行函数（聚合函数）：一次性把多条记录作为函数参数，得到多条记录对应的单个结果

4、Oracle中的数据类型主要分为字符型、数值型和日期型，因此单行函数也主要有：字符函数、数值函数、日期函数、转换函数、其他函数。

<br/>

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

4、MONTHS_BETWEEN(date1, date2)：表示两个日期之间间隔的月份

```sql
-- months_between 计算两个日期相差多少个月
SELECT MONTHS_BETWEEN('13-10月-20', '24-5月-20') FROM dual;  -- 4.64516129032258
SELECT empno, SYSDATE, hiredate, (SYSDATE - hiredate) / 30, 
       months_between(SYSDATE, hiredate)
FROM emp;

-- 日期类型的数据可以使用算术运算符进行计算
-- 两个日期直接相减，得到相差的天数
SELECT TO_DATE('13-10月-20') - TO_DATE('24-5月-20') FROM dual; -- 142
SELECT empno, SYSDATE, Hiredate, round( (SYSDATE - hiredate) / 365, 0 ) FROM emp;
```

5、EXTRACT(date FROM datetime)：

```sql
-- 获取日期中指定的时间部分
SELECT EXTRACT(YEAR FROM SYSDATE) FROM dual; -- 2020
SELECT EXTRACT(MONTH FROM SYSDATE) FROM dual;
SELECT EXTRACT(DAY FROM SYSDATE) FROM dual;
-- 时间戳类型，一样可以获取
SELECT EXTRACT(HOUR FROM TIMESTAMP '2020-10-13 12:30:30') FROM dual;  -- 12
```

<br/>

# 四、转换函数

## 1、日期转换成字符

&emsp;&emsp;TO_CHAR(date [, fmt [, params]])：date：将要转换的日期，fmt：转换的格式，params：日期的语言，一般系统会有默认的语言，可省略。

&emsp;&emsp;时间的默认格式：DD-MON-RR（日-月-年）：均是两位，月份还有 '月' 字；

&emsp;&emsp;其他时间格式：

&emsp;&emsp;&emsp;&emsp;年份格式（YY YYYY YEAR，两位、四位与英文）；

&emsp;&emsp;&emsp;&emsp;月份格式（MM MONTH）;

&emsp;&emsp;&emsp;&emsp;日格式（DD DAY）；

&emsp;&emsp;&emsp;&emsp;小时格式（HH24、HH12）；

&emsp;&emsp;&emsp;&emsp;分钟格式（MI）；

&emsp;&emsp;&emsp;&emsp;秒格式（SS）。

```sql
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS') FROM dual;
SELECT SYSDATE, to_char( SYSDATE, 'YYYY-MM-DD HH24:MI:SS AM DAY' ) from dual;

-- 查询时间有关条件字段，正常需要这样查找
SELECT * FROM emp WHERE hiredate = '17-12月-1980';
-- 使用 to_char 函数
SELECT * FROM emp WHERE TO_CHAR( hiredate, 'YYYY-MM-DD' ) = '1980-12-17';
```

<br/>

## 2、字符转换成日期



<br/>

## 3、数字转换成字符



<br/>

## 4、字符转换成数字







