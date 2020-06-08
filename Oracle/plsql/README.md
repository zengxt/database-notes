# PL/SQL（Procedure Language/SQL）



&emsp;&emsp;PLSQL是Oracle对sql语言的过程化扩展

&emsp;&emsp;指在SQL命令中增加了过程处理语句（如分支、循环等），使SQL语言具有过程处理能力。

&emsp;&emsp;SQL是命令化语言，无法处理复杂的业务逻辑，所以PLSQL对其进行了扩展，使其具有编程语言的能力



## 一、PL/SQL的程序结构

```plsql
DECLARE
	说明部分（变量声明，光标声明，例外申明（即异常））
BEGIN
	语句序列（DML语句）
EXCEPTION
	例外处理语句
END;
/
```

### 1、说明部分

&emsp;&emsp;1、定义基本变量

&emsp;&emsp;类型：char、varchar2、date、number、boolean、long

&emsp;&emsp;举例：varl  char(15);&emsp;&emsp; married boolean := true;&emsp;&emsp;psql number(7, 2);

&emsp;&emsp;2、引用型变量

&emsp;&emsp;举例：my_name emp.ename%type;

&emsp;&emsp;3、记录型变量

&emsp;&emsp;举例：emp_rec emp%rowtype;

&emsp;&emsp;记录型变量分量的引用：emp_rec.ename := 'ADAMS';

```plsql
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
```



### 2、语句序列

#### 1）、IF语句

```plsql
IF 条件 THEN 语句序列1;
ELSE 语句序列2;
END IF;
```

```plsql
IF 条件 THEN 语句序列1;
ELSIF 语句序列2;
ELSE 语句序列3;
END IF;
```

实例：

```plsql
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
```



#### 2）、WHILE循环

```plsql
WHILE total <= 25000 LOOP
...
total := total + salary;
END LOOP;
```

实例：

```plsql
DECLARE
  pnum number := 1;
BEGIN
  WHILE pnum <= 10 LOOP
    dbms_output.put_line('当前数字 = ' || pnum);
    -- 在 PLSQL 中没有类似于其他语言的 ++ 和 -- 操作
    pnum := pnum + 1;
  END LOOP;
END;
```



#### 3）、LOOP循环

```plsql
LOOP
EXIT [WHEN 条件];
......
END LOOP;
```

**-- 推荐使用 LOOP 循环，因为LOOP循环使用光标比较方便**

```plsql
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
```



#### 4）、FOR循环

```plsql
FOR I IN 1 .. 3 LOOP
语句序列;
END LOOP;
```

实例

```plsql
DECLARE
  pnum number := 1;
BEGIN
  FOR pnum IN 1 .. 10 LOOP
    dbms_output.put_line('当前数字 = ' || pnum);
  END LOOP;
END;
```



#### 5）、游标

&emsp;&emsp;可以理解为Java程序中的结果集（Result Set）；

&emsp;&emsp;游标的语句：

```plsql
CURSOR 游标名 [(参数名 数据类型[, 参数名 数据类型]...)]
IS SELECT 语句;
例如：cursor c1 is select ename from emp;
```

**游标的使用**

&emsp;&emsp;1、打开游标：open c1; (打开游标执行查询)；

&emsp;&emsp;2、从游标中去一条记录：

&emsp;&emsp;fetch c1 into pename; (取一行值到变量中)

&emsp;&emsp;fetch 的作用：将游标指针指向的当前行返回，并将指针指向下一条记录。

&emsp;&emsp;3、关闭游标：close c1; (关闭游标释放资源)

```plsql
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
```



**游标的属性**

&emsp;&emsp;游标的属性（都以%打头），共有四个

&emsp;&emsp;1、%FOUND：取到数据；

&emsp;&emsp;2、%NOTFOUND：没有取到数据；

&emsp;&emsp;3、%ISOPEN：判断游标是否打开；

&emsp;&emsp;4、%ROWCOUNT：影响的行数（注意rowcount是影响的行数，不是总共行数，例如游标中共有100条数据，取走了10条，那么%ROWCOUNT就是10）。



**游标数目的限制**

&emsp;&emsp;默认情况下，oracle数据库只允许在同一个会话中，打开300个游标

![image-20200607235048070](C:\Users\86187\AppData\Roaming\Typora\typora-user-images\image-20200607235048070.png)

&emsp;&emsp;修改游标数目的限制：

```plsql
alter system set open_cursors = 400 scope = both;
```

&emsp;&emsp;scope的取值，both、memory（只更改当前实例，不更改配置文件）；spfile（只更改配置文件，不更改当前实例，数据库需要重启才起作用）。



**游标使用的实例**

```plsql
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
```

**带参数的游标**

```plsql
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
```



### 3、例外（异常）处理语句

&emsp;&emsp;Oracle中的例外分为：系统例外、自定义例外

#### 1）、系统例外（异常）

&emsp;&emsp;常用系统例外：1、NO_DATA_FOUND（没有找到数据）；2、TOO_MANY_ROWS（SELECT...INTO语句匹配多个行）；3、ZERO_DIVIDE（被零除）；4、VALUE_ERROR（算术或转换错误）；5、TIME_ON_RESOURCE（在等待资源时发生超时）。

**NO_DATA_FOUND**

```plsql
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
```

**TOO_MANY_ROWS**

```plsql
DECLARE
  pname emp.ename%type;
BEGIN
  SELECT ename INTO pname FROM emp WHERE deptno = 10;
  
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN dbms_output.put_line('SELECT INTO匹配了多行');
    WHEN OTHERS THEN dbms_output.put_line('其他异常！');
END;
```

**ZERO_DIVIDE**

```plsql
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
```

**VALUE_ERROR**

```plsql
DECLARE
  pnum number;
BEGIN
  pnum := 'abc';
  
  EXCEPTION
    WHEN VALUE_ERROR THEN dbms_output.put_line('算术或者转换错误！');
    WHEN OTHERS THEN dbms_output.put_line('其他异常！');
END;
```



#### 2）、自定义例外（异常）

&emsp;&emsp;定义变量，类型是exception，使用raise抛出自定义例外。

```plsql
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
```



## 二、PL/SQL程序示例

&emsp;&emsp;程序设计瀑布模型：需求分析 --> 设计（概要设计、详细设计） --> 编码（coding） --> 测试（Testing） --> 上线。

### 1、统计每年入职的员工人数





2、