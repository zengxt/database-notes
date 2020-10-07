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
SELECT empno || ename, CONCAT(empno, ename) FROM emp;


-- �Ӵ�����
select ename, instr(ename, 'A') from emp;
-- lpad��߲��룬 rpad�ұ߲���
select sal, lpad(sal, 10, '*'), rpad(sal, 10, '#') from emp;
-- �滻
select ename, replace(ename, 'A', 'a') from emp;
