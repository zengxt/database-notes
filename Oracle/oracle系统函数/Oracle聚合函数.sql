-- �麯�������к��������ۺϺ�����
-- �������룬һ�����

-- AVG �� SUM ֻ��������ֵ�͵�����
-- MAX��MIN��COUNT ��������κ����͵�����
SELECT MAX(sal), MIN(sal), AVG(sal), SUM(sal) FROM emp;
SELECT MAX(ename), MIN(ename) FROM emp;
SELECT MAX(hiredate), MIN(hiredate) FROM emp;


-- COUNT �������÷�
-- COUNT(*) ��ѯ���ݵ�������
SELECT COUNT(*) FROM emp;
-- COUNT(�ֶ�) ����Կ�ֵ
SELECT COUNT(comm) FROM emp;


-- ���еľۺϺ������Ǻ��Կ�ֵ��
SELECT SUM(comm), AVG(comm), COUNT(comm), SUM(comm) / COUNT(comm) FROM emp;


-- ������������ƽ������
SELECT SUM(comm) / COUNT(*),
       AVG(comm) /*ʵ���ϵȼ���  SUM(comm) / COUNT(comm) */,
       AVG(NVL(comm, 0))
FROM emp;


-- �������ݵķ���
-- �����ڲ�ѯ�б��е��ֶΣ�Ҫô�������麯���У�Ҫô������ GROUP BY�Ӿ���
SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;


-- ���ն���ֶν��з���
SELECT deptno, job, MAX(sal) 
FROM emp 
GROUP BY deptno, job
ORDER BY deptno;


-- �Է��������ݽ��й���
-- WHERE �Ӿ��в���ʹ�÷��麯���� ��Ҫ��� WHERE�Ӿ���ɸѡ��������������Ϊ���麯���������
-- �����Ҫ�Է��������ݹ��ˣ�ʹ�� HAVING �Ӿ䣬
-- �������Ϊ WHERE �Ƿ���ǰ���ˣ� HAVING �Ƿ������ˣ� ��д�� WHERE �Ӿ��е���������д�� WHERE�Ӿ���
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000
ORDER BY deptno;

SELECT deptno, MAX(sal)
FROM emp
WHERE deptno IS NOT NULL
GROUP BY deptno
HAVING MAX(sal) >= 3000
ORDER BY deptno;


-- �麯��Ҳ����Ƕ��
-- ���麯��Ƕ�׵�ʱ�򣬱���Ҫʹ��GROUP BY 
--����Ϊֻ��ʹ����GROUP BY���������Ϊ������¼����������Ϊ�麯�������룩
-- �麯�����Ƕ������
SELECT MAX (MAX(sal))
FROM emp
WHERE deptno IS NOT NULL
GROUP BY deptno;

