-- 组函数：多行函数，（聚合函数）
-- 多行输入，一个输出

-- AVG 和 SUM 只能用于数值型的数据
-- MAX、MIN、COUNT 可以针对任何类型的数据
SELECT MAX(sal), MIN(sal), AVG(sal), SUM(sal) FROM emp;

SELECT MAX(ename), MIN(ename) FROM emp;
SELECT MAX(hiredate), MIN(hiredate) FROM emp;

-- COUNT 有两种用法
-- COUNT(*) 查询数据的总条数
SELECT COUNT(*) FROM emp;
-- COUNT(字段) 会忽略空值
SELECT COUNT(comm) FROM emp;

-- 所有的组函数都是忽略空值的
SELECT SUM(comm), AVG(comm), COUNT(comm), SUM(comm) / COUNT(comm) FROM emp;

-- 按照人数计算平均奖金
SELECT SUM(comm) / COUNT(*),
       AVG(comm) /*实际上等价于  SUM(comm) / COUNT(comm) */,
       AVG(NVL(comm, 0))
  FROM emp;

-- 建立数据的分组
-- 出现在查询列表中的字段，要么出现在组函数中，要么出现在 GROUP BY子句中
SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;

-- 按照多个字段进行分组
SELECT deptno, job, MAX(sal) 
FROM emp 
GROUP BY deptno, job
ORDER BY deptno;

-- 对分组后的数据进行过滤

-- WHERE 子句中不能使用分组函数， 需要理解 WHERE子句中筛选出来的数据是作为分组函数的输入的
-- 如果需要对分组后的数据过滤，使用 HAVING 子句，
-- 可以理解为 WHERE 是分组前过滤， HAVING 是分组后过滤， 能写在 WHERE 子句中的条件尽量写在 WHERE子句中
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


-- 组函数也可以嵌套
-- 在组函数嵌套的时候，必须要使用GROUP BY 
--（因为只用使用了GROUP BY，结果集才为多条记录，才又能作为组函数的输入）
-- 组函数最多嵌套两次
SELECT MAX (MAX(sal))
FROM emp
WHERE deptno IS NOT NULL
GROUP BY deptno;
