-- �洢��������ѯĳ��Ա����������
CREATE OR REPLACE FUNCTION queryEmpIncome(eno IN NUMBER)
RETURN NUMBER
AS
  -- �����������Ա����нˮ�ͽ���
  psal emp.sal%type;
  pcomm emp.comm%type;
BEGIN
  -- �õ���Ա������н�뽱��
  SELECT sal, comm into psal, pcomm FROM emp WHERE empno = eno;
  
  -- ֱ�ӷ���������
  RETURN psal * 12 + nvl(pcomm, 0);
END;


/*
  ���ô洢�����ļ��ַ�����
  �� PLSQL ���У�
  1��SELECT queryEmpIncome(7839) INTO income FROM dual;
  2��income := queryEmpIncome(7839);
  
  �� SQL �������У�
  3��call
  variable income number
  call queryEmpIncome(7902) into :income; -- ��Ҫ �ֺţ���Ҫ ð��
  
  4��execute
  variable income number
  execute :income := queryEmpIncome(7902);
  
  5����������Ϊ��һ���ӳ���Ĳ�����execute dbms_output.put_line(queryEmpIncome(7902));
*/
DECLARE
  income number;
BEGIN
  -- SELECT queryEmpIncome(7839) INTO income FROM dual;
  -- income := queryEmpIncome(7839);
  execute income := queryEmpIncome(7902);
  dbms_output.put_line('income = ' || income);
END;


-- out ������ʹ�á���ѯĳ��Ա������ ��н��ְλ
CREATE OR REPLACE PROCEDURE queryEmpInform(eno IN NUMBER, 
       pname OUT VARCHAR2, psal OUT NUMBER, pjob OUT VARCHAR2)
AS
BEGIN
  -- �õ�Ա������������н��ְλ
  SELECT ename, sal, job INTO pname, psal, pjob FROM emp WHERE empno = eno;
  
  -- ���Ҫ����Ա����������Ϣ�أ��ܲ���д�ܶ�� OUT �����ɣ�����̫�ࣩ
  -- ���Ҫ����һ�����ŵ�����Ա����������Ϣ ---> �� OUT �з��ؼ��ϣ�
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





