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
SELECT TO_DATE('2018-05-22', 'YYYY-MM-DD') FROM dual; -- 2018/5/22，显示的格式可能并不是指定的fmt，可以再次使用TO_CHAR转换成想要显示的格式
SELECT * FROM emp WHERE hiredate = TO_DATE( '1980-12-17', 'YYYY-MM-DD' );


-- 数字转换成字符
SELECT TO_CHAR(12345.678, '$99,999.999') FROM dual;  --  $12,345.678
SELECT TO_CHAR(12345.678, '$99,999,999') FROM dual;  --  $12,346
SELECT TO_CHAR(12345.678, 'S99,999.999') FROM dual;  --  +12,345.678
-- L：显示本地货币符号
SELECT sal, TO_CHAR(sal, '$999,999.00'), TO_CHAR(sal, 'L000,000.00') FROM emp;


-- 字符转换成数字
-- to_number, 把字符型数据转成数值, 注意：字符的格式和模板的格式必须要一致
SELECT to_number('$800.00', '$999,999.00') FROM dual;

