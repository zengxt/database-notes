-- SQL 中的函数

/**
1、Oracle 中的函数必须有返回值
2、单行函数：每次取一条记录，作为函数的参数，得到这条记录的单个结果
3、多行函数：一次性把多条记录作为函数参数，得到多条记录对应的单个结果
4、Oracle中的数据类型主要分为字符型、数值型和日期型，因此单行函数也主要有：
字符函数、数值函数、日期函数、转换函数、其他函数
*/

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
