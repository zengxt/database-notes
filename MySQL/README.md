# MySQL数据库学习笔记

&emsp;&emsp;MySQL8.0零基础入门之从青铜到钻石：https://www.imooc.com/learn/1281

&emsp;&emsp;MySQL零基础入门之从青铜到钻石：https://www.imooc.com/article/311324

&emsp;&emsp;MySQL零基础入门之从青铜到钻石（二）：https://www.imooc.com/article/312463

<br/>

## 一、MySQL的DDL（Data Definition Language）语句

**操作数据库：**

```mysql
CREATE DATABASE dbname;

CREATE DATABASE IF NOT EXISTS dbname;

CREATE DATABASE dbname CHARACTER SET 字符集;

-- 显示数据库的创建语句
SHOW CREATE DATABASE hello;

-- 修改数据库的字符集格式
ALTER DATABASE dbname DEFAULT CHARACTER SET 字符集；

-- 删除数据库
DROP DATABASE dbname;

-- 查询正在使用的数据库
SELECT DATABASE();

-- 使用数据库
USE dbname;
```

**操作表：**

```mysql
CREATE TABLE tablename (columnName1 datatype, columnName2 datatype...);


CREATE TABLE student(
    id int, 
    name varchar(64), 
    age int, 
    birthday date, 
    sex char(1)
);

SHOW TABLES;

DESC tablename;

-- 查看表的建表语句
SHOW CREATE TABLE tablenmae;

-- 快速创建一个表结构相同的表
CREATE TABLE newTableName LIKE oldTableName;

DROP TABLE tablename;
DROP TABLE IF EXISTS tablename;

ALTER TABLE tablename ADD columnname datatype;
ALTER TABLE tablename MODIFY columnname newdatatype;
ALTER TABLE tablename CHANGE oldColumnName newColumnName datatype;

ALTER TABLE tablename DROP columnname;

-- 修改表名
RENAME TABLE oldTableName TO newTableName;

-- 修改字符集
ALTER TABLE tableName CHARACTER SET characterSetName;
```

<br/>

## 二、MySQL的DML（Data Manipulation Language）语句

**插入数据：**

```mysql
INSERT INTO tableName(columnName1, columnName2, ...) VALUES(value1, value2, ...)

-- 值与字段必须对应，个数相同，类型相同
-- 值的数据大小必须在字段的长度范围内
-- 除了数值类型外，其他的字段类型的值必须使用引号引起。（建议使用单引号）
-- 如果要插入空值，可以不写字段，或者插入null

INSERT INTO student(id, name, age, birthday, sex) VALUES(1, '张三', 23, '1996-12-06', '男');
INSERT INTO student VALUES(2, '李四', 23, '1996-12-06', '男');
INSERT INTO student(id, name, age) VALUES(3, '王老五', 56);
```

**蠕虫复制：**

```mysql
-- 该建表语句只会创建相同的表结构，不会复制数据
CREATE TABLE newTableName LIKE oldTableName; 

INSERT INTO tablename SELECT * FROM tablename2;
```

**操作表记录：**

```mysql
UPDATE tableName SET columnName1 = value1;
UPDATE tableName SET columnName1 = value1 WHERE columnName2 = value2;

DELETE FROM tableName;
DELETE FROM tableName WHERE columnName1 = value1;

-- truncate 删除表记录
TRUNCATE tablename;
-- delete是将表中的数据一条条删除；
-- truncate是将整个表摧毁，重新创建一个新的表结构和原来表结构一模一样
```

<br/>

## 三、MySQL的DQL（Data Query Language）语句

**简单查询：**

```mysql
SELECT * FROM student;
SELECT id, name, sex, age, birthday FROM student;
SELECT name AS '姓名', age AS '年龄' FROM student;

SELECT DISTINCT columnName FROM tableName;

-- 查询结果参与运算
SELECT columnName + 固定值 FROM tableName;
SELECT columnName1 + columnName2 FROM tableName; -- 参与运算的必须是数值类型
```

**聚合函数：**

count：统计指定列记录数，记录为NULL的不统计；

sum：计算指定列的数值和，如果不是数值类型，那么计算结果为0；

max：计算指定列的最大值；

min：计算指定列的最小值；

avg：计算指定列的平均值，如果不是数值类型，那么计算结果为0。

**分组查询：**

```mysql
-- 分组查询是指使用GROUP BY语句对查询信息进行分组，相同数据作为一组
SELECT columnName1, columnName2... FROM tableName GROUP BY columnName [HAVING condition]

-- WHERE 是分组前过滤，HAVING是分组后过滤，所以聚合函数只能使用在HAVING子句中，而不能用在WHERE子句
SELECT sex, COUNT(*) FROM hero WHERE age < 30 GROUP BY sex HAVING COUNT(*) > 2;
```

**LIMIT分页：**

```mysql
SELECT *|字段列表 [AS 别名] FROM 表名 [WHERE 子句] [GROUP BY子句] [HAVING 子句] [ORDER BY 子句] [LIMIT 子句]
-- limit 子句为什么排在最后，因为前面的限制条件都处理完了，才能处理显示多少条记录的问题

LIMIT语法格式
LIMIT offset , length; 或者 LIMIT length;
offset 是指偏移量，可以认为是跳过的记录数量，默认为0
length 是指需要显示的总记录数

-- 分页
SELECT * FROM hero LIMIT 0, 5;
SELECT * FROM hero LIMIT 5, 5;
SELECT * FROM hero LIMIT 10, 5;
```

<br/>

## 四、数据库约束

主键自增：AUTO_INCREMENT

>DELETE 删除表中的数据，但不重置AUTO_INCREMENT的值
>
>TRUNCATE摧毁表，重建表，AUTO_INCREMENT重置为1。

唯一约束：可以插入多个NULL，因为NULL表示没有值，所以不存在唯不唯一的问题

<br/>