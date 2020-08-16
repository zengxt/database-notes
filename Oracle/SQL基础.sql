CREATE TABLE userinfo (
    user_id number(6, 0),
    username varchar2(20),
    userpwd varchar2(20),
    email varchar2(20),
    regdate date
);

create table users (
	id number(4) primary key,
	name varchar(10),
	password varchar(10),
	sex char(2),
	addr varchar2(40),
	birthday date,
	sal number(8,2)
);

select * from users;

ALTER table users ADD remarks varchar2(100);


ALTER TABLE users MODIFY remarks varchar2(200);

ALTER TABLE users DROP COLUMN password;

ALTER TABLE users RENAME COLUMN name TO user_name;

INSERT INTO users VALUES(1, 'zhangsan', '男', '长安街123号', sysdate, 1234.5, '用户1');

INSERT INTO users(id, user_name, addr, birthday, sal) 
VALUES(2, 'lisi', '长安街456号', sysdate, 1234.5);


CREATE TABLE default_value (
    id number(6, 0),
    regdate date default sysdate
);


CREATE TABLE user_copy
AS
SELECT id, user_name, birthday FROM users;

SELECT * FROM user_copy;


INSERT INTO user_copy
SELECT id, user_name, birthday FROM users;

UPDATE user_copy SET birthday = sysdate;

UPDATE user_copy SET USER_NAME = 'wanglaowu' WHERE id = 1;


SELECT * FROM default_value;

ADD CONSTRAINT constraint_name PRIMARY KEY(column_nam1, ...)

ALTER TABLE userinfo ADD CONSTRAINT user_primary_key_id PRIMARY KEY(user_id);
ALTER TABLE userinfo RENAME CONSTRAINT user_primary_key_id TO user_pk_id;

SELECT * FROM user_constraints;

CREATE TABLE typeinfo(
   typeId varchar2(10) primary key,
   typeName varchar2(20)
);

CREATE TABLE userInfo_f(
   id varchar2(10) primary key,
   username varchar2(20),
   user_typeId varchar2(10) references typeinfo(typeId)
);

INSERT INTO typeinfo VALUES(1, 3);
-- 外键约束列要么是主表中的值，要么是null值
INSERT INTO userInfo_f(id, username, user_typeId) VALUES(1, 'test1', 1);
INSERT INTO userInfo_f(id, username, user_typeId) VALUES(2, 'test2', null);

-- ORA-02291: 违反完整约束条件 (SCOTT.SYS_C0011805) - 未找到父项关键字
INSERT INTO userInfo_f(id, username, user_typeId) VALUES(3, 'test3', 3);


