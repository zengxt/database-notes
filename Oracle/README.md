# Oracle数据库学习笔记

&emsp;&emsp;1、数据库发展历史：网状数据结构、层次型数据结构、关系型数据库

&emsp;&emsp;2、实体之间的关系：一对多、一对一、多对对

&emsp;&emsp;3、Oracle数据库的特点：

&emsp;&emsp;&emsp;&emsp;支持大数据库，多用户的高性能的事务处理；

&emsp;&emsp;&emsp;&emsp;Oracle遵守数据存取语言、操作系统、用户接口和网络通信协议的工业标准（SQL）；

&emsp;&emsp;&emsp;&emsp;实施安全性控制和完整性控制；

&emsp;&emsp;&emsp;&emsp;支持分布式数据库和分布处理；

&emsp;&emsp;&emsp;&emsp;具有可移植性、可兼容性和可连续性；

&emsp;&emsp;&emsp;&emsp;全球化、跨平台的数据库。

<br/>

## 一、Oracle的数据字典

&emsp;&emsp;Oracle通过数据字典来管理和展现数据库信息，数据字典通常储存数据库的元数据，是数据库的“数据库”。通常说的数据字典由4部分组成：**内部RDBMS（X）表、数据字典表、动态性能视图（V）和（静态）数据字典视图**。（两表两视图）

&emsp;&emsp;数据字典的命名规则：

![image-20200614173723565](D:\DataBase Program\Oracle\picture\image-20200614173723565.png)

**1，内部RDBMS（X$）表**

&emsp;&emsp;X$表示Oracle数据库的核心部分，这些表用于**跟踪数据库内部信息**，维持数据库的正常运行。X表是加密命名的，而且Oracle不做文档说明。X表是加密命名的，而且Oracle不做文档说明。X表是Oracle数据库的运行基础，在数据库启动时由Oracle应用程序动态创建。比如我们熟知的XBH、XBH、XKSMSP等。研究这些表的最好的办法就是借用Oracle的autotrace功能（**set autotrace trace explain**）。

**2，数据字典表**

&emsp;&emsp;数据字典表（Data dictionary table）用以存储表、索引、约束以及其它**数据库结构的信息**，这些对象通常以“”结尾（例如：TAB”结尾（例如：TAB、OBJ、TS、TS等），在创建数据库的时候通过运行$ORACLE_HOME/rdbms/admin/sql.bsq脚本来创建。sql.bsq是一个非常重要的文件，其中包含了数据字典表的定义及注释说明，应仔细阅读研究。

**3，静态数据字典视图**

&emsp;&emsp;由于X$表和数据字典表通常不能直接被用户访问，Oracle创建了静态数据字典视图来提供用户对于数据字典信息的访问，由于这些信息通常相对稳定，不能直接修改，所以又被称为静态数据字典视图。静态数据字典视图在创建数据库时由$ORACLE_HOME/rdbms/admin/catagory.sql脚本创建。

&emsp;&emsp;静态数据字典视图按照前缀的不同通常分成三类：

&emsp;&emsp;● USER_：用户所拥有的相关对象信息；_

_&emsp;&emsp;● ALL_：用于有权限访问的所有对象的信息；

&emsp;&emsp;● DBA_：数据库所有相关对象的信息，用于需要有 select any table 的权限才能访问。

&emsp;&emsp;通过三类视图在本质上是为了实现权限控制。在Oracle数据库中，每个用户与方案（Schema）是对应的，Schema是用户所拥有的对象的集合。数据库通过Schema将不同用户的对象隔离开来，用户可以自由的访问自己的对象，但是要访问其他Schema对象就需要相关的授权。

**4，动态性能视图**

&emsp;&emsp;动态性能视图记录了数据库运行时信息和统计数据，大部分动态性能视图被实时更新以及反映数据库当前状态。在数据库启动时，Oracle动态创建X$表，在此基础上，Oracle创建了GV$和V$视图，GV$即Global V$，除了一些特例外，每个V$都对应一个GV$。GV$产生是为了OPS/RAC环境的需要，每个V$都是基于GV$的，只是GV$多了INST_ID列来显示实例ID。

<br/>


## 二、Oracle开发基础

