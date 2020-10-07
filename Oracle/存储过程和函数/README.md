# 存储过程或存储函数

&emsp;&emsp;存储在数据库中供所有用户程序调用的子程序叫存储过程或存储函数。



&emsp;&emsp;存储过程和存储函数的相同点：完成特定功能的程序；

&emsp;&emsp;存储过程和存储函数的区别：是否用RETURN语句返回值，存储函数可以通过return语句返回值。



## 一、存储过程

创建和使用存储过程，最简化的语法：

```plsql
CREATE [OR REPLACE] PROCEDURE 过程名（参数列表）

AS

PLSQL程序体;
```



**第一个存储过程：**

```plsql
-- 第一个存储过程：打印 HELLO WORLD
CREATE OR REPLACE PROCEDURE sayHelloWorld
AS
  -- 相当于 PLSQL块中的 DECLARE 声明部分
BEGIN
  dbms_output.put_line('HELLO WORLD!!');
END;

/**
调用存储过程：
1、exec sayHelloWorld();
2、在另一个存储过程中调用
begin
  sayHelloWorld();
  sayHelloWorld();
end;
**/

begin
  sayHelloWorld();
  sayHelloWorld();
end;
```



**带参数的存储过程：**

```plsql
-- 带参数的存储过程
/**
注意：在该存储过程中更新了表数据，但是不需要使用事务 commit
**/
-- 给指定的员工涨100元工资，并且打印涨前和涨后的工资
CREATE OR REPLACE PROCEDURE raiseSalary(eno in number)
AS
  -- 定义一个变量保存涨前的薪水
  psal emp.sal%type;
BEGIN
  SELECT sal INTO psal FROM emp WHERE empno = eno;
  
  -- 注意：一般不在存储过程和存储函数中，commit 和 rollback，事务控制交给调用者
  UPDATE emp SET sal = sal + 100 WHERE empno = eno;

  dbms_output.put_line('涨前薪水：' || psal || '，涨后薪水：' || (psal + 100));
END;


BEGIN
  -- 在这里提交，要保证两个人同时涨工资，这也解释了为什么一般不在存储过程里面做事务控制
  raiseSalary(7839);
  raiseSalary(7566);
  COMMIT;
END;
```



&emsp;&emsp;如何使用PLSQL Developer 调试存储过程，Oracle用户scott用户调试存储过程，需要有Debug的权限，所以登录到sys用户，为scott用户授权：

```plsql
grant dba to scott;  -- 也可以就授予Debug的权限
```



![image-20200531215509638](C:\Users\86187\AppData\Roaming\Typora\typora-user-images\image-20200531215509638.png)

![image-20200531215535789](C:\Users\86187\AppData\Roaming\Typora\typora-user-images\image-20200531215535789.png)

![image-20200531215634996](C:\Users\86187\AppData\Roaming\Typora\typora-user-images\image-20200531215634996.png)



## 二、存储函数

&emsp;&emsp;函数（Function）为一命名的存储程序，可带参数，并返回一计算值。函数和存储过程结构类似，但必须有一个RETURN子句，用于返回函数值。

存储函数的简化语法：

```plsql
CREATE [OR REPLACE] FUNCTION 函数名（参数列表）

RETURN 函数值类型

AS

PLSQL 子程序;
```



**第一个例子：查询员工的年薪**

```plsql
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
```



&emsp;&emsp;一般来讲，存储过程和存储函数的区别在于存储函数可以有一个返回值；而存储过程没有返回值。

&emsp;&emsp;过程和函数都可以通过out指定一个或多个输出函数。我们可以利用out参数，在过程和函数中实现返回多个值。

- &emsp;&emsp;存储过程和存储函数都可以有out参数；
- &emsp;&emsp;存储过程和存储函数都可以有多个out参数；
- &emsp;&emsp;存储过程可以通过out参数来实现返回值。

&emsp;&emsp;原则上：如果只有一个返回值，则使用存储函数；否则，就用存储过程。



**OUT参数的使用**

```plsql
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
```

































