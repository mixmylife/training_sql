select *from SP;

select *from kho;

select s.id,
       s.ten,
       k.so_luong
       
from sp s
INNER join kho k 
on s.id=k.id;


select s.id,
       s.ten,
       k.so_luong
       
from sp s
right join kho k 
on s.id=k.id;

select s.id,
       s.ten,
       k.so_luong
       
from sp s
left join kho k 
on s.id=k.id;

select s.id,
       s.ten,
       k.so_luong
       
from sp s
full join kho k 
on s.id=k.id;

-- Lấy  thông tin khách hàng bao gồm: Mã khách hàng, Họ và tên khách hàng, địa chỉ, Email, Số điện thoại 
select *from customers;
select *from contacts;

select cus.Customer_id,
       cus.name,
       cus.address,
       con.email,
       con.phone
from customers cus
join contacts con
on cus.customer_id = con.customer_id;


 --Lấy thông tin chi tiết của sản phẩm bao gồm: Tên sản phẩm,
 --Tên danh mục sản phẩm tương ứng (Chỉ lấy những sản phẩm có danh mục sản phẩm)
 select *from products;
 
 select *from product_categories;
 
 select prd.product_name,
        prdcat.category_name
from products prd
left join product_categories prdcat
on prd.category_id = prdcat.category_id; 

/*3. Lấy thông tin nhân viên bao gồm: Mã nhân viên, họ và tên nhân viên,
Mã nhân viên quản lý, họ và tên nhân viên quản lý*/

select *from employees;


SELECT EMP.EMPLOYEE_ID,
	   EMP.FIRST_NAME || EMP.LAST_NAME AS TEN_NHAN_VIEN
       EMP.MANAGER_ID,
	   MNG.FIRST_NAME || MNG.LAST_NAME AS TEN_QUAN_LY
FROM EMPLOYEES EMP
JOIN EMPLOYEES MNG
	ON EMP.manager_id = MNG.employee_id;
    --@@@@@??
    
    
    
 --Lấy thông tin của tất cả đơn hàng gồm các thông tin khách hàng: Mã đơn hàng,
 --Ngày đặt hàng, Họ và tên khách hàng đặt, Địa chỉ khách hàng đã đặt  
 select order_id,
        order_date,
        name,
        address
from orders  ord
join customers cus
 on ord.customer_id = cus.customer_id;
 
 
 -- Lấy thông tin của tất cả đơn hàng gồm các thông tin nhân viên bán: Mã đơn hàng, Ngày đặt hàng,
 --Họ và tên nhân viên bán, Email, Điện thoại (Chỉ lấy những đơn hàng có thông tin nhân viên bán) 
 select *from employees;
 select ord.order_id,
        ord.order_date,
        epl.first_name,
        epl.last_name,
        epl.email,
        epl.phone
from orders ord
join employees epl 
on ord.salesman_id = epl.employee_id;

        
    
--6 Lấy thông tin sản  phẩm và tồn kho tương ứng bao gồm: Tên sản phẩm, Mã kho tồn, 
--SL tồn (Chỉ lấy những sản phẩm có tồn kho (Có trong bảng tồn kho))

Select *from products;
select *from inventories;

select product_name,
       warehouse_id,
       quantity
from products  prd
join inventories inven
on prd.product_id = inven.product_id;

--7. Lấy thông tin chi tiết của sản phẩm bao gồm: Tên sản phẩm, Tên
--danh mục sản phẩm tương ứng (Lấy cả những sản phẩm không có danh mục sản phẩm)
Select *from products;
select *from product_categories;

select product_name,
       category_name
from products prd
left join product_categories prdcat
on prd.category_id = prdcat.category_id;


/*10. Lấy thông tin chi tiết của sản phẩm bao gồm: Tên sản phẩm, Tên danh mục sản
phẩm tương ứng (Lấy cả những danh mục sản phẩm không có tên sản phẩm)*/

select product_name,
       category_name
from products prd
RIGHT join product_categories prdcat
on prd.category_id = prdcat.category_id;



/*12. Lấy thông tin tổng hợp những mã đơn hàng nào đã có thông tin nhân viên bán và mã 
đơn nào chưa có thông tin nhân viên bán (Mã đơn hàng, ngày đặt hàng, Họ và tên nhân viên bán)*/

select *from orders;
select *from employees;

select order_id,
       employee_id
from orders odr
full join employees empl
on empl.employee_id = odr.salesman_id;

/*14. Lấy thông tin của tất cả đơn hàng gồm các thông tin khách hàng: Mã đơn hàng, Ngày
đặt hàng, Họ và tên khách hàng đặt, Địa chỉ khách hàng đã đặt của khách hàng có hạn mức tín dụng >= 500*/


select * from orders;
select *from customers;

select odr.order_id,
       odr.order_date,
       cus.name,
       cus.address
from customers cus
join orders odr
on cus.customer_id = odr.customer_id
where credit_Limit > 500;

