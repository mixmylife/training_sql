select *from contacts;
select *from customers;
select *from employees;
select *from orders;
select *from order_items;
select *from products;
select *from product_categories;
select *from inventories;
select *from warehouses;
select *from locations;
select *from countries;
select *from regions;




--3.1
select   
       bang1.nhomsanpham,
       bang1.name,
       bang1.doanhthu,
       bang1.phone
from 
(select    
       cat.category_name nhomsanpham,
       c.name,
       (oi.quantity * oi.unit_price) doanhthu,
       con.phone,
       rank() over (PARTITION BY cat.category_name  order by (oi.quantity * oi.unit_price) desc) sapxep          
from product_categories cat
join products p
on p.category_id = cat.category_id
join order_items oi
on oi.product_id = p.product_id 
join orders o
on o.order_id = oi.order_id
join customers c
on c.customer_id = o.customer_id 
join contacts con
on con.customer_id = c.customer_id) bang1
where bang1.sapxep = 1 ;




--3.2
select c.name,
       c.website,
       p.product_name,
       (oi.quantity * oi.unit_price) doanhthu
from customers C
join orders O 
on o.customer_id = c.customer_id
join order_items oi
on oi.order_id = o.order_id 
join products p
on p.product_id = oi.product_id
order by (oi.quantity * oi.unit_price) desc
FETCH FIRST 3 rows only
;


--3.3
select bang3.nhomsanpham,
       bang3.tensanpham,
       bang3.doanhthusanpham,
       bang3.tongdoanhthutheonhom,
       round((bang3.doanhthusanpham/bang3.tongdoanhthutheonhom),5) ||'%' tylephantram,
       sum(tongdoanhthutheonhom) over() tongcong
       from
(select Cat.category_name nhomsanpham,
       p.product_name tensanpham,
       (oi.quantity * oi.unit_price) doanhthusanpham,
        rank() over (PARTITION BY cat.category_name  order by (oi.quantity * oi.unit_price) desc) sapxep,
        sum((oi.quantity * oi.unit_price) )over (partition by Cat.category_name ) tongdoanhthutheonhom
from product_categories Cat
join products P
on p.category_id = cat.category_id
join order_items oi
on p.product_id = oi.product_id) bang3
group by bang3.nhomsanpham,
       bang3.tensanpham,
       bang3.doanhthusanpham,
       bang3.tongdoanhthutheonhom
       ;



--3.4


select o.order_date thang,
       c.name tenkhachhanglandau,
       con.phone,
       (oi.quantity * oi.unit_price) doanhso,
       rank() over (order by o.order_date asc) sapxep
from contacts con
join customers c
on c.customer_id = con.customer_id
join orders o
on o.customer_id = c.customer_id
join order_items oi
on oi.order_id = o.order_id
GROUP BY GROUPING SETS(o.order_date);








-- Cau 1:
-- Lấy ra tất cả các nhóm sản phẩm, tên khách hàng,
--doanh thu và phone của người có doanh thu cao nhất
--theo từng nhóm sản phẩm.

-- Bafi ladm
select groups_name, name, doanhthu, phone
from (
    select  pc.category_name  groups_name,
            co.first_name || ' ' || co.last_name Name,
            sum(oi.quantity*oi.unit_price) doanhthu,
            co.phone phone,
            row_number() OVER (PARTITION by pc.category_name ORDER BY sum(oi.quantity*oi.unit_price) desc) rank
    from product_categories pc
        join products p on p.category_id = pc.category_id
        join order_items oi on oi.product_id = p.product_id
        join orders o on o.order_id = oi.order_id
        join customers c on c.customer_id = o.customer_id        
        join contacts co on co.customer_id = c.customer_id
    group by pc.category_name,co.first_name,co.last_name,co.phone) subquery
where rank = 1;


--Bai2: Lấy ra tên khách hàng, website và 3 sản phẩm có doanh thu cao nhất của khách hàng đó

