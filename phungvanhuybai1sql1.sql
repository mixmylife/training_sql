--Bai2

SELECT country_id  as diachi,
       country_name  ten_que_quan
FROM Countries;

SELECT *
From employees;

SELECT *
From Customers;

SELECT * 
From orders;

SELECT *
From products;

SELECT employee_id, first_name, last_name, email, hire_date 
from employees;

SELECT customer_id, name, address
from customers;

SELECT order_id, customer_id, order_date, salesman_id
from orders;

SELECT product_id, product_name, description
from products;

SELECT employee_id as Ma_Nhan_Vien,
       first_name Ten_Goi,
       last_name  Ten_Ho,
       Email as Thu_Dien_Tu,
       hire_date  Ngay_Nhan_Viec
From employees;       


SELECT customer_id Ma_Khach_Hang,
       Name Ten_Khach_Hang,
       address Dia_Chi_Khach_Hang
From customers;

SELECT order_id MaDonHang,
       customer_id MaKhachHang,
       order_date NgayDatHang,
       salesman_id NguoiBan
From orders;

SELECT product_id MaSanPham,
       product_name TenSanPham,
       description  Mota
From products;

SELECT DISTINCT job_title
From employees;

SELECT DISTINCT first_name 
from employees;

SELECT *
from employees
WHERE employee_id > 50
     and manager_id > 100;  

SELECT 
* from employees 
WHERE employee_id 
BETWEEN 50 and 100
order by employee_id ASC;

SELECT *
From employees 
WHERE employee_id in (22,19,2,55,4);

SELECT First_name
From employees 
WHERE  first_name like in('A','B');
--d% kq tra ve gia tri first_name co D dung dau trong ten
--%d% kq tra ve gia tri first_name co D trong ten
--%d kq tra ve gia tri first_name co D dung cuoi trong ten 
--D%d% kq tra ve gia tri first_name co D dung dau lai co d trong ten
--D___ kq tra ve gia tri first_name cos D dung dau va ten co so ki tu mong muon de tim

SELECT * 
From employees where employee_id=28;

SELECT *
from employees 
where email = 'abigail.palmer@example.com'
and phone = '650.505.4876';

SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = 'Elliot'
OR LAST_NAME = 'Cooper';

SELECT *
FROM CUSTOMERS
WHERE	CREDIT_LIMIT >1000;

SELECT *
FROM CUSTOMERS
WHERE	CREDIT_LIMIT >=2000;

SELECT *
FROM CUSTOMERS
WHERE	CREDIT_LIMIT <3200;

SELECT *
FROM CUSTOMERS
WHERE	CREDIT_LIMIT <=2400;

SELECT *
FROM ORDERS
WHERE ORDER_DATE > TO_DATE('2017-01-01', 'YYYY/MM/DD');

SELECT *
from orders 
where order_date BETWEEN TO_DATE ('2017-01-01', 'YYYY/MM/DD') 
and to_date ('2019-01-01','YYYY/MM/DD')
order by order_id asc;

SELECT * 
from orders 
where  order_date >= TO_DATE ('2017-01-01','YYYY/MM/DD')
or    order_date <= to_date ('2015-12-31', 'YYYY/MM/DD');

select * from orders 
where extract (year from order_date) >= 2017;

SELECT * 
From Customers 
where name like 'American%';

SELECT * 
from customers 
where name like '%co';
 
SELECT 
 *from customers 
where name like '%ba%' or name  like '%meri%';

SELECT *
from customers 
where name like 'L____';

SELECT *
from customers 
where name like '__P';

SELECT *
from customers 
where name like '____n%';

SELECT *from 
products 
where product_name in ('Intel Xeon E5-2699 V3',
'Intel Core i7-4960X Extreme Edition',
'Intel Core 2 Extreme QX9775');

SELECT * 
From products;

SELECT *from products where product_id = 225;

SELECT *from products where standard_cost >300;

SELECT *from products where standard_cost != 500;

SELECT *from products where list_price BETWEEN 300 and 700
ORDER by list_price asc;

SELECT *from products where product_name = 'G.Skill Trident Z'
and standard_cost > 500;

SELECT *from products where product_name = 'Corsair Dominator Platinum'
and standard_cost >=600 and list_price >700;

SELECT *from products WHERE product_id <500;

SELECT *from products WHERE product_name like '%Kingston%';

SELECT *from products where product_name like 'G.Skill%'
and list_price > 650;

SELECT *from products where product_name like '%Series'
and description like '%128GB%';

SELECT *from products where product_name like 'C______'
and list_price != 700;

SELECT *from products where list_price in (2200,1850,1756,1249);


SELECT *from orders;

SELECT *from orders where order_date BETWEEN TO_DATE('2017-01-01','YYYY/MM/DD')and
TO_DATE('2017-12-31','YYYY/MM/DD');
--hoac
SELECT *from orders where EXTRACT (year from order_date) = 2017;


SELECT *from orders where order_date BETWEEN TO_DATE('2016-01-01','YYYY/MM/DD')and
TO_DATE('2017-01-01','YYYY/MM/DD');

SELECT *from orders where order_date > to_date('2017-02-17','YYYY/MM/DD');

SELECT *from orders where order_date = to_date('2017-05-11','YYYY/MM/DD')
 and status = 'Shipped';
 
 SELECT *from orders where order_date > to_date('2017-08-17','YYYY/MM/DD')
 ORDER by total asc;
 
 SELECT *from orders where order_date > to_date('2017-08-17','YYYY/MM/DD')
 ORDER by total DESC;
 
 SELECT *from orders where status in('Pending','Shipped')
 and total > 400000 
 ORDER by order_date ASC;
 
 
 --Bai3
 
 








 

