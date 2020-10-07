-- 字符函数
-- 大小写转化    INITCAP: 首字母大写
SELECT UPPER('assd'), LOWER('JHHSs'), INITCAP('asdd') FROM dual;  -- ASSD, jhhss, Asdd
SELECT ename, INITCAP(ename) FROM emp WHERE INITCAP(ename) = 'Smith';
SELECT * FROM emp WHERE LOWER(ename) = 'smith';
SELECT * FROM emp WHERE ename = UPPER('smith');


-- 子串
SELECT SUBSTR('abcde', 2, 3),         -- bcd
       SUBSTR('abcde', 2),            -- bcde
       SUBSTR('abcde', -2, 1)         -- d
FROM DUAL;

SELECT ename, SUBSTR(ename, 2, 2) FROM emp;


-- 获取字符串长度
SELECT ename, LENGTH(ename) FROM emp;


-- 拼接字符串
SELECT empno || ename, CONCAT(empno, ename) FROM emp;


-- 子串索引
select ename, instr(ename, 'A') from emp;
-- lpad左边补齐， rpad右边补齐
select sal, lpad(sal, 10, '*'), rpad(sal, 10, '#') from emp;
-- 替换
select ename, replace(ename, 'A', 'a') from emp;
