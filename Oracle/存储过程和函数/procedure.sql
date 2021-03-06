-- 第一个存储过程：打印 HELLO WORLD
CREATE OR REPLACE PROCEDURE sayHelloWorld
AS
  -- 相当于 PLSQL块中的 DECLARE 声明部分
BEGIN
  dbms_output.put_line('HELLO WORLD!!');
END;

/**
调用存储过程：
1、exec sayHelloWorld();
2、在另一个存储过程中调用
begin
  sayHelloWorld();
  sayHelloWorld();
end;
**/

begin
  sayHelloWorld();
  sayHelloWorld();
end;


-- 带参数的存储过程
/**
注意：在该存储过程中更新了表数据，但是不需要使用事务 commit
**/
-- 给指定的员工涨100元工资，并且打印涨前和涨后的工资
CREATE OR REPLACE PROCEDURE raiseSalary(eno in number)
AS
  -- 定义一个变量保存涨前的薪水
  psal emp.sal%type;
BEGIN
  SELECT sal INTO psal FROM emp WHERE empno = eno;
  
  -- 注意：一般不在存储过程和存储函数中，commit 和 rollback，事务控制交给调用者
  UPDATE emp SET sal = sal + 100 WHERE empno = eno;

  dbms_output.put_line('涨前薪水：' || psal || '，涨后薪水：' || (psal + 100));
END;


BEGIN
  -- 在这里提交，要保证两个人同时涨工资，这也解释了为什么一般不在存储过程里面做事务控制
  raiseSalary(7839);
  raiseSalary(7566);
  COMMIT;
END;


-- out 参数的使用。查询某个员工姓名 月薪和职位
CREATE OR REPLACE PROCEDURE queryEmpInform(eno IN NUMBER, 
       pname OUT VARCHAR2, psal OUT NUMBER, pjob OUT VARCHAR2)
AS
BEGIN
  -- 得到员工的姓名，月薪和职位
  SELECT ename, sal, job INTO pname, psal, pjob FROM emp WHERE empno = eno;
  
  -- 如果要返回员工的所有信息呢，总不能写很多个 OUT 参数吧（参数太多）
  -- 如果要返回一个部门的所有员工的所有信息 ---> 在 OUT 中返回集合？
END;
/

SELECT * FROM emp;

DECLARE
  pname emp.ename%type;
  psal emp.sal%type;
  pjob emp.job%type;
BEGIN
  queryEmpInform(7839, pname, psal, pjob);
  dbms_output.put_line('pname = ' || pname || ', psal = ' || psal || ', pjob = ' || pjob);
END;