&emsp;&emsp;1、Oracle数据库中有一个测试用户soctt，将它开启，可以使用其中的一些基本测试数据。默认密码是tiger，也可以自己设置。

&emsp;&emsp;启用或者锁定某个用户：alter user username account unlock/lock;

&emsp;&emsp;2、登录数据库：\[username\]/\[password\]\[@server\]\[as sysdba|sysoper\];

&emsp;&emsp;例如：system/root@orcl as sysdba;  【其中orcl就是自己设置的服务名】。

&emsp;&emsp;show user可以查看当前登录用户

![image-20200614143038128](D:\DataBase Program\Oracle\picture\image-20200614143038128.png)

&emsp;&emsp;dba_users和user_users数据字典中存储了有关用户的信息。

![image-20200614143636786](D:\DataBase Program\Oracle\picture\image-20200614143636786.png)

&emsp;&emsp;在SQLPlus中，SQLPlus命令并不要求以分号结尾，例如show user，desc等，但是sql 语句必须以分号结尾。

&emsp;&emsp;3、desc命令（description）可以查看Oracle数据库中对象的结构。

&emsp;&emsp;4、dual是Oracle中的虚表，通常用来构成SELECT语句的完整格式。

&emsp;&emsp;5、在PL/SQL Developer中，有的时候执行输出语句并不显示，原因可能是没有打开输出开关，执行一下：set serveroutput on，即可。



<br/>

## 三、Oracle的表空间

&emsp;&emsp;表空间是数据库的逻辑存储空间，一个数据库可以有多个表空间，实际上数据库中所有的数据都是保存在表空间的数据库文件中的。

&emsp;&emsp;表空间的分类：

- &emsp;&emsp;永久表空间：数据库中需要永久存放的数据库对象，例如表、视图、存储过程等；
- &emsp;&emsp;临时表空间：存储数据库中某些操作的中间执行过程，当操作执行完毕，存放的内容会被自动释放掉；
- &emsp;&emsp;UNDO表空间：用来保存数据库事务修改之前的数据，这样就可以对数据进行回滚。



&emsp;&emsp;查看用户的表空间：dba_tablespaces和user_tablespaces数据字典中分别保存了系统和用户的表空间信息。

![image-20200614165800497](D:\DataBase Program\Oracle\picture\image-20200614165800497.png)

&emsp;&emsp;查看用户的默认表空间和临时表空间：

```sql
SELECT DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE FROM DBA_USERS WHERE USERNAME='SYSTEM';
```

![image-20200614170508020](D:\DataBase Program\Oracle\picture\image-20200614170508020.png)

&emsp;&emsp;修改用户的默认和临时表空间：

```sql
ALTER USER user_name DEFAULT|TEMPORARY TABLESPACE tablespace_name;
```

<br/>

**创建表空间：**

```sql
CREATE [TEMPORARY] TABLESPACE tablespace_name TEMPFILE|DATAFILE 'xx.dbf' SIZE xx;
```

&emsp;&emsp;文件名称，如果不指定路径，则默认存放在Oracle的安装目录下。

&emsp;&emsp;dba_data_files数据字典中保存了表空间相关文件的信息：

![image-20200614172722134](D:\DataBase Program\Oracle\picture\image-20200614172722134.png)

<br/>

**修改表空间：**

设置联机或脱机状态：

```sql
ALTER TABLESPACE tablespace_name ONLINE|OFFLINE;

SELECT status from dba_tablespaces WHERE tablespace_name='system';
```

修改表空间的状态，设置只读或可读写状态（联机状态才能设置）：

```sql
ALTER TABLESPACE tablespace_name READ ONLY | READ WRITE;
```

<br/>

**修改表空间数据文件：**

```sql
-- 添加表空间文件
ALTER TABLESPACE tablespace_name ADD DATAFILE 'xx.dbf' SIZE xx;

-- 删除表空间文件（不能删除初始化的数据文件，如果要删除该数据文件，则需要删除表空间）
ALTER TABLESPACE tablespace_name DROP DATAFILE 'filename.dbf';
```

<br/>

**删除表空间：**

```sql
-- INCLUDING CONTENTS表示连带数据文件也删除，不带该选项则不会删除数据文件
DROP TABLESPACE tablespace_name [INCLUDING CONTENTS]
```

