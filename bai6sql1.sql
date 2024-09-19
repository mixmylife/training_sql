select *from nvl_table;

select nvl(name, full_name ) from nvl_table;

-- lấy ra thông tin khách hàng (Mã Khách Hàng, Tên khách Hàng) và những 
--đơn hàng chờ giao và có số lượng sản phẩm/đơn  >500
--đơn vị và ngày đặt hàng lớn hơn 10/02/2017. Sắp xếp theo khách hàng 

select cus.customer_id,
       cus.name ,
       Sum(oi.quantity)
from customers cus 
join orders ord
on ord.customer_id = cus.customer_id
join order_items oi 
 on oi.order_id = ord.order_id
 WHERE ord.status = 'Pending'
 and ord.order_date > to_date('10/02/2017','DD/MM/YYYY')
 group by cus.customer_id,cus.name 
 having Sum(oi.quantity)> 500
 order by cus.customer_id;
 
 
 --Lấy ra thông tin chi tiết 10 sản phẩm có số lượng đơn đặt hàng nhiều nhất trong năm 2017
 --(Tên sản phẩm, sl đơn hàng)
 select *from order_items;
 select *from orders;
 select *from products;
 
 select pro.product_id,
        pro.product_name,
        count(oi.order_id)
        
 from products pro 
 left join order_items oi
 on pro.product_id = oi.product_id
 --on ord.order_id = oi.order_id 
   left join orders ord
   on ord.order_id = oi.order_id
 --on pro.product_id = oi.product_id
 where extract ( year from ord.order_date) =2017
 group by pro.product_id, pro.product_name
 order by  count(oi.order_id) desc
 FETCH FIRST 10 ROWS ONLY;
 
 
 
 SELECT PROD.PRODUCT_ID AS MA_SP
      ,PROD.PRODUCT_NAME AS TEN_SP
      ,COUNT(ORD_ITEM.ORDER_ID) AS SO_LUONG_DON
FROM PRODUCTS PROD, ORDER_ITEMS ORD_ITEM, ORDERS ORD
WHERE PROD.PRODUCT_ID = ORD_ITEM.PRODUCT_ID
      AND EXTRACT(YEAR FROM ORD.ORDER_DATE) ='2017'
GROUP BY PROD.PRODUCT_ID,PROD.PRODUCT_NAME
ORDER BY COUNT(ORD_ITEM.ORDER_ID) DESC, MA_SP ASC
FETCH FIRST 10 ROW ONLY;
 
 --Lấy ra thông tin chi tiết của 20 sản phẩm có số lượng đơn hủy hoặc đang chờ giao nhiều nhất 
 --tính từ ngày 02/10/2016(Tên Sản Phẩm, Sl đơn hàng)
 select *from products;
 select *from order_items;
 select *from orders;
 
 
 select pro.product_id,
       pro.product_name,
       count(oi.order_id)
 from products pro
 join order_items oi
 on oi.product_id = pro.product_id
 join orders ord
 on ord.order_id = oi.order_id
 where status in ('Canceled','Pending') 
      and ord.order_date > to_date('02/10/2016','DD/MM/YYYY')
 group by pro.product_id,pro.product_name
 order by count(oi.order_id) desc
     
 fetch FIRST 20 rows only;
 
 
 SELECT
      PROD.PRODUCT_ID AS MA_SP,
      PROD.PRODUCT_NAME AS TEN_SP,
      COUNT(ORD.ORDER_ID) AS SL_DON_HUY_OR_CHO_GIAO     
FROM PRODUCTS PROD
LEFT JOIN ORDER_ITEMS ORD_ITEM
  ON PROD.PRODUCT_ID = ORD_ITEM.PRODUCT_ID
LEFT JOIN ORDERS ORD
  ON ORD_ITEM.ORDER_ID = ORD.ORDER_ID
WHERE ORD.STATUS IN ('Canceled', 'Pending')
      AND ORD.ORDER_DATE >= TO_DATE('2/10/2016','DD/MM/YYYY')
GROUP BY PROD.PRODUCT_ID, PROD.PRODUCT_NAME
ORDER BY SL_DON_HUY_OR_CHO_GIAO DESC,Ma
FETCH FIRST 20 ROW ONLY;

 
 
 -- 1. Lấy ra thông tin khách hàng (Mã khách hàng,
 --Tên khách hàng) đã mua hàng thành công và có số lượng đơn hàng lớn hơn 3 đơn 
 select *from Customers;
 select *from orders;
 
 select cus.customer_id,
        cus.name,
        count(ord.order_id)
 from customers cus
 join orders  ord
 on ord.customer_id = cus.customer_id
 WHERE status = 'Shipped'
 group by cus.customer_id,cus.name
 having  count(ord.order_id) >3;
 
 
 
