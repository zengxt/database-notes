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
select sysdate "��ǰ����",
       next_day(sysdate, '����һ') ��������һ,
       next_day(sysdate, '���ڶ�') �������ڶ�,
       next_day(sysdate, '������') ����������,
       next_day(sysdate, '������') ����������,
       next_day(sysdate, '������') ����������,
       next_day(sysdate, '������') ����������,
       next_day(sysdate, '������') ����������
from dual;

-- last_day ָ�����ڵ��µ����һ��
select ename, hiredate, last_day(hiredate) from emp;


-- months_between �����������������ٸ���
select empno, sysdate, hiredate, (sysdate - hiredate) / 30, months_between(sysdate, hiredate)
from emp;


-- �������͵����ݿ���ʹ��������������м���
select empno, SYSDATE, Hiredate, round( (sysdate - hiredate) / 365, 0 ) from emp;


-- ����������ͬ�����Խ��н�ȡ����
select sysdate ��ǰ����,
       round(sysdate) ���0������,
       round(sysdate, 'day') ���������,
       round(sysdate, 'month') ����³�,
       round(sysdate, 'q') �����������,
       round(sysdate, 'year') ����������
from dual;

