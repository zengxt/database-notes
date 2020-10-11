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
SELECT 'ab' || 'cd', CONCAT('ab', 'cd') FROM dual;
SELECT empno || ename, CONCAT(empno, ename) FROM emp;


-- 去除子字符
SELECT TRIM('a' FROM 'abcd') FROM dual;  -- bcd
SELECT LTRIM('ababaa', 'a') FROM dual;  -- babaa
SELECT LTRIM('aaababaa', 'a') FROM dual;  -- babaa
SELECT RTRIM('ababaa', 'a') FROM dual;  -- abab


-- 替换函数
SELECT REPLACE('abscd', 'a', 'A') FROM dual;  -- Abscd
SELECT REPLACE('abscd', 'a') FROM dual;  -- bscd
-- 与trim函数的区别，replace函数可以同时操作多个字符
SELECT REPLACE('abscd', 'ab', 'A') FROM dual; -- Ascd
SELECT ename, REPLACE(ename, 'A', 'a') from emp;


-- 子串索引
SELECT ename, instr(ename, 'A') from emp;

-- lpad左边补齐， rpad右边补齐
SELECT sal, lpad(sal, 10, '*'), rpad(sal, 10, '#') from emp;

