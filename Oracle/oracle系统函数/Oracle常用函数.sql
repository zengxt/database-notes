-- SQL �еĺ���
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

