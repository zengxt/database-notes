-- ��ֵ����
-- 1����������
select ROUND(45.943, 2) "С�������λ", -- 45.94
       ROUND(45.943, 0) "��λ",         -- 46
       ROUND(45.943) "��λ",            -- 46
       ROUND(45.943, -1) "ʮλ"         -- 50
from dual;


-- 2��ȡ������
select CEIL(45.143) from dual;        -- ����ȡ�� 46
select FLOOR(45.943) from dual;       -- ����ȡ�� 45


-- 3�����ü���
-- abs ȡ����ֵ
select ABS(45.143) from dual;          -- 45.143
select ABS(-45.143) from dual;         -- 45.143
select ABS(0) from dual;               -- 0

-- ����
select MOD(5, 2) from dual;            -- 1
select MOD(5, null) from dual;         -- null

-- ����
select POWER(2, 3), POWER(null, 3) from dual; -- 8 null

-- ��ƽ����
select SQRT(16) from dual;         -- 4

-- �ض�
select TRUNC(45.943, 2) "С�������λ",       -- 45.94
       TRUNC(45.943, 0) "��λ",               -- 45
       TRUNC(45.943) "��λ",                  -- 45
       TRUNC(45.943, -1) "ʮλ"               -- 40
from dual;


-- 4�����Ǻ���
select SIN(3.14) from dual;