SELECT CU.CUSTOMER_ID AS MA_KH,
        CU.NAME AS TEN_KH,
        COUNT(1) AS SO_LUONG_DON
FROM CUSTOMERS CU
INNER JOIN ORDERS ORD
  ON CU.CUSTOMER_ID = ORD.CUSTOMER_ID
WHERE ORD.STATUS ='Shipped'
GROUP BY CU.CUSTOMER_ID, CU.NAME
HAVING COUNT(1) >3
ORDER BY MA_KH;

 
/* 2. Lấy ra thông tin khách hàng (Mã khách hàng, Tên khách hàng) 
đã từng hủy đơn và có số lượng đơn hủy lớn hơn 2 đơn trong năm 2017 */
 select cus.customer_id,
        cus.name,
        count(ord.order_id)
 from customers cus
 join orders  ord
 on ord.customer_id = cus.customer_id
 WHERE status = 'Canceled'
    and extract (year from order_date)=2017
 group by cus.customer_id,cus.name
 having  count(ord.order_id) >2;



SELECT CU.CUSTOMER_ID AS MA_KH,
        CU.NAME AS TEN_KH,
		count (1) as SO_LUONG_DON
FROM CUSTOMERS CU
INNER JOIN ORDERS ORD
  ON CU.CUSTOMER_ID = ORD.CUSTOMER_ID
WHERE 
      ORD.STATUS ='Canceled' AND 
      EXTRACT(YEAR FROM ORD.ORDER_DATE) = '2017'
GROUP BY CU.CUSTOMER_ID, CU.NAME
HAVING COUNT(1)>0
ORDER BY MA_KH;


/*3.Lấy ra thông tin khách hàng (Mã khách hàng, Tên khách hàng) 
đã mua hàng thành công và mua tổng sản phẩm > 10 sản phẩm*/

select *from customers;
select *from orders;


select cus.customer_id,
       cus.name,
       count(ord.order_id)
from customers cus
join orders ord
on ord.customer_id = cus.customer_id
join order_items oi
on oi.order_id = ord.order_id
where status = 'Shipped'
group by cus.customer_id,cus.name
having count(ord.order_id) >10 ;


SELECT CUS.CUSTOMER_ID AS MA_KH,
       CUS.NAME AS TEN_KH,
       COUNT(ORD_ITEM.PRODUCT_ID) AS SO_SP
FROM   CUSTOMERS CUS, ORDERS ORD,ORDER_ITEMS ORD_ITEM
WHERE  CUS.CUSTOMER_ID = ORD.CUSTOMER_ID
       AND ORD.ORDER_ID = ORD_ITEM.ORDER_ID 
       AND ORD.STATUS = 'Shipped'
GROUP BY CUS.CUSTOMER_ID,CUS.NAME
HAVING COUNT(ORD_ITEM.PRODUCT_ID) >10;


/*4.	LẤY RA THÔNG TIN KHÁCH HÀNG (MÃ KHÁCH HÀNG, TÊN KHÁCH HÀNG) VÀ NHỮNG
ĐƠN HÀNG ĐƠN ĐANG CHỜ GIAO VÀ CÓ TỔNG SỐ LƯỢNG SẢN PHẨM/ĐƠN 
>50 ĐƠN VỊ VÀ NGÀY ĐẶT HÀNG LỚN HƠN 10/02/2017. SẮP XẾP THEO KHÁCH HÀNG */
SELECT CUS.CUSTOMER_ID AS MA_KH,
       CUS.NAME AS TEN_KH,
       ORD_ITEM.ORDER_ID AS ORDER_ID,
       SUM(ORD_ITEM.QUANTITY) AS LUONG_SP
FROM   CUSTOMERS CUS
 join ORDERS ORD
on CUS.CUSTOMER_ID = ORD.CUSTOMER_ID
 join ORDER_ITEMS ORD_ITEM
       on ORD.ORDER_ID = ORD_ITEM.ORDER_ID 
where
       ORD.STATUS = 'Pending'
       AND ORD.ORDER_DATE > TO_DATE('10/02/2017','DD/MM/YYYY')
