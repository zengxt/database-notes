-- ʹ�� Where �Ӿ�����ݽ��й���
select * from emp where deptno = 10;


-- �����ַ��͵����ݺ������͵����ݱ���Ҫʹ�� '' 
-- �ַ��͵����ݶԴ�Сд�����е�
select * from emp where ename='SMITH';


-- ���������͵����ݣ���ʽ�����еģ�ʹ�����������ݵĸ�ʽ�� DD-MM-YYYY����-��-�꣩
select * from emp where hiredate = '20-2��-1981';

-- �ı䵱ǰ�Ự�е����ڸ�ʽ
alter session set nls_date_format = "YYYY-MM-DD HH:MI:SS"

select * from emp where hiredate = '1981-2-20';


-- �ڲ�ѯ������ʹ�������ıȽ������
select * from emp where sal >= 2000;

select * from emp where sal != 3000;
select * from emp where sal <> 3000;


-- ʹ�� between ... and
select * from emp where sal between 2000 and 3000;
-- �ȼ���
select * from emp where sal >= 2000 and sal <= 3000;

-- ʹ�� IN ָ�� �ַ����������͵ķ�Χ
select * from emp where job IN('MANAGER', 'CLERK');
-- �ȼ���
select * from emp where job = 'MANAGER' or job = 'CLERK';


-- LIKE �����ַ������ݵĲ�ѯ������ִ��ģ����ѯ
-- % ��ʾ0������������ַ�
select * from emp where ename like '%A%';
