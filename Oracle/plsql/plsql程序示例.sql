DECLARE
  pname varchar2(20);
BEGIN
  pname := 'Hello World!!';
  dbms_output.put_line(pname);
END;


-- �����ͱ��� ��ԭʼ�е��������͸ı��ˣ�����ı���������Ҳ��ñ�
DECLARE
  -- ���������ͱ�������ѯ����ӡ7839��������нˮ
  pename emp.ename%type;
  psal emp.sal%type;
BEGIN
  -- �õ�7839��������нˮ
  select ename, sal into pename, psal from emp where empno = 7839;
  dbms_output.put_line('pename = ' || pename || ' psal = ' || psal);
END;


-- ��¼�ͱ���������
DECLARE
  -- ��¼�ͱ���������е�һ��
  emp_rec emp%rowtype;
BEGIN
  select * into emp_rec from emp where empno = 7839;
  dbms_output.put_line('ename = ' || emp_rec.ename || ' sal = ' || emp_rec.sal);
END;


-- ���������У�����ʹ�ø÷�ʽ�õ�һ���û�����
-- 1���û����붼���ַ�����2��num�б�����ǵ�ֵַ����ʾ�õ�ַ�ϱ����������ֵ
accpet num prompt '������һ�����֣�' 


-- ʹ��IF���
DECLARE
  pnum number;
BEGIN
  -- ��PLSQL�н���һ����������
  pnum := '&num';

  -- ��PLSQL�и�ֵʹ�� := ʹ�� = ��ʾ�ж��Ƿ���ȣ���һ�������������Բ�һ����Ҫע��
  IF pnum = 0 THEN dbms_output.put_line('������������� 0');
  ELSIF pnum = 1 THEN dbms_output.put_line('������������� 1');
  ELSIF pnum = 2 THEN dbms_output.put_line('������������� 2');
  ELSE dbms_output.put_line('���������������������');
  END IF;
END;


DECLARE
  pnum number := 1;
BEGIN
  WHILE pnum <= 10 LOOP
    dbms_output.put_line('��ǰ���� = ' || pnum);
    -- �� PLSQL ��û���������������Ե� ++ �� -- ����
    pnum := pnum + 1;
  END LOOP;
END;


-- �Ƽ�ʹ�� LOOP ѭ������ΪLOOPѭ��ʹ�ù��ȽϷ���
DECLARE
  pnum number := 1;
BEGIN
  LOOP
    -- �˳�ѭ��������
    EXIT WHEN pnum > 10;
    
    dbms_output.put_line('��ǰ���� = ' || pnum);
    
    pnum := pnum + 1;
  END LOOP;
END;


DECLARE
  pnum number := 1;
BEGIN
  FOR pnum IN 1 .. 10 LOOP
    dbms_output.put_line('��ǰ���� = ' || pnum);
  END LOOP;
END;


-- �α��ʹ��
DECLARE
  -- ����һ���α�
  CURSOR cemp IS SELECT ename, sal FROM emp;
  -- Ϊ�ر궨���Ӧ�ı���
  pename emp.ename%type;
  psal emp.sal%type;
BEGIN
  -- ���α�
  OPEN cemp;
  
  LOOP
    FETCH cemp into pename, psal;
    -- ѭ���˳���������FETCH ��䲻һ����ȡ������
    EXIT WHEN cemp%NOTFOUND;
    
    dbms_output.put_line('pename = ' || pename || ', psal = ' || psal);
  END LOOP;
  
  -- �ر��α�
  CLOSE cemp;
END;
/


-- ʹ��һ���α꣬ʵ�ָ���ͬԱ���ǹ���
DECLARE
  -- ����һ���α�
  CURSOR cemp IS SELECT empno, job FROM emp;
  pempno emp.empno%type;
  pjob emp.job%type;
