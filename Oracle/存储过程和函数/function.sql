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