select co.first_name || ' ' || co.last_name Name, 
        c.website, p.product_name, r.doanhthu

from customers c
join
    (select       o.customer_id customer_id
                , oi.product_id product_id
                , oi.quantity*oi.unit_price doanhthu
                , row_number() over (PARTITION by o.customer_id order by oi.quantity*oi.unit_price desc) as row_num
     from orders o
     join order_items oi
        on o.order_id = oi.order_id
    ) r
    on c.customer_id = r.customer_id
join contacts co 
    on co.customer_id = c.customer_id
join products p
    on p.product_id = r.product_id
where r.row_num <= 3
;

-- 3.3: Lấy ra tên nhóm sản phẩm, tên sản phẩm, tổng doanh thu sản phẩm,
--tổng doanh thu nhóm sản phẩm, phần trăm (doanh thu sản phẩm/doanh thu nhóm sản phẩm)
-- và thêm 1 dòng tổng cộng ở cuối dòng.

select DISTINCT  pc.category_name
        ,p.product_name
        ,sum(oi.quantity*oi.unit_price) over (PARTITION by p.product_name) doanhthu
        ,sum(oi.quantity*oi.unit_price) over (PARTITION by pc.category_name) tongdt
        ,round((sum(oi.quantity*oi.unit_price) over (PARTITION by p.product_name))*100/(sum(oi.quantity*oi.unit_price) over (PARTITION by pc.category_name)),2) phantram
from product_categories pc
join products p
    on p.category_id = pc.category_id
join order_items oi
    on oi.product_id = p.product_id
group by pc.category_name,p.product_name, oi.quantity,oi.unit_price
order by pc.category_name
;



-- 4 Tìm ra các khách hàng lần đầu tiên mua hàng trong tháng, hiển thị ra
--: tháng, tên khách hàng, phone, doanh số. thêm một dòng tổng ở mỗi tháng

select  to_char(o.order_date, 'MM/YYYY') as montd
        ,co.first_name || ' ' || co.last_name as nameKH
        ,co.phone as phone
        ,sum(oi.quantity*oi.unit_price) doanhso
from contacts co
join  customers c
    on co.customer_id = c.customer_id
join orders o 
    on o.customer_id = c.customer_id
    and o.customer_id = co.customer_id
join order_items oi
    on oi.order_id = o.order_id
where o.order_date >=  TRUNC(o.order_date, 'MM')
--(select min(o2.order_date) 
--                      from orders o2 
--                      where to_char(o2.order_date,'MM/YYYY') = 
--                      to_char(o.order_date, 'MM/YYYY'))
group by to_char(o.order_date, 'MM/YYYY')
        ,co.first_name || ' ' || co.last_name
        ,co.phone
order by nameKH--to_char(o.order_date, 'MM/YYYY')
;

-- bài 5: Chọn một tháng bất kỳ, lấy ra tên kh, phone thỏa mãn điều kiện
-- trước đây có mua hàng nhưng trong 2 tháng gần nhất với tháng dược chọn
--không mua gì.
SELECT * FROM ORDERS;

select co.first_name || ' ' || co.last_name as nameKH, co.phone,
o.order_date,c.customer_id
from customers c
join contacts co
    on co.customer_id = c.customer_id
left join orders o
        on o.customer_id = c.customer_id
where o.order_date between ADD_MONTHS(TRUNC(TO_DATE('01-May-2017', 'DD-MON-YYYY'), 'MM'), -2)
            AND lAST_DAY(ADD_MONTHS(TRUNC(TO_DATE('01-May-2017', 'DD-MON-YYYY'), 'MM'), -1))
            and c.customer_id NOT IN (
            SELECT DISTINCT o2.customer_id
            FROM ORDERS o2
            WHERE o2.order_date >= TRUNC(TO_DATE('01-may-2017', 'DD-MON-YYYY'), 'MM')
            );
