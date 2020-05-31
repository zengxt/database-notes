-- ��һ���洢���̣���ӡ HELLO WORLD
CREATE OR REPLACE PROCEDURE sayHelloWorld
AS
  -- �൱�� PLSQL���е� DECLARE ��������
BEGIN
  dbms_output.put_line('HELLO WORLD!!');
END;

/**
���ô洢���̣�
1��exec sayHelloWorld();
2������һ���洢�����е���
begin
  sayHelloWorld();
  sayHelloWorld();
end;
**/

begin
  sayHelloWorld();
  sayHelloWorld();
end;


-- �������Ĵ洢����
/**
ע�⣺�ڸô洢�����и����˱����ݣ����ǲ���Ҫʹ������ commit
**/
-- ��ָ����Ա����100Ԫ���ʣ����Ҵ�ӡ��ǰ���Ǻ�Ĺ���
CREATE OR REPLACE PROCEDURE raiseSalary(eno in number)
AS
  -- ����һ������������ǰ��нˮ
  psal emp.sal%type;
BEGIN
  SELECT sal INTO psal FROM emp WHERE empno = eno;
  
  -- ע�⣺һ�㲻�ڴ洢���̺ʹ洢�����У�commit �� rollback��������ƽ���������
  UPDATE emp SET sal = sal + 100 WHERE empno = eno;

  dbms_output.put_line('��ǰнˮ��' || psal || '���Ǻ�нˮ��' || (psal + 100));
END;


BEGIN
  -- �������ύ��Ҫ��֤������ͬʱ�ǹ��ʣ���Ҳ������Ϊʲôһ�㲻�ڴ洢�����������������
  raiseSalary(7839);
  raiseSalary(7566);
  COMMIT;
END;