GROUP BY CUS.CUSTOMER_ID,CUS.NAME,ORD_ITEM.ORDER_ID
HAVING SUM(ORD_ITEM.QUANTITY) > 50
ORDER BY MA_KH;




/*5.	Lấy ra báo cáo chi tiết sản phẩm theo các tiêu chí sau:
Tổng số lượng bán, Tổng giá trị bán, trung bình giá trị bán 
(Nếu sp chưa từng bán thì mặc định là 0) */
SELECT PROD.PRODUCT_ID AS MA_SP,
      PROD.PRODUCT_NAME AS TEN_SP,
      NVL(SUM(ORD_ITEM.QUANTITY),0) AS TONG_LUONG_BAN,
      NVL(SUM(ORD_ITEM.QUANTITY*ORD_ITEM.UNIT_PRICE),0) AS TONG_GTR_BAN,
      NVL(ROUND(AVG(ORD_ITEM.QUANTITY*ORD_ITEM.UNIT_PRICE),2),0) AS TB_GT_BAN
FROM PRODUCTS PROD
LEFT JOIN ORDER_ITEMS ORD_ITEM
  ON PROD.PRODUCT_ID = ORD_ITEM.PRODUCT_ID
GROUP BY PROD.PRODUCT_ID,PROD.PRODUCT_NAME
ORDER BY MA_SP;

/*8.	LẤY RA BÁO CÁO NHỮNG DANH MỤC SẢN PHẨM THEO
SỐ LƯỢNG ĐƠN BÁN HÀNG TRONG VÒNG 3 THÁNG ĐẦU NĂM 2017 */
/*(TÊN DANH MỤC SẢN PHẨM, SL ĐƠN BÁN HÀNG)
DUNG LEFT JOIN*/
SELECT PROD_CAT.CATEGORY_ID AS MA_DM,
        PROD_CAT.CATEGORY_NAME AS TEN_DM,
        COUNT(ORD_ITEM.QUANTITY) AS SO_LUONG_DON        
FROM PRODUCT_CATEGORIES PROD_CAT
LEFT JOIN PRODUCTS PROD  
  ON PROD_CAT.CATEGORY_ID = PROD.CATEGORY_ID
LEFT JOIN ORDER_ITEMS ORD_ITEM            
  ON PROD.PRODUCT_ID = ORD_ITEM.PRODUCT_ID
LEFT JOIN ORDERS ORD
  ON ORD_ITEM.ORDER_ID = ORD.ORDER_ID
WHERE ORD.ORDER_DATE  BETWEEN TO_DATE('1/1/2017','DD/MM/YYYY') 
                      AND ADD_MONTHS(TO_DATE('1/1/2017','DD/MM/YYYY'),3)
GROUP BY PROD_CAT.CATEGORY_ID,PROD_CAT.CATEGORY_NAME
ORDER BY MA_DM;


/*9.	LẤY RA BÁO CÁO CHI TIẾT SẢN PHẨM ĐANG KHÔNG
CÓ TỒN KHO (MÃ SẢN PHẨM, TÊN SẢN PHẨM)*/

SELECT 
    PRD.PRODUCT_ID, PRD.PRODUCT_NAME, SUM (INV.QUANTITY) SL_TONKHO
FROM PRODUCTS PRD
LEFT JOIN INVENTORIES INV
    ON PRD.PRODUCT_ID = INV.PRODUCT_ID
GROUP BY PRD.PRODUCT_ID, PRD.PRODUCT_NAME
HAVING SUM (INV.QUANTITY) IS NULL OR SUM (INV.QUANTITY) = 0;




/*10.	Lấy ra báo cáo chi tiết các sản phẩm 
theo danh mục sản phẩm đang không có tồn kho
(Mã sản phẩm, Tên sản phẩm, Tên danh mục sản phẩm)*/
SELECT PRO.PRODUCT_ID AS MA_SP, 
      PRO.PRODUCT_NAME AS TEN_SP,
      PROD_CAT.CATEGORY_NAME
FROM PRODUCTS PRO
LEFT JOIN INVENTORIES INV
  ON PRO.PRODUCT_ID = INV.PRODUCT_ID
LEFT JOIN PRODUCT_CATEGORIES PROD_CAT
  ON PRO.CATEGORY_ID = PROD_CAT.CATEGORY_ID
