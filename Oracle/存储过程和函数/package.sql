-- ��ͷ�������еĽṹ
CREATE OR REPLACE PACKAGE mypackage AS
  type empcursor is ref cursor;
  procedure queryEmpList(dno in number, empList out empcursor);
END mypackage;


-- ���嶨�壨��Ҫʵ�ְ�ͷ�����������з�����
CREATE OR REPLACE PACKAGE BODY mypackage AS
  PROCEDURE queryEmpList(dno in number, empList out empcursor) AS
	BEGIN
		-- ʹ�ù����Ϊout����Ҳ�������Ҫ���ض������������
		OPEN empList FOR SELECT * FROM emp WHERE deptno = dno;
	END queryEmpList;
END mypackage;


-- ���ð��еĴ洢������Ҫ���ϰ���
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


