-- SQL 中的函数
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

