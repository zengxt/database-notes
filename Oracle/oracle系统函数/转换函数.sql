-- ת������
-- ת�������ַ�ʽ����ʽת�� �� ��ʾת��
SELECT ename, empno, deptno FROM emp WHERE deptno = '30';


--����ת�����ַ�
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS') FROM dual;
SELECT SYSDATE, to_char( SYSDATE, 'YYYY-MM-DD HH24:MI:SS AM DAY' ) from dual;

-- ��ѯʱ���й������ֶΣ�������Ҫ��������
SELECT * FROM emp WHERE hiredate = '17-12��-1980';
-- ʹ�� to_char ����
SELECT * FROM emp WHERE TO_CHAR( hiredate, 'YYYY-MM-DD' ) = '1980-12-17';


-- �ַ�ת��������
-- to_date, ���ַ�������ת������
select * from emp where hiredate = to_date( '1980-12-17', 'YYYY-MM-DD' );



-- ��ֵ��ת �ַ��� 9���о���ʾ��û�оͲ���ʾ��0��û�о���ʾΪ0��L����ʾ���ػ��ҷ���
select sal, to_char(sal, '$999,999.00'), to_char(sal, 'L000,000.00') from emp;

-- to_number, ���ַ�������ת����ֵ, ע�⣺�ַ��ĸ�ʽ��ģ��ĸ�ʽ����Ҫһ��
select to_number('$800.00', '$999,999.00') from dual;