GROUP BY PRO.PRODUCT_ID, 
          PRO.PRODUCT_NAME,
          PROD_CAT.CATEGORY_NAME
HAVING SUM(INV.QUANTITY) = 0
  OR SUM(INV.QUANTITY) IS NULL
ORDER BY PRO.PRODUCT_ID;



/*11.	Lấy ra báo cáo chi tiết sản phẩm tồn theo
từng kho: Mã sản phẩm, Tên sản phẩm, tên kho tồn, tổng sl tồn tại kho*/
SELECT PRO.PRODUCT_ID AS MA_SP, 
      PRO.PRODUCT_NAME AS TEN_SP,
      WH.WAREHOUSE_NAMES AS TEN_KHO_TON,
      SUM(INV.QUANTITY)AS SL_TON_KHO
FROM PRODUCTS PRO
LEFT JOIN INVENTORIES INV
  ON PRO.PRODUCT_ID = INV.PRODUCT_ID
LEFT JOIN warehouses WH
  ON INV.WAREHOUSE_ID = WH.WAREHOUSE_ID
GROUP BY PRO.PRODUCT_ID, 
          PRO.PRODUCT_NAME,
          WH.WAREHOUSE_NAMES
ORDER BY PRO.PRODUCT_ID;
select *from warehouses;

/*12.	Lấy ra báo cáo chi tiết sản phẩm tồn 
theo từng địa điểm kho: Mã sản phẩm, Tên sản phẩm,
tên kho tồn, địa chỉ kho, tổng sl tồn tại kho*/
SELECT PRO.PRODUCT_ID AS MA_SP, 
      PRO.PRODUCT_NAME AS TEN_SP,
      WH.WAREHOUSE_NAMES AS TEN_KHO_TON,
      LO.ADDRESS AS DIA_CHI_KHO,
      SUM(INV.QUANTITY)AS SL_TON_KHO
FROM PRODUCTS PRO
LEFT JOIN INVENTORIES INV
  ON PRO.PRODUCT_ID = INV.PRODUCT_ID
LEFT JOIN WAREHOUSES WH
  ON INV.WAREHOUSE_ID = WH.WAREHOUSE_ID
LEFT JOIN LOCATIONS LO
  ON WH.LOCATION_ID = WH.LOCATION_ID
GROUP BY PRO.PRODUCT_ID, 
          PRO.PRODUCT_NAME,
          WH.WAREHOUSE_NAMES,
          LO.ADDRESS
ORDER BY PRO.PRODUCT_ID;


/*13.	Lấy ra báo cáo chi tiết sản phẩm tồn theo
từng quốc gia kho: Mã sản phẩm, Tên sản phẩm, tên kho tồn, 
địa chỉ kho, quốc gia kho, tổng sl tồn tại kho*/
SELECT PRO.PRODUCT_ID AS MA_SP, 
      PRO.PRODUCT_NAME AS TEN_SP,
      WH.WAREHOUSE_NAME AS TEN_KHO_TON,
      LO.ADDRESS AS DIA_CHI_KHO,
      COU.COUNTRY_NAME AS QUOC_GIA,
      SUM(INV.QUANTITY)AS SL_TON_KHO
FROM PRODUCTS PRO
LEFT JOIN INVENTORIES INV
  ON PRO.PRODUCT_ID = INV.PRODUCT_ID
LEFT JOIN WAREHOUSES WH
  ON INV.WAREHOUSE_ID = WH.WAREHOUSE_ID
LEFT JOIN LOCATIONS LO
  ON WH.LOCATION_ID = WH.LOCATION_ID
LEFT JOIN COUNTRIES COU
  ON LO.COUNTRY_ID = COU.COUNTRY_ID
GROUP BY PRO.PRODUCT_ID, 
          PRO.PRODUCT_NAME,
          WH.WAREHOUSE_NAME,
          LO.ADDRESS,
          COU.COUNTRY_NAME
ORDER BY PRO.PRODUCT_ID;

/*14.	Lấy ra báo cáo chi tiết sản phẩm tồn theo 
từng vùng/miền : Mã sản phẩm, Tên sản phẩm, tên kho tồn, 
địa chỉ kho, quốc gia kho, vùng/miền kho,  tổng sl tồn tại kho*/
SELECT PRO.PRODUCT_ID AS MA_SP, 
      PRO.PRODUCT_NAME AS TEN_SP,
      WH.WAREHOUSE_NAMES AS TEN_KHO_TON,
      LO.ADDRESS AS DIA_CHI_KHO,
      COU.COUNTRY_NAME AS QUOC_GIA,
      RE.REGION_NAME AS VUNG_MIEN,
      SUM(INV.QUANTITY)AS SL_TON_KHO