/*15. Lấy tất cả thông tin đơn hàng bao gồm: Mã đơn hàng, Ngày đặt hàng,
Họ và Tên khách hàng, Địa chỉ khách hàng, Họ Và Tên Nhân viên bán, 
Số ĐT nhân viên bán, Tổng tiền đơn hàng với Đơn hàng có trạng thái = "Shipped"
và Ngày đặt hàng kể từ ngày 20/1/2017
*/

select *from orders;
select *from customers;
select *from employees;

select odr.order_id,
       odr.order_date,
       cus.name,
       cus.address,
       epl.FIRST_name,
       epl.last_name,
       epl.phone,
       odr.total
from orders odr
join customers cus
on  odr.customer_id = cus.customer_id

join employees epl
on odr.salesman_id = epl.employee_id

where status = 'Shipped';

/*16. Lấy thông tin của tất cả đơn hàng gồm các thông tin nhân viên bán: Mã đơn hàng, Ngày đặt hàng,
Họ và tên nhan viên bán, Email, Điện thoại  với những nhân viên ký hợp đầu sau ngày 1/3/2016*/
SELECT * from orders;
select *from employees;

select ord.order_id,
       ord.order_date,
       epl.first_name,
       epl.last_name,
       epl.email,
       epl.phone,
       epl.hire_date
from orders ord
join employees epl
on ord.salesman_id = epl.employee_id
where epl.hire_date > to_date('05/05/2016','DD/MM/YYYY');


/*17.  Lấy thông tin sản phẩm và tồn kho tương ứng bao gồm: Tên sản phẩm,
Mã kho tồn, SL tồn với những sản phẩm có SL tồn kho >2*/
select *from products;
select *from inventories;


select pro.product_name,
       inven.warehouse_id,
       inven.quantity
from products pro
join inventories inven
on pro.product_id = inven.product_id
where quantity >10;






--Lấy  thông tin khách hàng có địa chỉ kết thúc = ‘MI’
select cus.Name,
       cus.address,
       cus.website,
       cus.credit_limit,
       con.email,
       con.phone
from customers cus 
join contacts  con
 on cus.customer_id = con.customer_id
where address like '%MI';


--Lấy  thông tin khách hàng có hạn mức từ 500 đến 700 và có số điện thoại bắt đầu = ‘+39’
select *from customers;
select cus.Name,
       cus.address,
       cus.website,
       cus.credit_limit,
       con.email,
       con.phone
from customers cus 
join contacts  con
 on cus.customer_id = con.customer_id
 where credit_limit between 500 and 700 
 and phone like '+39%';

--Lấy ra top 10  thông tin khách hàng có hạn mức lớn nhất. Sắp xếp theo thứ tự giảm dần.
--(Hàm lấy Top: FETCH FIRST n ROWS ONLY (n: Số dòng muốn lấy))
select cus.Name,
       cus.address,
       cus.website,
       cus.credit_limit,
       con.email,
       con.phone
from customers cus 
join contacts  con
 on cus.customer_id = con.customer_id
 order by cus.credit_limit desc 
FETCH FIRST 10 ROWS ONLY;

-- sao k dung ham max 


--Tính tổng doanh thu theo từng khách hàng 
select *from orders;
select *from customers;
select cus.customer_id,
       cus.name,
       sum(ord.total)
from customers cus
join orders ord
 on cus.customer_id = ord.customer_id
 group by cus.customer_id,cus.name;

--Tìm ra khách hàng có tổng doanh thu lớn nhất trong năm 2017
select *from orders;
select *from customers;
select cus.customer_id,
       cus.name,
       sum(ord.total) -- sao khong phai max
from customers cus
join orders ord
 on cus.customer_id = ord.customer_id
 where extract (year from order_date) =2017
 group by cus.customer_id,cus.name
   FETCH FIRST 1 ROWS ONLY ;

 


--Tìm ra khách hàng có tổng có doanh thu nhỏ nhất trong năm 2017


--Lấy ra top 10  khách hàng có mức doanh thu trung bình của các đơn lớn nhất. 
--Sắp xếp theo thứ tự tăng dần (Hàm lấy Top: FETCH FIRST n ROWS ONLY (n: Số dòng muốn lấy))



--Tính tổng doanh thu theo từng khách hàng đối với những đơn hàng có trạng thái = ‘Shipped’
--và ngày đặt hàng lớn hơn ngày 1/12017



--Tính tổng doanh thu theo từng khách hàng (Làm tròn đến số thập phân thứ nhất) 
--đối với những đơn hàng có trạng thái = ‘Pending’ và thời điểm đặt hàng từ năm 2015 đến năm 2017



--Tính tổng doanh thu các đơn hàng đã mua của các khách hàng theo từng tháng, năm.
--Sắp xếp theo theo tên khách hàng, tháng, năm mua hàng



--Tính tổng giá trị các đơn hàng đã hủy, đơn hủy lớn nhất, đơn hủy nhỏ nhất theo từng khách hàng, 
--theo từng năm. Sắp xếp theo theo tên khách hàng, năm mua hàng


       
       
    
    
    
       
       
       