<br/>

## 四、SQL语言简介

&emsp;&emsp;SQL（Structured Query Language）结构化查询语言，关系型数据库的标准语言

&emsp;&emsp;结构化查询语言包含6个部分：

&emsp;&emsp;1、数据查询语言（DQL:Data Query Language）：其语句，也称为“数据检索语句”，用以从表中获得数据，确定数据怎样在应用程序给出。保留字SELECT是DQL（也是所有SQL）用得最多的动词，其他DQL常用的保留字有WHERE，ORDER BY，GROUP BY和HAVING。这些DQL保留字常与其它类型的SQL语句一起使用。

&emsp;&emsp;2、数据操作语言（DML：Data Manipulation Language）：其语句包括动词INSERT、UPDATE和DELETE。它们分别用于添加、修改和删除。

&emsp;&emsp;3、事务控制语言（TCL）：它的语句能确保被DML语句影响的表的所有行及时得以更新。包括COMMIT（提交）命令、SAVEPOINT（保存点）命令、ROLLBACK（回滚）命令。

&emsp;&emsp;4、数据控制语言（DCL）：它的语句通过GRANT或REVOKE实现权限控制，确定单个用户和用户组对数据库对象的访问。某些RDBMS可用GRANT或REVOKE控制对表单个列的访问。

&emsp;&emsp;5、数据定义语言（DDL）：其语句包括动词CREATE，ALTER和DROP。在数据库中创建新表或修改、删除表（CREAT TABLE 或 DROP TABLE）；为表加入索引等。

&emsp;&emsp;6、指针控制语言（CCL）：它的语句，像DECLARE CURSOR，FETCH INTO和UPDATE WHERE CURRENT用于对一个或多个表单独行的操作。

<br/>

## 五、表操作

### 5.1、管理表

&emsp;&emsp;约定：每一列数据必须具有相同数据类型，列名必须唯一。并且每一行数据需要唯一（否则会造成数据冗余）。

#### 5.1.1、数据类型

&emsp;&emsp;oracle中主要的数据类型

&emsp;&emsp;**1、字符型**

&emsp;&emsp;固定长度字符类型：

&emsp;&emsp;CHAR(n)：n最大为2000。

&emsp;&emsp;NCHAR(n)：按照unicode编码存放数据，一般存放汉字会使用它，n最大1000。

&emsp;&emsp;可变长度字符类型：

&emsp;&emsp;VARCHAR2(n)：n最大为4000。

&emsp;&emsp;NVARCHAR2(n)：按照unicode编码存放数据，n最大2000。

&emsp;&emsp;VARCHAR(n)：兼容SQL标准

&emsp;&emsp;**2、数值型**

&emsp;&emsp;NUMBER(p, s)：数据的总长度是p位，小数点后占s位。

&emsp;&emsp;NUMBER(p)：不带小数点的数值

&emsp;&emsp;FLOAT(n)：用于存储二进制数据，浮点型。

&emsp;&emsp;**3、日期型**

&emsp;&emsp;DATE：DATE类型表示范围，公元前4712年1月1日到公元9999年12月31日；

&emsp;&emsp;TIMESTAMP：精确到时间秒。

&emsp;&emsp;**4、其他数据类型**

&emsp;&emsp;BLOB：最大4GB字节的数据，存放二进制数据；

&emsp;&emsp;CLOB：最大4GB字节的数据，以字符串形式存放。

&emsp;&emsp;Oracle的不同数据类型之间的转换，从字符型转换成日期型需要固定的字符格式才能转成功。

![image-20200614215917281](D:\DataBase Program\Oracle\picture\image-20200614215917281.png)

<br/>

#### 5.1.2、创建表

```sql
CREATE TABLE table_name (
	column_name datetype, ...
);
```

```sql
create table users (
	id number(4) primary key,
	name varchar(10),
	password varchar(10),
	sex char(2),
	addr varchar2(40),
	birthday date,
	sal number(8,2)
);
```

<br/>

#### 5.1.3、修改表的结构

添加字段

```sql
ALTER TABLE table_name ADD column_name datetype;

ALTER TABLE users ADD remarks varchar2(100);
```