FROM PRODUCTS PRO
LEFT JOIN INVENTORIES INV
  ON PRO.PRODUCT_ID = INV.PRODUCT_ID
LEFT JOIN WAREHOUSES WH
  ON INV.WAREHOUSE_ID = WH.WAREHOUSE_ID
LEFT JOIN LOCATIONS LO
  ON WH.LOCATION_ID = WH.LOCATION_ID
LEFT JOIN COUNTRIES COU
  ON LO.COUNTRY_ID = COU.COUNTRY_ID
LEFT JOIN REGIONS RE
  ON RE.REGION_ID = COU.REGION_ID
GROUP BY PRO.PRODUCT_ID, 
          PRO.PRODUCT_NAME,
          WH.WAREHOUSE_NAMES,
          LO.ADDRESS,
          COU.COUNTRY_NAME,
          RE.REGION_NAME
ORDER BY PRO.PRODUCT_ID;



/*15.	Lấy ra top 100 sản phẩm đang tồn nhiều 
nhất tại  kho ( Mã sản phẩm, Tên sản phẩm, tên kho tồn, tổng sl tồn tại kho)*/
SELECT PRO.PRODUCT_ID AS MA_SP, 
      PRO.PRODUCT_NAME AS TEN_SP,
      WH.WAREHOUSE_NAMES AS TEN_KHO_TON,
      SUM(INV.QUANTITY)AS SL_TON_KHO
FROM PRODUCTS PRO
INNER JOIN INVENTORIES INV
  ON PRO.PRODUCT_ID = INV.PRODUCT_ID
LEFT JOIN WAREHOUSES WH
  ON INV.WAREHOUSE_ID = WH.WAREHOUSE_ID
GROUP BY PRO.PRODUCT_ID, 
          PRO.PRODUCT_NAME,
          WH.WAREHOUSE_NAMES
ORDER BY SUM(INV.QUANTITY) DESC
FETCH FIRST 100 ROW ONLY;

/*16.	LẤY RA TOP 100 SẢN PHẨM ĐANG TỒN 
ÍT NHẤT THEO QUỐC GIA ( MÃ SẢN PHẨM, TÊN SẢN PHẨM, TÊN KHO TỒN,  
QUỐC GIA KHO, TỔNG SL TỒN TẠI KHO)*/
SELECT PRO.PRODUCT_ID AS MA_SP, 
      PRO.PRODUCT_NAME AS TEN_SP,
      WH.WAREHOUSE_NAMES AS TEN_KHO_TON,
      LO.ADDRESS AS DIA_CHI_KHO,
      COU.COUNTRY_NAME AS QUOC_GIA,
      SUM(INV.QUANTITY)AS SL_TON_KHO
FROM PRODUCTS PRO
LEFT JOIN INVENTORIES INV
  ON PRO.PRODUCT_ID = INV.PRODUCT_ID
LEFT JOIN WAREHOUSES WH
  ON INV.WAREHOUSE_ID = WH.WAREHOUSE_ID
LEFT JOIN LOCATIONS LO
  ON WH.LOCATION_ID = WH.LOCATION_ID
LEFT JOIN COUNTRIES COU
  ON LO.COUNTRY_ID = COU.COUNTRY_ID
GROUP BY PRO.PRODUCT_ID, 
          PRO.PRODUCT_NAME,
          WH.WAREHOUSE_NAMES,
          LO.ADDRESS,
          COU.COUNTRY_NAME
ORDER BY SUM(INV.QUANTITY) ASC
FETCH FIRST 100 ROW ONLY;

/*17.	LẤY RA TOP 10 NHÂN VIÊN CÓ DOANH
THU CAO NHẤT (MÃ NHÂN VIÊN, HỌ VÀ TÊN NHÂN VIÊN, DOANH THU).
SẮP XẾP THEO DOANH THU GIẢM DẦN  */
SELECT EMP.EMPLOYEE_ID AS MA_NV,
      EMP.FIRST_NAME AS TEN_NV,
      EMP.LAST_NAME AS HO_NV,
      ROUND(SUM(ORD.TOTAL),0) AS DOANH_THU
