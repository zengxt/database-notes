-- 转换函数
-- 转换有两种方式：隐式转换 和 显示转换
SELECT ename, empno, deptno FROM emp WHERE deptno = '30';


--日期转换成字符
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS') FROM dual;
SELECT SYSDATE, to_char( SYSDATE, 'YYYY-MM-DD HH24:MI:SS AM DAY' ) from dual;

-- 查询时间有关条件字段，正常需要这样查找
SELECT * FROM emp WHERE hiredate = '17-12月-1980';
-- 使用 to_char 函数
SELECT * FROM emp WHERE TO_CHAR( hiredate, 'YYYY-MM-DD' ) = '1980-12-17';


-- 字符转换成日期
-- to_date, 把字符型数据转成日期
select * from emp where hiredate = to_date( '1980-12-17', 'YYYY-MM-DD' );



-- 数值型转 字符串 9：有就显示，没有就不显示，0：没有就显示为0，L：显示本地货币符号
select sal, to_char(sal, '$999,999.00'), to_char(sal, 'L000,000.00') from emp;

-- to_number, 把字符型数据转成数值, 注意：字符的格式和模板的格式必须要一致
select to_number('$800.00', '$999,999.00') from dual;

