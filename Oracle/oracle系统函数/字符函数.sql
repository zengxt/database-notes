-- �ַ�����
-- ��Сдת��    INITCAP: ����ĸ��д
SELECT UPPER('assd'), LOWER('JHHSs'), INITCAP('asdd') FROM dual;  -- ASSD, jhhss, Asdd
SELECT ename, INITCAP(ename) FROM emp WHERE INITCAP(ename) = 'Smith';
SELECT * FROM emp WHERE LOWER(ename) = 'smith';
SELECT * FROM emp WHERE ename = UPPER('smith');


-- �Ӵ�
SELECT SUBSTR('abcde', 2, 3),         -- bcd
       SUBSTR('abcde', 2),            -- bcde
       SUBSTR('abcde', -2, 1)         -- d
FROM DUAL;

SELECT ename, SUBSTR(ename, 2, 2) FROM emp;


-- ��ȡ�ַ�������
SELECT ename, LENGTH(ename) FROM emp;


-- ƴ���ַ���
SELECT 'ab' || 'cd', CONCAT('ab', 'cd') FROM dual;
SELECT empno || ename, CONCAT(empno, ename) FROM emp;


-- ȥ�����ַ�
SELECT TRIM('a' FROM 'abcd') FROM dual;  -- bcd
SELECT LTRIM('ababaa', 'a') FROM dual;  -- babaa
SELECT LTRIM('aaababaa', 'a') FROM dual;  -- babaa
SELECT RTRIM('ababaa', 'a') FROM dual;  -- abab


-- �滻����
SELECT REPLACE('abscd', 'a', 'A') FROM dual;  -- Abscd
SELECT REPLACE('abscd', 'a') FROM dual;  -- bscd
-- ��trim����������replace��������ͬʱ��������ַ�
SELECT REPLACE('abscd', 'ab', 'A') FROM dual; -- Ascd
SELECT ename, REPLACE(ename, 'A', 'a') from emp;


-- �Ӵ�����
SELECT ename, instr(ename, 'A') from emp;

-- lpad��߲��룬 rpad�ұ߲���
SELECT sal, lpad(sal, 10, '*'), rpad(sal, 10, '#') from emp;

