-- SQL 中的函数

/**
1、Oracle 中的函数必须有返回值
2、单行函数：每次取一条记录，作为函数的参数，得到这条记录的单个结果
3、多行函数：一次性把多条记录作为函数参数，得到多条记录对应的单个结果
4、Oracle中的数据类型主要分为字符型、数值型和日期型，因此单行函数也主要有：
字符函数、数值函数、日期函数、转换函数、其他函数
*/

-- 字符函数
select ename, length(ename) from emp;
select * from emp where lower(ename) = 'smith';
select * from emp where ename = upper('smith');
-- 首字母大写
select ename, initcap(ename) from emp where initcap(ename) = 'Smith';
-- 拼接字符串
select empno || ename, concat(empno, ename) from emp;
-- 子串
select ename, substr(ename, 1, 2) from emp;
-- 子串索引
select ename, instr(ename, 'A') from emp;
-- lpad左边补齐， rpad右边补齐
select sal, lpad(sal, 10, '*'), rpad(sal, 10, '#') from emp;
-- 替换
select ename, replace(ename, 'A', 'a') from emp;



-- 数字函数
-- 四舍五入
select round(45.943, 2) "小数点后两位",
       round(45.943, 0) "个位",
       round(45.943, -1) "十位"
from dual;
-- 截断
select trunc(45.943, 2) "小数点后两位",
       trunc(45.943, 0) "个位",
       trunc(45.943, -1) "十位"
from dual;
-- 求余
select ename, sal, MOD(sal, 300) from emp;



-- 日期函数
-- sysdate 返回系统当前时间，并且以年月日的形式显示
select sysdate from dual;

-- 虽然时间显示的时候是年月日，但是实际使用的时候还是 日月年
select * from emp where hiredate = '17-12月-1980';

-- 日期类型的数据可以使用算术运算符进行计算
select empno, SYSDATE, Hiredate, round( (sysdate - hiredate) / 365, 0 )
from emp;

-- months_between 计算两个日期相差多少个月
select empno, sysdate, hiredate, (sysdate - hiredate) / 30, months_between(sysdate, hiredate)
from emp;

-- add_months 为某个日期加上指定的月数
select empno, 
       hiredate "雇用日期", 
       (hiredate + 90) "粗略的转正日期", 
       add_months(hiredate, 3) "精确的转正日期"
from emp;

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

-- 日期型数据同样可以进行截取操作
select sysdate 当前日期,
       round(sysdate) 最近0点日期,
       round(sysdate, 'day') 最近星期日,
       round(sysdate, 'month') 最近月初,
       round(sysdate, 'q') 最近季初日期,
       round(sysdate, 'year') 最近年初日期
from dual;



-- 转换函数
-- 转换有两种方式：隐式转换 和 显示转换
select ename, empno, deptno from emp where deptno = '30';

-- to_char 转成字符串  日期转字符
-- 正常需要这样查找
select * from emp where hiredate = '17-12月-1980';
-- 使用 to_char 函数
select * from emp where to_char( hiredate, 'YYYY-MM-DD' ) = '1980-12-17';

select sysdate, to_char( sysdate, 'YYYY-MM-DD HH24:MI:SS AM DAY' ) from dual;

-- 数值型转 字符串 9：有就显示，没有就不显示，0：没有就显示为0，L：显示本地货币符号
select sal, to_char(sal, '$999,999.00'), to_char(sal, 'L000,000.00') from emp;

-- to_number, 把字符型数据转成数值, 注意：字符的格式和模板的格式必须要一致
select to_number('$800.00', '$999,999.00') from dual;

-- to_date, 把字符型数据转成日期
select * from emp where hiredate = to_date( '1980-12-17', 'YYYY-MM-DD' );



-- 其他函数
-- 在算术运算中出现null值，得到的结果就是null，可以用nvl函数将null替换为想要的值（类型需要匹配）
select ename, empno, sal, comm, 
       (sal * 12 + comm) "年收入1", 
       (sal * 12 + nvl(comm, 0)) "年收入2"
from emp;

select ename, job, nvl(job, '还没有工作') from emp;
-- nvl2 函数当表达式不为 null时，返回表达式1，否则返回表达式2
select ename, job, nvl2(job, job, '还没有工作') from emp;

-- NULLIF 比较两个表达式，如果相等返回空值，如果不等返回第一个表达式
select ename,
       job,
       NULLIF(length(ename), length(ename)),
       NULLIF(length(ename), length(job))
  from emp;

-- case 的用法
select ename,
       job,
       sal,
       CASE job
         WHEN 'CLERK' THEN
          1.10 * sal
         WHEN 'MANAGER' THEN
          1.30 * sal
         WHEN 'SALESMAN' THEN
          1.50 * sal
         ELSE
          sal
       END AS "修订工资数"
  from emp;

-- DECODE 关键字和 CASE 功能一样
select ename,
       job,
       sal,
       DECODE(job,
              'CLERK',
              1.10 * sal,
              'MANAGER',
              1.30 * sal,
              'SALESMAN',
              1.50 * sal,
              sal) AS "修订工资数"
  from emp;



select * from emp;

update emp set job=null where empno=7876;
