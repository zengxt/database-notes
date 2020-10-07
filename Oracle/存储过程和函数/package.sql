-- 包头声明包中的结构
CREATE OR REPLACE PACKAGE mypackage AS
  type empcursor is ref cursor;
  procedure queryEmpList(dno in number, empList out empcursor);
END mypackage;


-- 包体定义（需要实现包头中声明的所有方法）
CREATE OR REPLACE PACKAGE BODY mypackage AS
  PROCEDURE queryEmpList(dno in number, empList out empcursor) AS
	BEGIN
		-- 使用光标作为out参数也解决了需要返回多个变量的问题
		OPEN empList FOR SELECT * FROM emp WHERE deptno = dno;
	END queryEmpList;
END mypackage;


-- 调用包中的存储过程需要带上包名
DECLARE
  cemp mypackage.empcursor;
  pemp emp%rowtype;
BEGIN
  mypackage.queryEmpList(10, cemp);
  LOOP
    FETCH cemp INTO pemp;
    EXIT WHEN cemp%NOTFOUND;
    dbms_output.put_line('pname = ' || pemp.ename || ', psal = ' || pemp.sal || ', pjob = ' || pemp.job);
  END LOOP;
END;


