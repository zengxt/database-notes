-- 使用 Where 子句对数据进行过滤
select * from emp where deptno = 10;


-- 对于字符型的数据和日期型的数据必须要使用 '' 
-- 字符型的数据对大小写是敏感的
select * from emp where ename='SMITH';


-- 对于日期型的数据，格式是敏感的，使用日期型数据的格式是 DD-MM-YYYY（日-月-年）
select * from emp where hiredate = '20-2月-1981';

-- 改变当前会话中的日期格式
alter session set nls_date_format = "YYYY-MM-DD HH:MI:SS"

select * from emp where hiredate = '1981-2-20';


-- 在查询条件中使用其他的比较运算符
select * from emp where sal >= 2000;

select * from emp where sal != 3000;
select * from emp where sal <> 3000;


-- 使用 between ... and
select * from emp where sal between 2000 and 3000;
-- 等价于
select * from emp where sal >= 2000 and sal <= 3000;

-- 使用 IN 指定 字符型数据类型的范围
select * from emp where job IN('MANAGER', 'CLERK');
-- 等价于
select * from emp where job = 'MANAGER' or job = 'CLERK';


-- LIKE 用于字符型数据的查询，可以执行模糊查询
-- % 表示0个或多个任意的字符
select * from emp where ename like '%A%';
select * from emp where ename like 'A%';
-- _表示一个字符
select * from emp where ename like '_A%';
-- 需要匹配 % 时需要转义，并且可以指定转义符
select * from emp where ename like '%\%%' ESCAPE '\';


-- 对于空值，要使用 IS NULL进行比较
select * from emp where comm is null;


-- 使用 NOT 运算符
select * from emp where sal not between 2000 and 3000;
-- 等价于
select * from emp where sal < 2000 or sal > 3000;

select * from emp where comm is not null;


-- 使用 Order By 对查询结果进行排序 (asc关键字可有可无，默认就是ASC 升序排列)
select * from emp order by sal asc;
-- 降序排列
select * from emp order by sal desc;
-- 使用字段的别名进行排序
select empno, ename, (sal * 12) "年薪"
from emp
order by "年薪";
