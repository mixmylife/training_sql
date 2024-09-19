/*1.	Lấy ra thông tin sản phẩm và giá bán trung bình của những sản phẩm đó.*/
SELECT product_id, product_name,
(SELECT avg (unit_price) 
FROM ORDER_ITEMS A 
WHERE A.product_id = P.product_id) GIABANTRUNGBINH
FROM PRODUCTS P;

/*2.	Lấy ra những sản phẩm chưa từng được bán*/
Select product_id, product_name
from products prd
where not exists (
    select product_id from order_items oit
    where prd.product_id = oit.product_id);
					
/*3.	Lấy ra những sản phẩm đang không tồn kho*/
SELECT product_id, product_name
FROM PRODUCTS prd
WHERE not exists ( 
	SELECT product_id from INVENTORIES inv
    where prd.product_id = inv.product_id);
/*4.	Lấy ra những khách hàng đã từng mua hàng trong năm 2016 đến 2017*/
SELECT customer_id, name 
FROM CUSTOMERS c 
WHERE EXISTS (
    SELECT customer_id 
    FROM ORDERS o WHERE o.customer_id = c.customer_id
    AND extract(year from o.order_date) BETWEEN 2016 and 2017); 
	
/*5.	Lấy ra những khách hàng chưa từng mua hàng trong năm 2017*/
SELECT customer_id, name 
FROM CUSTOMERS c 
WHERE NOT EXISTS (
    SELECT customer_id 
    FROM ORDERS o WHERE o.customer_id = c.customer_id
    AND extract(year from o.order_date) = 2017);
/*6.	Tìm tất cả các khách hàng có hạn mức tín dụng nhiều hơn hạn mức trung bình của tất cả các khách hàng*/
SELECT customer_id , name, credit_limit FROM CUSTOMERS 
WHERE credit_limit > 
(SELECT round(avg(credit_limit),1) FROM CUSTOMERS) 
ORDER BY credit_limit asc; 

/*7.	 Sử dụng With để thực hiện yêu cầu sau:
-	Lấy ra thông tin khách hàng (Mã khách hàng, Tên khách hàng) đã từng mua hàng và có tổng số lượng sản phẩm/đơn > 50 đơn vị và ngày đặt hàng lớn hơn 10/02/2017  
-   Tìm ra khách hàng có tổng số lượng sp lớn nhất trong list khách hàng trên
*/   
WITH TTKH AS (
SELECT c.customer_id, c.name, sum(oi.quantity) as Tongsp
FROM CUSTOMERS c 
JOIN ORDERS o ON c.customer_id = o.customer_id 
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
WHERE o.status = 'Shipped' AND o.order_date > TO_DATE('2017-02-10', 'YYYY-MM-DD')
GROUP BY c.customer_id, c.name
HAVING sum(oi.quantity) > 50
ORDER BY Tongsp desc) 
SELECT customer_id as Makhachhang, name as Tenkhachhang 
FROM TTKH
ORDER BY Tongsp DESC
FETCH FIRST 1 ROWS ONLY;
      
/*8.	Sử dụng lệnh With để thực hiện yêu cầu sau:
-	1 truy vấn Doanh_thu_SP: Mã sản phẩm, tên sản phẩm, Doanh thu (tổng tiền mà sản phẩm đó bán được)
-	1 truy vấn tính tổng doanh thu toàn bộ các sản phẩm
Trả về kết quả sau: Mã sản phẩm, tên sản phẩm, Doanh thu, % doanh thu ( = doanh thu / tổng doanh thu)
*/
WITH Doanh_thu_SP as ( 
	SELECT 
	p.product_id, p.product_name , sum( o.total) as Doanhthu
	FROM PRODUCTS p, ORDER_ITEMS oi, ORDERS o 
	WHERE p.product_id = oi. product_id 
	AND oi.order_id = o.order_id
	GROUP BY p.product_id, p.product_name
),
TDT as ( 
	SELECT 
	sum(total) FROM ORDERS
)
SELECT 
	product_id as Masanpham, 
	product_name  as Tensanpham, 
	Doanhthu, 
	round(Doanhthu/( SELECT sum(total) FROM orders),3) as Phantramdoanhthu
FROM Doanh_thu_SP;

/*9.	Tạo 1 View có tên Cst_Order chứa nội dung sau:Lấy ra thông tin khách hàng (Mã khách hàng, Tên khách hàng) và những đơn hàng đơn đang chờ giao và có tổng số lượng sản phẩm/đơn > 50 đơn vị 
và ngày đặt hàng lớn hơn 10/02/2017. Sắp xếp theo khách hàng
*/
CREATE VIEW CBCst_Order AS
SELECT c.customer_id as Makhachhang, 
c.name as Tenkhachhang, 
sum(oi.quantity) as TongSL
FROM CUSTOMERS c 
INNER JOIN ORDERS o ON o.customer_id = c.customer_id
INNER JOIN ORDER_ITEMS oi ON o.order_id=oi.order_id
WHERE o.status = 'Pending' 
and o.order_date > TO_DATE ('2017-02-10', 'YYYY-MM-DD')
GROUP BY c.customer_id, c.name
HAVING sum(oi.quantity) > 50
ORDER BY c.customer_id, c.name;

/*10.	Tạo 1 View có tên Cst_Order chứa nội dung sau: Lấy ra top 100 sản phẩm đang tồn ít nhất theo từng quốc gia 
( Mã sản phẩm, Tên sản phẩm, tên kho tồn,  quốc gia kho, tổng sl tồn tại kho)
*/
CREATE VIEW CBCst_Order1 AS
SELECT p.product_id as Masanpham, 
p.product_name as Tensanpham, 
wh.warehouse_name as Tenkhoton, 
coun.country_name as Quocgiakho, 
sum(inv.quantity) as Tongslton
FROM PRODUCTS p 
INNER JOIN INVENTORIES inv ON p.product_id = inv.product_id
INNER JOIN WAREHOUSES wh ON inv.warehouse_id = wh.warehouse_id
INNER JOIN LOCATIONS lo ON wh.location_id = lo.location_id
INNER JOIN COUNTRIES coun ON coun.country_id = lo.country_id
WHERE inv.quantity is not null 
GROUP BY p.product_id, p.product_name,wh.warehouse_name, coun.country_name
ORDER BY Masanpham;