-- 存储函数：查询某个员工的年收入
CREATE OR REPLACE FUNCTION queryEmpIncome(eno IN NUMBER)
RETURN NUMBER
AS
  -- 定义变量保存员工的薪水和奖金
  psal emp.sal%type;
  pcomm emp.comm%type;
BEGIN
  -- 得到该员工的月薪与奖金
  SELECT sal, comm into psal, pcomm FROM emp WHERE empno = eno;
  
  -- 直接返回年收入
  RETURN psal * 12 + nvl(pcomm, 0);
END;


/*
  调用存储函数的几种方法：
  在 PLSQL 块中：
  1、SELECT queryEmpIncome(7839) INTO income FROM dual;
  2、income := queryEmpIncome(7839);
  
  在 SQL 命令行中：
  3、call
  variable income number
  call queryEmpIncome(7902) into :income; -- 需要 分号，需要 冒号
  
  4、execute
  variable income number
  execute :income := queryEmpIncome(7902);
  
  5、将函数作为另一个子程序的参数：execute dbms_output.put_line(queryEmpIncome(7902));
*/
DECLARE
  income number;
BEGIN
  -- SELECT queryEmpIncome(7839) INTO income FROM dual;
  -- income := queryEmpIncome(7839);
  execute income := queryEmpIncome(7902);
  dbms_output.put_line('income = ' || income);
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