FROM EMPLOYEES EMP
INNER JOIN ORDERS ORD
  ON EMP.EMPLOYEE_ID = ORD.SALESMAN_ID
GROUP BY EMP.EMPLOYEE_ID,
        EMP.FIRST_NAME,
         EMP.LAST_NAME
ORDER BY SUM(ORD.TOTAL) DESC
FETCH FIRST 10 ROW ONLY;



/*18.	LẤY RA BÁO CÁO THỐNG KÊ TỔNG SỐ ĐƠN HÀNG 
ĐÃ BÁN THEO NHÂN VIÊN (MÃ NHÂN VIÊN, HỌ VÀ TÊN NHÂN VIÊN) 
TRONG NĂM 2016 VÀ NĂM 2017. SẮP XẾP THEO NĂM*/
SELECT 
    EXTRACT(YEAR FROM ORD.ORDER_DATE) AS YEAR,
    EMP.EMPLOYEE_ID AS MA_NV,
    EMP.FIRST_NAME AS TEN_NV,
    EMP.LAST_NAME AS HO_NV,
    COUNT(ORD.ORDER_ID) AS SL_DON
FROM EMPLOYEES EMP
LEFT JOIN ORDERS ORD
  ON ORD.SALESMAN_ID = EMP.EMPLOYEE_ID
WHERE EXTRACT(YEAR FROM ORD.ORDER_DATE) BETWEEN 2016 AND 2017
GROUP BY EXTRACT(YEAR FROM ORD.ORDER_DATE),
        EMP.EMPLOYEE_ID,
        EMP.FIRST_NAME,
         EMP.LAST_NAME
ORDER BY YEAR;


/*19.	LẤY RA BÁO CÁO THỐNG KÊ TỔNG SỐ ĐƠN HÀNG ĐÃ 
HỦY THEO NHÂN VIÊN (MÃ NHÂN VIÊN, HỌ VÀ TÊN NHÂN VIÊN) 
THEO CÁC THÁNG CỦA NĂM 2017. SẮP XẾP THEO THÁNG*/
SELECT 
    EXTRACT(MONTH FROM ORD.ORDER_DATE) AS MONTH,
    EMP.EMPLOYEE_ID AS MA_NV,
    EMP.FIRST_NAME AS TEN_NV,
    EMP.LAST_NAME AS HO_NV,
    COUNT(ORD.ORDER_ID) AS SL_DON_HUY
FROM EMPLOYEES EMP
LEFT JOIN ORDERS ORD
  ON ORD.SALESMAN_ID = EMP.EMPLOYEE_ID
WHERE EXTRACT(YEAR FROM ORD.ORDER_DATE)='2017' AND ORD.STATUS ='Canceled'
GROUP BY
      EXTRACT(MONTH FROM ORD.ORDER_DATE),
      EMP.EMPLOYEE_ID,
      EMP.FIRST_NAME,
      EMP.LAST_NAME
ORDER BY MONTH;


/*20.	LẤY RA BÁO CÁO THỐNG KÊ TỔNG SỐ SẢN PHẨM
ĐÃ BÁN THEO NHÂN VIÊN (MÃ NHÂN VIÊN, HỌ VÀ TÊN NHÂN VIÊN)
TRONG 4 THÁNG ĐẦU NĂM 2016. SẮP XẾP THEO SỐ LƯỢNG SẢN PHẨM*/
SELECT 
    EMP.EMPLOYEE_ID AS MA_NV,
    EMP.FIRST_NAME AS TEN_NV,
    EMP.LAST_NAME AS HO_NV,
    SUM(ORD_ITEM.QUANTITY) AS SL_SAN_PHAM
FROM EMPLOYEES EMP
LEFT JOIN ORDERS ORD
  ON ORD.SALESMAN_ID = EMP.EMPLOYEE_ID
LEFT JOIN ORDER_ITEMS ORD_ITEM
  ON ORD.ORDER_ID = ORD_ITEM.ORDER_ID
WHERE ORD.ORDER_DATE BETWEEN TO_DATE('1/1/2016','DD/MM/YYYY') 
                AND ADD_MONTHS(TO_DATE('1/1/2016','DD/MM/YYYY'),4)
GROUP BY
      EMP.EMPLOYEE_ID,
      EMP.FIRST_NAME,
      EMP.LAST_NAME
ORDER BY SL_SAN_PHAM DESC;



 
