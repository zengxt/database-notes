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


