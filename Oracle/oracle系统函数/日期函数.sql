-- ���ں���
-- ϵͳʱ��
-- sysdate ����ϵͳ��ǰʱ�䣬�����������յ���ʽ��ʾ
SELECT SYSDATE FROM dual;  -- Ĭ�ϸ�ʽʱ������ DD-MON-RR ������

-- ��Ȼʱ����ʾ��ʱ���������գ�����ʵ��ʹ�õ�ʱ���� ������
SELECT * FROM emp WHERE hiredate = '17-12��-1980';


-- ���ڲ���
-- add_months Ϊĳ�����ڼ���ָ��������
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3), ADD_MONTHS(SYSDATE, -3) FROM dual;

SELECT empno, 
       hiredate "��������", 
       (hiredate + 90) "���Ե�ת������", 
       ADD_MONTHS(hiredate, 3) "��ȷ��ת������"
FROM emp;


-- next_day �����ڿ�ʼ���¸�ָ������
SELECT SYSDATE "��ǰ����",
       next_day(SYSDATE, '����һ') ��������һ,
       next_day(SYSDATE, '���ڶ�') �������ڶ�,
       next_day(SYSDATE, '������') ����������,
       next_day(SYSDATE, '������') ����������,
       next_day(SYSDATE, '������') ����������,
       next_day(SYSDATE, '������') ����������,
       next_day(SYSDATE, '������') ����������
FROM dual;

-- last_day ָ�����ڵ��µ����һ��
SELECT ename, hiredate, last_day(hiredate) FROM emp;


-- months_between �����������������ٸ���
SELECT MONTHS_BETWEEN('13-10��-20', '24-5��-20') FROM dual;  -- 4.64516129032258
SELECT empno, SYSDATE, hiredate, (SYSDATE - hiredate) / 30, 
       months_between(SYSDATE, hiredate)
FROM emp;

-- �������͵����ݿ���ʹ��������������м���
-- ��������ֱ��������õ���������
SELECT TO_DATE('13-10��-20') - TO_DATE('24-5��-20') FROM dual; -- 142
SELECT empno, SYSDATE, Hiredate, round( (SYSDATE - hiredate) / 365, 0 ) FROM emp;


-- ��ȡ������ָ����ʱ�䲿��
SELECT EXTRACT(YEAR FROM SYSDATE) FROM dual; -- 2020
SELECT EXTRACT(MONTH FROM SYSDATE) FROM dual;
SELECT EXTRACT(DAY FROM SYSDATE) FROM dual;
-- ʱ������ͣ�һ�����Ի�ȡ
SELECT EXTRACT(HOUR FROM TIMESTAMP '2020-10-13 12:30:30') FROM dual;  -- 12


-- ����������ͬ�����Խ��н�ȡ����
SELECT SYSDATE ��ǰ����,
       round(SYSDATE) ���0������,
       round(SYSDATE, 'day') ���������,
       round(SYSDATE, 'month') ����³�,
       round(SYSDATE, 'q') �����������,
       round(SYSDATE, 'year') ����������
FROM dual;

