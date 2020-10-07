-- SQL �еĺ���

/**
1��Oracle �еĺ��������з���ֵ
2�����к�����ÿ��ȡһ����¼����Ϊ�����Ĳ������õ�������¼�ĵ������
3�����к�����һ���԰Ѷ�����¼��Ϊ�����������õ�������¼��Ӧ�ĵ������
4��Oracle�е�����������Ҫ��Ϊ�ַ��͡���ֵ�ͺ������ͣ���˵��к���Ҳ��Ҫ�У�
�ַ���������ֵ���������ں�����ת����������������
*/

-- ���ں���
-- sysdate ����ϵͳ��ǰʱ�䣬�����������յ���ʽ��ʾ
select sysdate from dual;

-- ��Ȼʱ����ʾ��ʱ���������գ�����ʵ��ʹ�õ�ʱ���� ������
select * from emp where hiredate = '17-12��-1980';

-- �������͵����ݿ���ʹ��������������м���
select empno, SYSDATE, Hiredate, round( (sysdate - hiredate) / 365, 0 )
from emp;

-- months_between �����������������ٸ���
select empno, sysdate, hiredate, (sysdate - hiredate) / 30, months_between(sysdate, hiredate)
from emp;

-- add_months Ϊĳ�����ڼ���ָ��������
select empno, 
       hiredate "��������", 
       (hiredate + 90) "���Ե�ת������", 
       add_months(hiredate, 3) "��ȷ��ת������"
from emp;

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

-- ����������ͬ�����Խ��н�ȡ����
select sysdate ��ǰ����,
       round(sysdate) ���0������,
       round(sysdate, 'day') ���������,
       round(sysdate, 'month') ����³�,
       round(sysdate, 'q') �����������,
       round(sysdate, 'year') ����������
from dual;



-- ת������
-- ת�������ַ�ʽ����ʽת�� �� ��ʾת��
select ename, empno, deptno from emp where deptno = '30';

-- to_char ת���ַ���  ����ת�ַ�
-- ������Ҫ��������
select * from emp where hiredate = '17-12��-1980';
-- ʹ�� to_char ����
select * from emp where to_char( hiredate, 'YYYY-MM-DD' ) = '1980-12-17';

select sysdate, to_char( sysdate, 'YYYY-MM-DD HH24:MI:SS AM DAY' ) from dual;

-- ��ֵ��ת �ַ��� 9���о���ʾ��û�оͲ���ʾ��0��û�о���ʾΪ0��L����ʾ���ػ��ҷ���
select sal, to_char(sal, '$999,999.00'), to_char(sal, 'L000,000.00') from emp;

-- to_number, ���ַ�������ת����ֵ, ע�⣺�ַ��ĸ�ʽ��ģ��ĸ�ʽ����Ҫһ��
select to_number('$800.00', '$999,999.00') from dual;

-- to_date, ���ַ�������ת������
select * from emp where hiredate = to_date( '1980-12-17', 'YYYY-MM-DD' );



-- ��������
-- �����������г���nullֵ���õ��Ľ������null��������nvl������null�滻Ϊ��Ҫ��ֵ��������Ҫƥ�䣩
select ename, empno, sal, comm, 
       (sal * 12 + comm) "������1", 
       (sal * 12 + nvl(comm, 0)) "������2"
from emp;

select ename, job, nvl(job, '��û�й���') from emp;
-- nvl2 ���������ʽ��Ϊ nullʱ�����ر��ʽ1�����򷵻ر��ʽ2
select ename, job, nvl2(job, job, '��û�й���') from emp;

-- NULLIF �Ƚ��������ʽ�������ȷ��ؿ�ֵ��������ȷ��ص�һ�����ʽ
select ename,
       job,
       NULLIF(length(ename), length(ename)),
       NULLIF(length(ename), length(job))
  from emp;

-- case ���÷�
select ename,
       job,
       sal,
       CASE job
         WHEN 'CLERK' THEN
          1.10 * sal
         WHEN 'MANAGER' THEN
          1.30 * sal
         WHEN 'SALESMAN' THEN
          1.50 * sal
         ELSE
          sal
       END AS "�޶�������"
  from emp;

-- DECODE �ؼ��ֺ� CASE ����һ��
select ename,
       job,
       sal,
       DECODE(job,
              'CLERK',
              1.10 * sal,
              'MANAGER',
              1.30 * sal,
              'SALESMAN',
              1.50 * sal,
              sal) AS "�޶�������"
  from emp;



select * from emp;

update emp set job=null where empno=7876;
