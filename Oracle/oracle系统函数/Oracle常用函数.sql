-- ��������
-- �����������г���nullֵ���õ��Ľ������null��������nvl������null�滻Ϊ��Ҫ��ֵ��������Ҫƥ�䣩
SELECT ename, empno, sal, comm, 
       (sal * 12 + comm) "������1", 
       (sal * 12 + NVL(comm, 0)) "������2"
FROM emp;

SELECT ename, job, NVL(job, '��û�й���') FROM emp;

-- nvl2 ���������ʽ��Ϊ nullʱ�����ر��ʽ1�����򷵻ر��ʽ2
SELECT ename, job, NVL2(job, job, '��û�й���') FROM emp;


-- NULLIF �Ƚ��������ʽ�������ȷ��ؿ�ֵ��������ȷ��ص�һ�����ʽ
SELECT ename,
       job,
       NULLIF(length(ename), length(ename)),
       NULLIF(length(ename), length(job))
FROM emp;

-- case ���÷�
SELECT ename,
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
FROM emp;


-- DECODE �ؼ��ֺ� CASE ����һ��
SELECT ename,
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
FROM emp;

