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
SELECT TO_DATE('2018-05-22', 'YYYY-MM-DD') FROM dual; -- 2018/5/22����ʾ�ĸ�ʽ���ܲ�����ָ����fmt�������ٴ�ʹ��TO_CHARת������Ҫ��ʾ�ĸ�ʽ
SELECT * FROM emp WHERE hiredate = TO_DATE( '1980-12-17', 'YYYY-MM-DD' );


-- ����ת�����ַ�
SELECT TO_CHAR(12345.678, '$99,999.999') FROM dual;  --  $12,345.678
SELECT TO_CHAR(12345.678, '$99,999,999') FROM dual;  --  $12,346
SELECT TO_CHAR(12345.678, 'S99,999.999') FROM dual;  --  +12,345.678
-- L����ʾ���ػ��ҷ���
SELECT sal, TO_CHAR(sal, '$999,999.00'), TO_CHAR(sal, 'L000,000.00') FROM emp;


-- �ַ�ת��������
-- to_number, ���ַ�������ת����ֵ, ע�⣺�ַ��ĸ�ʽ��ģ��ĸ�ʽ����Ҫһ��
SELECT to_number('$800.00', '$999,999.00') FROM dual;