更改字段数据类型

```sql
ALTER TABLE table_name MODIFY column_name datetype;

ALTER TABLE users MODIFY remarks varchar2(200);
```

删除字段

```sql
ALTER TABLE table_name DROP COLUMN column_name;

ALTER TABLE users DROP COLUMN password;
```

修改字段名

```sql
ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name;

ALTER TABLE users RENAME COLUMN name TO user_name;
```

修改表名

```sql
RENAME table_name TO new_table_name;
```

<br/>

#### 5.1.4、删除表

```sql
-- 又称为截断表，删除表中所有的数据，并不删除表结构，比delete语句效率高
TRUNCATE TABLE table_name;

-- 删除表
DROP TABLE table_name;
```

<br/>

### 5.2、操作表中的数据

#### 5.2.1、添加数据（INSERT INTO）

```sql
INSERT INTO table_name
(column1, column2, ...)
VALUES(value1, value2, ...)

INSERT INTO users VALUES(1, 'zhangsan', '男', '长安街123号', sysdate, 1234.5, '用户1');

-- 向表中指定字段添加值
INSERT INTO users(id, user_name, addr, birthday, sal) 
VALUES(2, 'lisi', '长安街456号', sysdate, 1234.5);
```

为某个字段添加默认值

```sql
-- 创建表时设置默认值
CREATE TABLE default_value (
    id number(6, 0),
    regdate date default sysdate
);

INSERT INTO default_value(ID) VALUES(1);
SELECT * FROM default_value;

-- 修改表的列，设置默认值
ALTER TABLE users MODIFY REMARKS DEFAULT '无';
```

<br/>

#### 5.2.2、复制表数据

在创建表时复制

```sql
CREATE TABLE table_new
AS
SELECT column1, ... | * FROM table_old;

-- 复制指定的列，也可以用 * 复制所有的列
CREATE TABLE user_copy
AS
SELECT id, user_name, birthday FROM users;
```

在添加数据使复制

```sql
INSERT INTO table_new
[(column1, ...)]
SELECT column1, ... | * FROM table_old;

INSERT INTO user_copy
SELECT id, user_name, birthday FROM users;
```

<br/>

#### 5.2.3、修改数据

UPDATE语句

```sql
UPDATE table_name
SET column1 = value1, ...
[WHERE conditions]

-- 更改所有数据
UPDATE user_copy SET birthday = sysdate;

-- 按条件修改
UPDATE user_copy SET USER_NAME = 'wanglaowu' WHERE id = 1;
```

<br/>

#### 5.2.4、删除数据

```sql
-- 删除表中的所有数据
DELETE FROM table_name;

-- 按条件删除
DELETE FROM table_name
[WHERE conditions]
```

<br/>

### 5.3、约束

&emsp;&emsp;约束的作用：定义表列中值的规则，确保数据的完整性。

#### 5.3.1、非空约束

在创建表时设置非空约束

```sql
CREATE TABLE table_name (
	column_name datetype NOT NULL, ...
);
```

修改表时添加非空约束

```sql
ALTER TABLE table_name
MODIFY column_name datetype NOT NULL;
```

修改表时去掉非空约束

```sql
ALTER TABLE table_name
MODIFY column_name datetype NULL;
```

<br/>

#### 5.3.2、主建约束

&emsp;&emsp;主键的作用：确保表当中每一行数据的唯一性，主键约束（包含了非空约束与唯一约束）。一张只能设计一个主键约束，主键约束可以包含多个列，包含多个列的主键称为联合主键。

在创建表时设置主键约束

```sql
-- 没有设置约束名称时，系统会为该主键自动生成一个名字
CREATE TABLE table_name (
	column_name datetype PRIMARY KEY, ...
);

-- 方法二，使用 CONSTRAINT 关键字创建主键约束  (表级约束)
CONSTRAINT constraint_name PRIMARY KEY(column_name1, ...)
```

可以在user_constraints数据字典中查看约束的信息。

```sql
SELECT constraint_name FROM user_constraints;
```

修改表时添加主键约束

<br/>

#### 5.3.3、外键约束



<br/>

#### 5.3.4、唯一约束



<br/>

#### 5.3.5、检查约束



<br/>

## 六、