BEGIN
  OPEN cemp;
  
  LOOP
    FETCH cemp into pempno, pjob;
    EXIT WHEN cemp%NOTFOUND;
    
    -- �ж�Ա����ְλ���ǹ���
    IF pjob = 'PRESIDENT' THEN UPDATE emp SET sal = sal + 1000 WHERE empno = pempno;
       ELSIF pjob = 'MANAGER' THEN UPDATE emp SET sal = sal + 800 WHERE empno = pempno;
       ELSE UPDATE emp SET sal = sal + 400 WHERE empno = pempno;
    END IF;
  END LOOP;
  
  CLOSE cemp;
  
  -- ����oracle, Ĭ�ϵ�������뼶���� read committed
  commit;
  
  dbms_output.put_line('�ǹ�����ɣ�');
END;

SELECT * FROM emp;


-- ���������α꣨����ʹ򿪵�ʱ��������
DECLARE
  -- ����һ�����������α�
  CURSOR cemp(dno number) IS SELECT ename FROM emp WHERE deptno = dno;
  pename emp.ename%type;
BEGIN
  -- ���α�
  OPEN cemp(10);
  
  LOOP
    FETCH cemp into pename;
    EXIT WHEN cemp%NOTFOUND;
    dbms_output.put_line('pename = ' || pename);
  END LOOP;
  
  CLOSE cemp;
END;
/


-- ϵͳ����
DECLARE
  pname emp.ename%type;
BEGIN
  SELECT ename INTO pname FROM emp WHERE empno=1234;
  
  -- һ����Ҫ�� PLSQL �����д������е��쳣������Ὣ�쳣�׸����ݿ�
  EXCEPTION
    WHEN NO_DATA_FOUND THEN dbms_output.put_line('û���ҵ���Ա��');
    -- �������������Ѿ�������쳣��OTHERS ���������������쳣
    WHEN OTHERS THEN dbms_output.put_line('�����쳣��');
END;


-- TOO_MANY_ROWS
DECLARE
  pname emp.ename%type;
BEGIN
  SELECT ename INTO pname FROM emp WHERE deptno = 10;
  
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN dbms_output.put_line('SELECT INTOƥ���˶���');
    WHEN OTHERS THEN dbms_output.put_line('�����쳣��');
END;


-- ZERO_DIVIDE
DECLARE
  pnum number;
BEGIN
  pnum := 10 / 0;
  
  EXCEPTION
    -- THEN �൱��һ�����ţ�������Ը�����쳣�������
    WHEN ZERO_DIVIDE THEN 
      dbms_output.put_line('0����������');
      dbms_output.put_line('0���ܱ���');
    WHEN OTHERS THEN dbms_output.put_line('�����쳣��');
END;


--VALUE_ERROR
DECLARE
  pnum number;
BEGIN
  pnum := 'abc';
  
  EXCEPTION
    WHEN VALUE_ERROR THEN dbms_output.put_line('��������ת������');
    WHEN OTHERS THEN dbms_output.put_line('�����쳣��');
END;


-- �Զ��������
DECLARE
  -- ����ر�
  CURSOR cemp IS SELECT ename FROM emp WHERE deptno = 50;
  pname emp.ename%type;
  
  -- �Զ����쳣
  NO_EMP_FOUND EXCEPTION;
BEGIN
  OPEN cemp;
  
  FETCH cemp INTO pname;
  IF cemp%NOTFOUND THEN
    -- �׳��쳣
    RAISE NO_EMP_FOUND;
  END IF;
  
  -- ������ RAISE �׳��쳣�󣬺������佫����ִ��
  -- ����Oracle���ݿ���Զ����� pmon��process monitor���̼����������ڳ����쳣ʱ�Զ�������������Դ����
  CLOSE cemp;
  
  EXCEPTION
    WHEN NO_EMP_FOUND THEN dbms_output.put_line('û���ҵ�Ա����');
    WHEN OTHERS THEN dbms_output.put_line('�����쳣��');
END;


