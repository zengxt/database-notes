-- 日期函数
-- 系统时间
-- sysdate 返回系统当前时间，并且以年月日的形式显示
SELECT SYSDATE FROM dual;  -- 默认格式时间上是 DD-MON-RR 日月年

-- 虽然时间显示的时候是年月日，但是实际使用的时候还是 日月年
SELECT * FROM emp WHERE hiredate = '17-12月-1980';


-- 日期操作
-- add_months 为某个日期加上指定的月数
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3), ADD_MONTHS(SYSDATE, -3) FROM dual;

SELECT empno, 
       hiredate "雇用日期", 
       (hiredate + 90) "粗略的转正日期", 
       ADD_MONTHS(hiredate, 3) "精确的转正日期"
FROM emp;


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


-- months_between 计算两个日期相差多少个月
select empno, sysdate, hiredate, (sysdate - hiredate) / 30, months_between(sysdate, hiredate)
from emp;


-- 日期类型的数据可以使用算术运算符进行计算
select empno, SYSDATE, Hiredate, round( (sysdate - hiredate) / 365, 0 ) from emp;


-- 日期型数据同样可以进行截取操作
select sysdate 当前日期,
       round(sysdate) 最近0点日期,
       round(sysdate, 'day') 最近星期日,
       round(sysdate, 'month') 最近月初,
       round(sysdate, 'q') 最近季初日期,
       round(sysdate, 'year') 最近年初日期
from dual;

