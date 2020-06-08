DECLARE
  pname varchar2(20);
BEGIN
  pname := 'Hello World!!';
  dbms_output.put_line(pname);
END;


-- 引用型变量 （原始列的数据类型改变了，定义的变量的类型也会该表）
DECLARE
  -- 定义引用型变量：查询并打印7839的姓名和薪水
  pename emp.ename%type;
  psal emp.sal%type;
BEGIN
  -- 得到7839的姓名和薪水
  select ename, sal into pename, psal from emp where empno = 7839;
  dbms_output.put_line('pename = ' || pename || ' psal = ' || psal);
END;


-- 记录型变量的引用
DECLARE
  -- 记录型变量代表表中的一行
  emp_rec emp%rowtype;
BEGIN
  select * into emp_rec from emp where empno = 7839;
  dbms_output.put_line('ename = ' || emp_rec.ename || ' sal = ' || emp_rec.sal);
END;


-- 在命令行中，可以使用该方式得到一个用户输入
-- 1、用户输入都是字符串；2、num中保存的是地址值，表示该地址上保存了输入的值
accpet num prompt '请输入一个数字：' 


-- 使用IF语句
DECLARE
  pnum number;
BEGIN
  -- 在PLSQL中接收一个键盘输入
  pnum := '&num';

  -- 在PLSQL中赋值使用 := 使用 = 表示判断是否相等，这一点和其他编程语言不一样需要注意
  IF pnum = 0 THEN dbms_output.put_line('您输入的数字是 0');
  ELSIF pnum = 1 THEN dbms_output.put_line('您输入的数字是 1');
  ELSIF pnum = 2 THEN dbms_output.put_line('您输入的数字是 2');
  ELSE dbms_output.put_line('您输入的数字是其他数字');
  END IF;
END;


DECLARE
  pnum number := 1;
BEGIN
  WHILE pnum <= 10 LOOP
    dbms_output.put_line('当前数字 = ' || pnum);
    -- 在 PLSQL 中没有类似于其他语言的 ++ 和 -- 操作
    pnum := pnum + 1;
  END LOOP;
END;


-- 推荐使用 LOOP 循环，因为LOOP循环使用光标比较方便
DECLARE
  pnum number := 1;
BEGIN
  LOOP
    -- 退出循环的条件
    EXIT WHEN pnum > 10;
    
    dbms_output.put_line('当前数字 = ' || pnum);
    
    pnum := pnum + 1;
  END LOOP;
END;


DECLARE
  pnum number := 1;
BEGIN
  FOR pnum IN 1 .. 10 LOOP
    dbms_output.put_line('当前数字 = ' || pnum);
  END LOOP;
END;


-- 游标的使用
DECLARE
  -- 定义一个游标
  CURSOR cemp IS SELECT ename, sal FROM emp;
  -- 为关标定义对应的变量
  pename emp.ename%type;
  psal emp.sal%type;
BEGIN
  -- 打开游标
  OPEN cemp;
  
  LOOP
    FETCH cemp into pename, psal;
    -- 循环退出的条件，FETCH 语句不一定能取到数据
    EXIT WHEN cemp%NOTFOUND;
    
    dbms_output.put_line('pename = ' || pename || ', psal = ' || psal);
  END LOOP;
  
  -- 关闭游标
  CLOSE cemp;
END;
/


-- 使用一个游标，实现给不同员工涨工资
DECLARE
  -- 定义一个游标
  CURSOR cemp IS SELECT empno, job FROM emp;
  pempno emp.empno%type;
  pjob emp.job%type;
BEGIN
  OPEN cemp;
  
  LOOP
    FETCH cemp into pempno, pjob;
    EXIT WHEN cemp%NOTFOUND;
    
    -- 判断员工的职位，涨工资
    IF pjob = 'PRESIDENT' THEN UPDATE emp SET sal = sal + 1000 WHERE empno = pempno;
       ELSIF pjob = 'MANAGER' THEN UPDATE emp SET sal = sal + 800 WHERE empno = pempno;
       ELSE UPDATE emp SET sal = sal + 400 WHERE empno = pempno;
    END IF;
  END LOOP;
  
  CLOSE cemp;
  
  -- 对于oracle, 默认的事务隔离级别是 read committed
  commit;
  
  dbms_output.put_line('涨工资完成！');
END;

SELECT * FROM emp;


-- 带参数的游标（定义和打开的时候有区别）
DECLARE
  -- 定义一个带参数的游标
  CURSOR cemp(dno number) IS SELECT ename FROM emp WHERE deptno = dno;
  pename emp.ename%type;
BEGIN
  -- 打开游标
  OPEN cemp(10);
  
  LOOP
    FETCH cemp into pename;
    EXIT WHEN cemp%NOTFOUND;
    dbms_output.put_line('pename = ' || pename);
  END LOOP;
  
  CLOSE cemp;
END;
/


-- 系统例外
DECLARE
  pname emp.ename%type;
BEGIN
  SELECT ename INTO pname FROM emp WHERE empno=1234;
  
  -- 一般需要在 PLSQL 程序中处理所有的异常，否则会将异常抛给数据库
  EXCEPTION
    WHEN NO_DATA_FOUND THEN dbms_output.put_line('没有找到该员工');
    -- 处理所有上述已经处理的异常，OTHERS 将处理其他所有异常
    WHEN OTHERS THEN dbms_output.put_line('其他异常！');
END;


-- TOO_MANY_ROWS
DECLARE
  pname emp.ename%type;
BEGIN
  SELECT ename INTO pname FROM emp WHERE deptno = 10;
  
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN dbms_output.put_line('SELECT INTO匹配了多行');
    WHEN OTHERS THEN dbms_output.put_line('其他异常！');
END;


-- ZERO_DIVIDE
DECLARE
  pnum number;
BEGIN
  pnum := 10 / 0;
  
  EXCEPTION
    -- THEN 相当于一个括号，后面可以跟多个异常处理语句
    WHEN ZERO_DIVIDE THEN 
      dbms_output.put_line('0不能做除数');
      dbms_output.put_line('0不能被除');
    WHEN OTHERS THEN dbms_output.put_line('其他异常！');
END;


--VALUE_ERROR
DECLARE
  pnum number;
BEGIN
  pnum := 'abc';
  
  EXCEPTION
    WHEN VALUE_ERROR THEN dbms_output.put_line('算术或者转换错误！');
    WHEN OTHERS THEN dbms_output.put_line('其他异常！');
END;


-- 自定义的例外
DECLARE
  -- 定义关标
  CURSOR cemp IS SELECT ename FROM emp WHERE deptno = 50;
  pname emp.ename%type;
  
  -- 自定义异常
  NO_EMP_FOUND EXCEPTION;
BEGIN
  OPEN cemp;
  
  FETCH cemp INTO pname;
  IF cemp%NOTFOUND THEN
    -- 抛出异常
    RAISE NO_EMP_FOUND;
  END IF;
  
  -- 按道理 RAISE 抛出异常后，后面的语句将不再执行
  -- 但是Oracle数据库会自动启动 pmon（process monitor进程监视器），在程序异常时自动进行垃圾和资源回收
  CLOSE cemp;
  
  EXCEPTION
    WHEN NO_EMP_FOUND THEN dbms_output.put_line('没有找到员工！');
    WHEN OTHERS THEN dbms_output.put_line('其他异常！');
END;


