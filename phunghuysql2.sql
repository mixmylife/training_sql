
--Bài 1:  
--Sử dụng kiểu khai báo 1 cột %type để lấy ra tên của nhân viên có id = 2. (Bảng Employee )
set serveroutput on; 
DECLARE 
 v_first_name Employee.first_name%TYPE;
 v_id number :=2;
BEGIN
 select first_name
 into v_first_name
 from employee
 where emp_id =v_id;
 --in ra màn hình 
 dbms_output.put_line('first_name :'  || v_first_name);
end;


--Bài 2:  
--Sử dụng kiểu khai báo 1 dòng %Rowtype để lấy ra tất cả thông tin của nhân viên có id = 2. (Bảng Employee )
set serveroutput on; 
DECLARE 
 v_emp Employee%rowtype;
 v_id number :=2;
BEGIN
 select *
 into v_emp 
 from employee
 where emp_id =v_id;
 --in ra màn hình 
 dbms_output.put_line('name :'  || v_emp.first_name  || ' ' || v_emp.last_name || '   ' || 'date :' || v_emp.start_date );
end;

SET SERVEROUTPUT ON
Declare
  v_Emp_Id Employee.Emp_Id%Type := 2;
  -- Khai báo một biến
  -- Là kiểu dữ liệu 1 dòng của bảng Employee.
  v_Emp Employee%Rowtype;
Begin
  Select * Into v_Emp 
  From Employee Emp 
  Where Emp.Emp_Id = v_Emp_Id;
  ----
  Dbms_Output.Put_Line(' First_Name= ' || v_Emp.First_Name);
  Dbms_Output.Put_Line(' Last_Name= ' || v_Emp.Last_Name);
End;

--Bài 3:  
--Sử dụng kiểu khai báo 1 dòng %Rowtype để lấy ra tất cả thông tin của nhân viên có id = 10000. (Bảng Employee ).
--Sử dụng Exception nếu không có dữ liệu trả về (When No_Data_Found Then) thì in ra câu lệnh : 
--‘No data with emp_id= id của nhân viên
set serveroutput on; 
DECLARE 
 v_emp Employee%rowtype;
 v_id number :=10000;
BEGIN
 select *
 into v_emp 
 from employee
 where emp_id =v_id;
 --in ra màn hình 
 dbms_output.put_line('name :'  || v_emp.first_name  || ' ' || v_emp.last_name || '   ' || 'date :' || v_emp.start_date );
Exception
When No_Data_Found Then
dbms_output.put_line('No data with emp_id =' || v_id);
end;

SET SERVEROUTPUT ON
Declare
  v_Emp_Id Employee.Emp_Id%Type := 10000;
  -- Khai báo một biến
  -- Là kiểu dữ liệu 1 dòng của bảng Employee.
  v_Emp Employee%Rowtype;
Begin
  Select * Into v_Emp 
  From Employee Emp 
  Where Emp.Emp_Id = v_Emp_Id;
  ----
  Dbms_Output.Put_Line(' First_Name= ' || v_Emp.First_Name);
  Dbms_Output.Put_Line(' Last_Name= ' || v_Emp.Last_Name);
Exception
  When No_Data_Found Then
 	-- Trường hợp câu SELECT không trả về bản ghi nào
 	Dbms_Output.Put_Line('No data with emp_id= ' || v_Emp_Id);
End;

--Bài 4: 
--Khai báo 1 biến v_Cust_id = 1. Lấy ra tất cả thông tin khách hàng có ID = biến vừa khai báo
set serveroutput on;
DECLARE
 v_emp Employee%rowtype;
 v_emp_id number := 1;
 
BEGIN
 select * 
 into v_emp
 from Employee
 where emp_id = v_emp_id;
 dbms_output.put_line('name:'  || '  ' || v_emp.first_name  || '  '|| v_emp.last_name);
 Exception
  When No_Data_Found Then
 	-- Trường hợp câu SELECT không trả về bản ghi nào
 	Dbms_Output.Put_Line('No data with emp_id= ' || v_emp_id);
 end;
 
 
 
--Bài 5:  
--Sử dụng kiểu khai báo Table để lấy ra tất cả thông tin:  “ID - FIRSTNAME - LASTNAME” (Bảng Employee )
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line().


SET SERVEROUTPUT ON
Declare
   type my_table is table of employee%rowtype;
   v_emp my_table;
Begin
   select * bulk collect
   into v_emp
   from employee ;
   for i in v_emp.first..v_emp.last
    loop
    dbms_output.put_line('here I am '||v_emp(i).EMP_ID || '  ' || v_emp(i).first_name || '  '|| v_emp(i).last_name);
   end loop; 
   for i in 2..5
    loop
    dbms_output.put_line('here I am '|| '  ' || v_emp(i).first_name || '  '|| v_emp(i).last_name);
   end loop; 
 end;
--
--
--BÀI TẬP VỀ NHÀ: 
--Bài 1: Khai báo 2 biến a,b (integer) có giá trị lần lượt là 10 và 20. 
--Yêu cầu:
--1.       In ra tổng của 2 giá trị
--2.       In ra hiệu của 2 giá trị
--3.       In ra thương của 2 giá trị
set SERVEROUTPUT on;
DECLARE
a INTEGER :=10;
b INTEGER :=20;
c FLOAT;
d FLOAT;
e FLOAT;
BEGIN
c := a+b;
d := a - b;
e := a/b;
dbms_output.put_line('tong hai so a va b la : ' || c);
dbms_output.put_line('hieu hai so a va b la : ' || d);
dbms_output.put_line('thuong hai so a va b la : ' || e);
end;


--Bài 2: Viết code PL/SQL tính diện tích hình tròn khi biết bán kính r = 9.4

set SERVEROUTPUT on;
DECLARE
pi FLOAT := 3.141592654;
r NUMBER :=9.4;
c FLOAT;
BEGIN
c := pi * r *r;
dbms_output.put_line('tong hai so a va b la : ' || c);

end;

DECLARE
    -- Constant 
    p constant number := 3.141592654; 
    -- Radius declarations 
    r number(10,1); 
    a_circle number(10,3);
BEGIN
    -- Area calculation
    r := 9.4; 
    a_circle := p * r * r; 
    -- Output in console
    dbms_output.put_line('Area of circle: ' || a_circle); 
END; 


--Bài 3: Sử dụng kiểu khai báo %Type để lấy ra thông tin khách hàng bao gồm:
--Mã khách hàng, Họ và tên, Địa chỉ, Ngày tháng năm sinh của khách hàng có ID = 4
--(Join 2 bảng INDIVIDUAL và CUSTOMER)
set serveroutput on;
Declare
v_makh customer.cust_id%type :=4;
v_hoten INDIVIDUAL.first_name%type;
v_diachi customer.address%type;
v_ngaysinh individual.birth_date%type;


begin
select cus.cust_id,
       ind.first_name,
       cus.address,
       ind.birth_date     
into v_makh,
     v_hoten,
     v_diachi,
     v_ngaysinh     
from customer CUS
join individual IND
on IND.cust_id = CUS.cust_id
where cus.cust_id = v_makh;
dbms_output.put_line('cust_id:'  || v_makh || v_hoten ||v_diachi ||v_ngaysinh);
end;


--Bài 4: Sử dụng kiểu khai báo %Type để lấy ra tên khách hàng có nhiều tài khoản nhất
--(Join 2 bảng INDIVIDUAL và ACCOUNT)
set serveroutput on ;
DECLARE
v_first_name individual.first_name%type;
v_sum_account number;
BEGIN
select 
ind.first_name,
count(ac.account_id) as sum_account
--ind.first_name     
into 
--select như nào into lần lượt như vậy không đc đảo lộn sắp xếp 
v_first_name,
v_sum_account


from individual ind
join account ac
on ind.cust_id = ac.cust_id
GROUP by ind.first_name
order by count(ac.account_id) desc
FETCH FIRST 1 rows only
;
 dbms_output.put_line('cutomer: ' || v_first_name || '- total' ||  v_sum_account);
end;

--Bài 5: Sử dụng kiểu khai báo biến thích hợp lấy ra số dư khả dụng (AVAIL_BALANCE)
--nhỏ nhất, lớn nhất, trung bình của tài khoản (bảng ACCOUNT) 
set serveroutput on;
DECLARE
v_max account.avail_balance%type;
v_min account.avail_balance%type;
v_avg account.avail_balance%type;
BEGIN
select 
max(AVAIL_BALANCE),
min(AVAIL_BALANCE),
avg(AVAIL_BALANCE)
into
v_max,
v_min,
v_avg
from account;
dbms_output.put_line('max :' || v_max || ' ' || 'min :' ||v_min || ' ' || 'avg' || v_avg);
end;

--Bài 6: Sử dụng kiểu khai báo Table lấy ra 2 tập  nhân viên:
--+ Tập nhân viên  1: Những nhân viên có  ID >4
--+ Tập nhân viên 2: Những nhân viên có ID <2
--Union 2 tập nhân viên lại với nhau
--Yêu cầu:
--1.       In ra màn hình tổng số nhân viên
--2.       In ra chỉ số của nhân viên đầu tiên
--3.       In ra chỉ số nhân viên cuối cùng
--4.       In ra lần lượt ID + Tên nhân viên


set serveroutput on;
DECLARE
    type tb_emp is table of  employee%ROWTYPE index by binary_integer ; -- khởi tạo đoàn tàu 
    v_emp tb_emp; -- khởi tạo toa tàu

BEGIN
--chất hàng lên toa tàu
    select *
    BULK COLLECT 
    into v_emp
    from ( select *
            from employee
            where emp_id >4
            union select *
            from employee
            where emp_id <2
            ) ;
    dbms_output.put_line('Tong so nhan vien: ' ||v_emp.count);
    dbms_output.put_line('Nhan vien dau tien: '||v_emp(v_emp.first).emp_id);
    dbms_output.put_line('Nhan vien cuoi cung: '||v_emp(v_emp.last).emp_id);
    
    for i in v_emp.first..v_emp.last loop
        dbms_output.put_line(v_emp(i).emp_id || '-' || v_emp(i).first_name || ' ' || v_emp(i).last_name);
    end loop;
END;


set serveroutput on;
DECLARE
    type tb_emp is table of  employee%ROWTYPE  
    index by binary_integer ;
    v_emp tb_emp;
BEGIN
    select *
    BULK COLLECT 
    into v_emp
    from employee
    where emp_id >4 or emp_id <2;
    dbms_output.put_line('Tong so nhan vien: ' ||v_emp.count);
    dbms_output.put_line('Nhan vien dau tien: '||v_emp(v_emp.first).emp_id);
    dbms_output.put_line('Nhan vien cuoi cung: '||v_emp(v_emp.last).emp_id);
    
    for i in 1..v_emp.count loop
        dbms_output.put_line(v_emp(i).emp_id || '-' || v_emp(i).first_name || ' ' || v_emp(i).last_name);
    end loop;
END;






--BÀI 2: CÁC LỆNH CƠ BẢN / CON TRỎ 

SET Serveroutput on;
DECLARE
a number := 30 ;
b number := 20;
begin
 if a < b 
 then 
 dbms_output.put_line('a nhỏ hơn b');
 else 
 dbms_output.put_line('a lớn hơn b');
 end if;
end;



SET Serveroutput on;
DECLARE
a number := 3 ;
b number := 20;
begin
 while a < b loop
  a := a+1;
 end loop;
 dbms_output.put_line('a : ' ||a);
end;

SET Serveroutput on;
DECLARE
a number := 3 ;
b number := 20;
begin
  loop
  a := a+1;
  exit when a = b;
 end loop;
 dbms_output.put_line('a : ' ||a);
end;


SET Serveroutput on;
DECLARE
a number := 1 ;
b number := 20;
begin
  for i in a..b loop
 dbms_output.put_line('i('|| i||')= ' ||i);
 end loop;
end ;

--con trỏ tường minh 
set serveroutput on;
DECLARE
CURSOR emp_cursor
is
select 
emp.emp_id,
emp.first_name,
emp.last_name
from employee emp; 
v_emp emp_cursor%rowtype;
BEGIN
open v_emp;
loop 
fetch emp_cursor
into v_emp;
dbms_output.put_line('ID :'||v_emp.emp_id);
exit   when  emp_cursor%notfound;
 end loop;
close v_emp;
end;


--con trỏ không tường minh 
set serveroutput on;
DECLARE
CURSOR emp_cursor
is
select 
emp.emp_id,
emp.first_name,
emp.last_name
from employee emp; 
BEGIN
for v_emp in emp_cursor loop
dbms_output.put_line('ID :'||v_emp.emp_id);
exit when emp_cursor%notfound;
end loop;
end;

--Bài 1: 
--Sử dụng vòng lặp IF-ELSE để thực hiện yêu cầu sau: Kiểm tra số dư tài khoản của khách hàng có  ID = 1.
--Nếu số dư tài khoản > 1000$ thì in ra thông báo “Số dự hiện tại của bạn hiện đang lớn hơn 1000$”, 
--ngược lại in ra thông báo “Số dư hiện tại của bạn không đạt 1000$” (bảng ACCOUNT). 
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line()

select *from account;
set serveroutput on;
declare 
v_ava_balance account.avail_balance%type; --sao không dùng kiểu rowtype
v_id number :=1;
begin
select sum(avail_balance) 
into v_ava_balance
from account
where cust_id = v_id;
if 
v_ava_balance >1000
then
dbms_output.put_line('số dư hiện tại của bạn hiện đang lơn hơn 1000');
else
dbms_output.put_line('số dư hiện tại của bạn không đạt tới 1000');
end if;
end;

--Bài 2: 
--Sử dụng FOR..LOOP để lấy ra các thông tin: ID: Mã_phòng ban - Tên_phòng ban ”. (Bảng Department)
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line().
select *from Department;
set serveroutput on;
declare
type tb_depar is table of  Department%ROWTYPE index by binary_integer ;
v_depar tb_depar;
begin
select *
into v_depar
from Department;
for i in v_depar.first .. v_depar.last loop
dbms_output.put_line('mã phòng ban :' || ' ' ||v_depar(i).dept_id || ' - ' ||' Tên phòng ban:'||' '||v_depar(i).name);
end loop;
end;

SET SERVEROUTPUT ON;
BEGIN
   FOR c IN (SELECT DEPT_ID, NAME
           	FROM department
          	)
   LOOP
  	DBMS_OUTPUT.PUT_LINE (
     	'Các phòng ban gồm: ' || c.DEPT_ID || ‘-’ || c.NAME);
   END LOOP;
END;

--Bài 3:  
--Sử dụng FOR..LOOP để lấy ra các thông tin: Amount của 10 ngày gần nhất của tất cả các
--giao dịch tính từ ngày 25-01-2004 (25-01-2004, 26-01-2004, 27-01-2004…..) . (Bảng Acc_transaction )
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line().
--
select *from Acc_transaction
where txn_date > to_date('25/01/2004','dd/mm/yyyy');
set serveroutput on; 
DECLARE 
  l_start_date DATE := DATE'2004-01-25'; 
  l_amount	NUMBER; 
  vDate date;
BEGIN 
  FOR i IN 0..9 
  LOOP 
  	begin         	
        	vDate := l_start_date + i;
        	SELECT amount 
        	INTO l_amount 
        	FROM acc_transaction 
        	WHERE txn_date = vDate; 
        	dbms_output.put_line('Số dư cho ngày: ' || TO_CHAR(vDate,'DD-MM-YYYY') || ': ' || l_amount);
    	exception
      	when no_data_found then
        	Dbms_Output.Put_Line('Không có dữ liệu cho ngày: ' || TO_CHAR(vDate,'DD-MM-YYYY'));
    	end;
  END LOOP; 
END; 



--Bài 4: 3
--Sử dụng WHILE..FOR để lấy ra các thông tin: Amount  của tất cả các giao dịch tính 
--từ ngày 24-01-2004 cho đến ngày 28-02-2014 .(Bảng Acc_transaction )
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line().
--
set serveroutput on; 
DECLARE 
  l_start_date DATE := DATE'2004-01-25';
  l_end_date DATE := DATE'2004-02-28';
  l_amount	NUMBER; 
  vDate date;
  v_run BOOLEAN := TRUE;
BEGIN 
  WHILE v_run 
  LOOP 
  	begin         	
        	l_start_date := l_start_date + 1;
        	SELECT amount 
        	INTO l_amount 
        	FROM acc_transaction 
        	WHERE rownum =1 and
        	txn_date = l_start_date; 
        	dbms_output.put_line('Số dư cho ngày: ' || TO_CHAR(l_start_date,'DD-MM-YYYY') || ': ' || l_amount);
       	
    	exception
      	when no_data_found then
        	Dbms_Output.Put_Line('Không có dữ liệu cho ngày: ' || TO_CHAR(l_start_date,'DD-MM-YYYY'));
    	
    	end;
    	IF l_start_date = l_end_date
    	THEN
         	v_run := FALSE;
    	END IF;
  END LOOP; 
END; 

---------------------- CURSOR--------------------------
--
--Bài 1: 
--Sử dụng cursor để lấy các thông tin: Mã sản phẩm (product_cd), Tên gói sản phẩm (name)  mà ngân hàng
--đang cung cấp(bảng Product). 
--Và hiện thị ra màn hình bằng lệnh: dbms_output.put_line().
--
set serveroutput on;
declare
 cursor c_product
 is 
 select 
 product_cd,
 name
 from product;
begin
dbms_output.put_line('các sản phẩm là:');
for i_product in c_product
loop
dbms_output.put_line(i_product.product_cd || ' : '||i_product.name);
end loop;
end;

--Bài 2:
--Sử dụng cursor tường minh để lấy ra thông tin gồm Mã Khách hàng và tên sản phẩm mà KH đó sử đụng, 
--lấy từ bảng Account và Product (account join Product on account .Product_CD = Product.Product_CD)
--Và hiện thị kết quả ra màn hình  “Cust_ID,Product Name” bằng lệnh: dbms_output.put_line()
--
select *from account;
select *from product;
SET SERVEROUTPUT ON;
DECLARE
-- Khai báo cusor
   cursor c1 is
 	SELECT ac.cust_id,
    pr.name
 	FROM account ac
 	join product pr
    on pr.product_cd = ac.product_cd
    order by ac.cust_id;
-- Khái báo Rowtype dựa trên cursor vừa tạo
   v_cursor c1%Rowtype;
BEGIN
-- Mở Cursor
   open c1;
-- Sử dụng vòng lặp.
   loop
	-- Lấy dòng dữ liệu trên Cursor. Mỗi lần Fetch con trỏ nhẩy lên 1 dòng (Từ trên xuống dưới).
   	fetch c1 into v_cursor;
	-- Điều kiện thoát khỏi vòng lặp.	
   	Exit When c1%Notfound;
   	Dbms_Output.Put_Line('CUST_ID: ' || v_cursor.cust_id || '- PRODUCT_NAME' || v_cursor.name);
   end loop;
   close c1;
END;


--Bài 3:  
--Sử dụng cursor con trỏ tường minh để lấy ra thông tin bao gồm: “FIRST_NAME, LAST_NAME, AVAIL_BALANCE, SEGMENT” của tất cả các khách hàng.
--Nếu:
-- “AVAIL_BALANCE <= 4000” thì SEGMENT là: “LOW”, 
--“AVAIL_BALANCE > 4000 và AVAIL_BALANCE <= 7000” thì SEGMENT là: “MEDIUM”, 
--
--“AVAIL_BALANCE >7000” thì SEGMENT là: “HIGH”
--Sau đó hiện thị kết quả:  “FIRST_NAME, LAST_NAME, AVAIL_BALANCE, SEGMENT”  ra màn hình bằng lệnh dbms_output.put_line().
--Gợi ý: Sử dụng dữ liệu từ các bảng sau: Customer, Account, Individual), gợi ý:
-- account join customer on customer.cust_id = account.cust_id
--join individual on individual.cust_id = customer.cust_id
 SET SERVEROUTPUT ON;
DECLARE
-- Khai báo cusor
   cursor c1 is
 	SELECT sum(AVAIL_BALANCE) AVAIL_BALANCE,
 	FIRST_NAME || LAST_NAME NAME,
    case 
    when sum(AVAIL_BALANCE) < 4000 then 'low'
    when sum(AVAIL_BALANCE) > 4000  and sum(AVAIL_BALANCE) <=7000 then 'medium'
    when sum(AVAIL_BALANCE) > 7000 then 'hight'
    end SEGMENTT
 	FROM account
 	join customer 
    on customer.cust_id = account.cust_id
 	join individual
    on individual.cust_id = customer.cust_id
 	GROUP BY FIRST_NAME || LAST_NAME;
-- Khái báo Rowtype dựa trên cursor vừa tạo
   v_cursor c1%Rowtype;
 
BEGIN
-- Mở Cursor
   open c1;
-- Sử dụng vòng lặp.
   loop
	-- Lấy dòng dữ liệu trên Cursor. Mỗi lần Fetch con trỏ nhẩy lên 1 dòng (Từ trên xuống dưới).
   	fetch c1 into v_cursor;
    Dbms_Output.Put_Line(v_cursor.SEGMENTT);
	-- Điều kiện thoát khỏi vòng lặp.	
   	Exit When c1%Notfound;
   	Dbms_Output.Put_Line('KH: ' || v_cursor.NAME || '-' || ILevel);
   end loop;
   close c1;
END;


--Bài 4: Đề bài như bài 2. Nhưng sử dụng loại con trỏ không tường minh
--lấy ra thông tin gồm Mã Khách hàng và tên sản phẩm mà KH đó sử đụng, 
--lấy từ bảng Account và Product (account join Product on account .Product_CD = Product.Product_CD)
--Và hiện thị kết quả ra màn hình  “Cust_ID,Product Name” bằng lệnh: dbms_output.put_line()
set serveroutput on;
declare
 cursor c_ap
 is 
 SELECT cust_id,
    name
 	FROM account 
 	join product 
    on product.product_cd = account.product_cd
    order by cust_id;
begin
dbms_output.put_line('thông tin khách hàng:');
for i_ap in c_ap
loop
dbms_output.put_line(i_ap.cust_id || ' : '||i_ap.name);
end loop;
end;


--Bài 5: Tạo bảng ETL_CUSTOMER theo code mẫu sau:
--CREATE TABLE ETL_CUSTOMER(
--	cust_id NUMBER,
--	segment VARCHAR2(50) NOT NULL,
--	etl_date date NOT NULL
--);
--+ Làm tưởng tự bài 3 để tính được SEGMENT của từng khách hàng. Sau đó Insert dữ liệu vào bảng ETL_CUSTOMER với các trường như sau:
---  	cust_id = ID_KHÁCH_HÀNG,
---  	segment = SEGMENT,
---  	elt_date = Ngày hiện tại (Ngày thêm dữ liệu)
-- 
--+ In ra  ra màn hình bằng lệnh dbms_output.put_line() các thông tin sau: Tổng số bảng ghi đã được thêm vào + Tổng thời gian chạy
-- (Gợi ý: Sử dụng dữ liệu từ các bảng sau: Customer, Account, Individual)

CREATE TABLE HUYPV_ETL_CUSTOMER(
	cust_id NUMBER,
	segment VARCHAR2(50) NOT NULL,
	etl_date date NOT NULL);



SET SERVEROUTPUT ON;
DECLARE
-- Khai báo cusor
   cursor c1 is
 	SELECT sum(AVAIL_BALANCE) AVAIL_BALANCE,
 	FIRST_NAME || LAST_NAME NAME,
 	account.cust_id,
     case 
    when sum(AVAIL_BALANCE) < 4000 then 'low'
    when sum(AVAIL_BALANCE) > 4000  and sum(AVAIL_BALANCE) <=7000 then 'medium'
    when sum(AVAIL_BALANCE) > 7000 then 'hight'
    end SEGMENT
 	FROM account
 	join customer on customer.cust_id = account.cust_id
 	join individual on individual.cust_id = customer.cust_id
 	WHERE customer.state = 'MA'
 	GROUP BY FIRST_NAME || LAST_NAME, account.cust_id;
-- Khái báo Rowtype dựa trên cursor vừa tạo
--   ILevel varchar2(20);
   countRecords  NUMBER;
BEGIN
-- Sử dụng vòng lặp.
   FOR rec IN c1 LOOP
--   	IF rec.AVAIL_BALANCE <= 4000 THEN
--      	ILevel := 'Low';
--   	ELSIF rec.AVAIL_BALANCE > 4000 and rec.AVAIL_BALANCE <= 7000 THEN
--      	ILevel := Medium; 	
--   	ELSE
--      	ILevel := 'High';
--   	END IF;
   	insert into HUYPV_ETL_CUSTOMER values(rec.cust_id,rec.segment,sysdate);
   end loop;
	COMMIT;
	select count(*) into countRecords from HUYPV_ETL_CUSTOMER where etl_date = trunc(sysdate);
    DBMS_OUTPUT.PUT_LINE('Total rows insert: ' || countRecords);
    DBMS_OUTPUT.PUT_LINE('Finished: ' || Systimestamp);
END;

select *from HUYPV_ETL_CUSTOMER;

--
--BÀI TẬP VỀ NHÀ:
--Bài 1:
--Sử dụng vòng lặp để lấy ra các thông tin: ID: Mã nhân viên, Họ và Tên nhân viên, Mã phòng ban, 
--Tên Phòng bàn của các nhân viên có mã chi nhánh = 1. (Join 2 bảng Employee và Department)
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line().
select *from employee;
select *from department;
set serveroutput on;
declare 
v_id number :=1;
BEGIN
    FOR emprec IN(SELECT e.emp_id,
                       e.first_name,
                       e.last_name,
                       d.dept_id,
                       d.name
                FROM   employee e
                       join department d
                         ON e.dept_id = d.dept_id
                WHERE  assigned_branch_id =v_id
                      ) LOOP
        dbms_output.Put_line('Name: '||emprec.first_name||' '||emprec.last_name||chr(9)
		||' Department: '||emprec.name||chr(9)||' Department ID: '||emprec.dept_id||chr(9));
    END LOOP;
END; 



--Bài 2: 
--Sử dụng vòng lặp để lấy ra thông tin: Tổng số tài khoản đã được mở bởi nhân viên có ID = 10
--Nếu:
-- “Tổng số tài khoản đã mở <= 1” thì Level là: “LOW”, 
--“Tổng số tài khoản đã mở > 2 và Tổng số tài khoản đã mở <= 4” thì Level  là: “Avg”, 
--“Tổng số tài khoản đã mở > 4 và Tổng số tài khoản đã mở <= 6” thì Level  là: “Moderate”, 
--Trường hợp còn lại Level là: “Hight”
--Sau đó hiện thị kết quả Level ra màn hình bằng lệnh dbms_output.put_line().
select *from account;
set serveroutput on;
declare 
cursor c_ac
is
SELECT count( distinct account_id) as total_acc,
case
when count( distinct account_id) <= 1 THEN 'Low Lv'
when count( distinct account_id) > 2 and count( distinct account_id) <=4 THEN 'Agv Lv'
when count( distinct account_id) >4 and count( distinct account_id) <= 6 THEN 'Moderate Lv'
when count( distinct account_id) >6 THEN 'Hight Lv'
end Level
FROM account 
where open_emp_id = 10;
BEGIN
    FOR ac IN c_ac
    LOOP
      dbms_output.put_line(ac.levell);
    END LOOP;
END; 


set serveroutput on;
DECLARE
   ILevel varchar2(20);
BEGIN
FOR emprect IN (SELECT count( distinct account_id) as total_acc  FROM account where open_emp_id = 10) LOOP

    IF emprect.total_acc <= 1 THEN
    ILevel := 'Low Lv';
    
    ELSIF emprect.total_acc > 2 and emprect.total_acc <= 4 THEN
    ILevel := 'Avg Lv';
    
    ELSIF emprect.total_acc > 4 and emprect.total_acc <= 6 THEN
    ILevel := 'Moderate Lv';
    
    ELSE
    ILevel := 'High Lv';
    
    END IF;
    Dbms_Output.Put_Line('KH: ' || ILevel);
END LOOP;
END;
--Bài 3: 
--Sử dụng vòng lặp để lấy ra tổng số tài khoản đã mở tính từ năm 2000 đến năm 2005
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line().
select *from account;
set serveroutput on;
DECLARE
v_tk_2000  number := 2000;
v_op number;
BEGIN
while v_tk_2000 <2005
loop
select count(*)
into v_op
from account 
where extract (year from open_date) = v_tk_2000;
dbms_output.put_line('năm mở tài khoản :' || v_tk_2000);
dbms_output.put_line('số tài khoản mở:'|| v_op);
v_tk_2000 := v_tk_2000+1;
end loop;
END;

--Bài 4: Sử dụng con trỏ để lấy ra báo cáo bao gồm: Mã nhân viên, họ và tên nhân viên và ngày đầu tiên
--mà nhân viên đó đã mở tài khoản cho khách hàng (Gợi ý: sử dụng 2 bảng Employee và bảng Account)
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line().
select *from employee;
select *from account;
--set serveroutput on;
--DECLARE
--cursor c_emac 
--is
--SELECT e.emp_id,
--       e.first_name || e.last_name name,
--       ac.open_date
--    from employee e 
--    join account ac 
--    on 
--       
-- 
--begin
--dbms_output.put_line();
--end;



set serveroutput on;
DECLARE
    CURSOR employees_cur
    IS
      SELECT emp_id,
             first_name,
             last_name
      FROM   employee;
    emp_first_date DATE;
BEGIN
    dbms_output.Put_line(Rpad('Employee ID', 15)
                         ||Rpad('First Name', 25)
                         ||'First Date');

dbms_output.Put_line('-----------------------------------------------------------------------------------------');

FOR emp_sal_rec IN employees_cur LOOP
    -- find out most recent end_date in job_history
    SELECT Min(open_date) 
    INTO   emp_first_date
    FROM   account
    WHERE  open_emp_id =  emp_sal_rec.emp_id;

    IF emp_first_date IS NULL THEN
      emp_first_date := SYSDATE;
    END IF;

    dbms_output.Put_line(Rpad(emp_sal_rec.emp_id, 15)
                         ||Rpad(emp_sal_rec.first_name, 25)
                         || To_char(emp_first_date, 'dd-mm-yyyy'));
END LOOP;
END; 
--Bài 5:
--Sử dụng con trỏ để lấy ra báo cáo bao gồm: Mã nhân viên, họ và tên nhân viên, ngày băt đầu vào làm và số tiền thưởng đạt được theo kinh nghiệm làm việc
--Số tiền thưởng được tính theo CT sau: 
--+ Thời gian làm việc = Số tháng của Ngày hiện tại so với ngày bắt đầu vào làm / 12
--+ Nếu thời gian làm việc > 13: Tiền thưởng = 8000
--+ Nếu thời gian làm việc > 11: Tiền thưởng = 5000
--+ Nếu thời gian làm việc > 9: Tiền thưởng = 3000
--+ Nếu thời gian làm việc > 7: Tiền thưởng = 2000
--+ Nếu thời gian làm việc > 4: Tiền thưởng = 1000
--Hiện thị ra màn hình bằng lệnh: dbms_output.put_line().


set serveroutput on;

DECLARE
   CURSOR c
   IS
    SELECT * FROM employee;

   TYPE any_table_type IS TABLE OF employee%ROWTYPE
                             INDEX BY BINARY_INTEGER;

   emp_rec   any_table_type;
   inctv_amount  NUMBER;
   work_exp      NUMBER;
BEGIN
   OPEN c;
   FETCH c
   BULK COLLECT INTO emp_rec;
   CLOSE c;
   FOR i IN emp_rec.FIRST .. emp_rec.LAST 
   LOOP
          work_exp := Round(( Months_between(SYSDATE, emp_rec(i).START_DATE) / 12 ));

       IF work_exp > 13 THEN
          inctv_amount := 8000;
        ELSIF work_exp > 11 THEN
          inctv_amount := 5000;
        ELSIF work_exp > 9 THEN
          inctv_amount := 3000;
        ELSIF work_exp > 7 THEN
          inctv_amount := 2000;
        ELSIF work_exp > 4 THEN
          inctv_amount := 1000;
        ELSIF work_exp > 0 THEN
          inctv_amount := 400;
        END IF;
        dbms_output.Put_line(Rpad(emp_rec(i).emp_id, 15)
                             ||Rpad(( emp_rec(i).first_name
                                      ||' '
                                      ||emp_rec(i).last_name ), 30)
                             ||Rpad(emp_rec(i).START_DATE, 15)
                             || To_char(inctv_amount, '9,999'));
                         
    END LOOP;
END;








--BÀI 3 : Advanced function
select * from temp1;
select * from temp2;


--merge  into temp1 as bc
--using temp2 bp
--on bc.id = bp.id
--WHEN MATCHED THEN
--UPDATE SET bc.a=bp.a, bc.b=bp.b, bc.c=bp.c --(update)
--WHEN NOT MATCHED THEN
--INSERT (id,a,b,c) VALUES (bp.id, bp.a,bp.b,500) --(insert)
--WHEN NOT MATCHED BY SOURCE THEN
--UPDATE SET a=@a, b=@b, c=@c --(update);





--BAITAP 
--BÀI TẬP TRÊN LỚP
--Bài 1:  Ta có 2 bảng: CUSTOMER và HOCVIEN_CUSTOMER
--Sử dụng lệnh MERGE để sửa đổi bảng HOCVIEN_CUSTOMER dựa trên những thay đổi của bảng CUSTOMER
--+ Nếu dữ liệu trường CUST_TYPE_CD của bảng CUSTOMER khác với trường CUST_TYPE_CD của bảng
--HOCVIEN_CUSTOMER thì UPDATE: HOCVIEN_CUSTOMER.CUST_TYPE_CD  = CUSTOMER .CUST_TYPE_CD  
--+ Nếu không tồn tại dữ liệu trùng khớp giữa 2 bảng thì INSERT toàn bộ dữ liệu từ bảng
--CUSTOMER vào HOCVIEN_CUSTOMER
select *from Customer;
select * from HOCVIEN_CUSTOMER;
MERGE INTO HOCVIEN_CUSTOMER x
USING (SELECT CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FED_ID, STATE FROM CUSTOMER) y
ON (x.CUST_ID  = y.CUST_ID)
WHEN MATCHED THEN
    UPDATE SET x.CUST_TYPE_CD = y.CUST_TYPE_CD
    WHERE x.CUST_TYPE_CD <> y.CUST_TYPE_CD
WHEN NOT MATCHED THEN
    INSERT(x.CUST_ID, x.ADDRESS, x.CITY, x.CUST_TYPE_CD, x.FED_ID, x.STATE)  
    VALUES(y.CUST_ID, y.ADDRESS, y.CITY, y.CUST_TYPE_CD, y.FED_ID, y.STATE);
--Bài 2: Viết câu lệnh lấy ra tên các gói sản phẩm và tổng số dư theo từng sản phẩm 
--mà ngân hàng đang cung cấp. Sử dụng ROW_NUMBER() để xếp loại các gói sản phẩm theo
--tổng số dư theo thứ tự giảm dần
select *from product;
select *from account;

select pr.name,
       sum(Avail_balance),
       row_number() over (order by sum(Avail_balance)desc )so_du
from account ac
join product pr
on ac.product_cd = pr.product_cd
group by pr.name;

--Bài 3 Viết câu lệnh lấy ra tên các gói sản phẩm và tổng số dư theo từng sản phẩm
--mà ngân hàng đang cung cấp. Sử dụng DENSE_RANK() để xếp loại các gói sản phẩm theo
--tổng số dư theo thứ tự giảm dần 
select pr.name,
       sum(Avail_balance),
       dense_rank() over (order by sum(Avail_balance)desc )so_du
from account ac
join product pr
on ac.product_cd = pr.product_cd
group by pr.name;

--Bài 4: Viết câu lệnh lấy ra tên các gói sản phẩm và tổng số dư theo từng sản phẩm
--mà ngân hàng đang cung cấp. Sử dụng RANK() để xếp loại các gói sản phẩm theo tổng số
--dư theo thứ tự giảm dần 
select pr.name,
       sum(Avail_balance),
       rank() over (order by sum(Avail_balance)desc )so_du
from account ac
join product pr
on ac.product_cd = pr.product_cd
group by pr.name;
--Bài 5: Tính tổng giá trị giao dịch theo từng năm, so sánh năm hiện tại với năm trước đó
--+ Bước 1: Tính tổng giao dịch theo từng năm
--+ Bước 2: Sử dụng hàm LAG để trả về tổng giao dịch so với năm trước
select bra.name,
     extract(year from atra.txn_date) nam,
       sum(atra.amount) tong,
       lag ( sum(atra.amount) ,1 ) OVER ( partition by bra.name order by extract(year from atra.txn_date)) sosanh
from branch bra
join account ac
on bra.branch_id = ac.open_branch_id
join acc_transaction atra
on  ac.account_id = atra.account_id
group by
bra.name, 
extract(year from atra.txn_date) ;

--Bài 6: Tính tổng giá trị giao dịch của từng chi nhánh theo từng năm.
--So sánh giá trị năm đó với năm tiếp theo 
--+ Bước 1: Tính tổng giao dịch theo từng năm
--+ Bước 2: Sử dụng hàm LEAD để trả về tổng giao dịch so với năm sau
select bra.name,
       extract(year from atra.txn_date) nam,
       sum(atra.amount) tong,
       LEAD ( sum(atra.amount) ,1 ) OVER ( partition by bra.name order by extract(year from atra.txn_date)) sosanh
from branch bra
join account ac
on bra.branch_id = ac.open_branch_id
join acc_transaction atra
on  ac.account_id = atra.account_id
group by bra.name,
       extract(year from atra.txn_date);
--
--Bài 7: Tính tổng giá trị giao dịch của từng chi nhánh theo từng năm. 
--So sánh giá trị năm đó với năm tiếp theo và tính % thay đổi 
select bra.name,
       extract(year from atra.txn_date) nam,
       sum(atra.amount) tong,
       LEAD ( sum(atra.amount) ,1 ) OVER ( partition by bra.name order by extract(year from atra.txn_date)) sosanh,
       ((LEAD ( sum(atra.amount) ,1 ) OVER ( partition by bra.name order by extract(year from atra.txn_date)) - sum(atra.amount))/sum(atra.amount)) *100 phantram
from branch bra
join account ac
on bra.branch_id = ac.open_branch_id
join acc_transaction atra
on  ac.account_id = atra.account_id
group by bra.name,
       extract(year from atra.txn_date);
--+ Bước 1: Tính tổng giao dịch theo từng năm
--+ Bước 2: Sử dụng hàm LAD để trả về tổng giao dịch so với năm sau
--
--
--BÀI TẬP VỀ NHÀ
--
--
--Bài 1: 
--Tạo ra 1 bảng <Tên học viên>_EMP_LOAD lấy từ bảng EMP_LOAD. Sửa đổi ngày nghỉ việc (END_DATE)
--và trạng thái (STATUS) của nhân viên trong bảng <Tên học viên>_EMP_LOAD theo yêu cầu sau
--Sử dụng Merge
--Nếu nhân viên đó đã có trong bảng: <Tên học viên>_EMP_LOAD. Kiểm tra từ bảng 
--EMPLOYEE nếu nhân viên đó có ngày END_DATE  >= START_DATE thì cập nhật lại  END_DATE và 
--STATUS  của bảng <Tên học viên>_EMP_LOAD như sau:
--<Tên học viên>_EMP_LOAD.END_DATE = EMPLOYEE.END_DATE và <Tên học viên>_EMP_LOAD.STATUS = 0
--Nếu nhân viên đó chưa có trong bảng: <Tên học viên>_EMP_LOAD. INSERT toàn bộ dữ 
--liệu từ bảng EMPLOYEE vào <Tên học viên>_EMP_LOAD 
--Sử dụng Cursor, loop… để thực hiện yêu cầu trên
CREATE TABLE "INDA02"."HUYPV_EMP_LOAD" 
   (	"EMP_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"END_DATE" DATE, 
	"FIRST_NAME" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
	"LAST_NAME" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
	"START_DATE" DATE NOT NULL ENABLE, 
	"STATUS" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

select *from employee;
select *from huypv_emp_load
order by emp_id;
select *from emp_load;

merge into HUYPV_EMP_LOAD H
using (Select EMP_ID, END_DATE, FIRST_NAME, LAST_NAME , START_DATE, STATUS  from EMP_LOAD) E
on (h.emp_id = e.emp_id)
when not matched then 
insert (h.EMP_ID, h.END_DATE, h.FIRST_NAME, h.LAST_NAME , h.START_DATE, h.STATUS)
values (e.EMP_ID, e.END_DATE, e.FIRST_NAME, e.LAST_NAME , e.START_DATE, e.STATUS);


merge into employee e
using (select end_date,status from huypv_emp_load) h
on (e.emp_id = h.emp_id)
when matched then 
update set h.end_date = e.end_date,
           h.status = 0
where  e.END_DATE  >= e.START_DATE;        
       

-- 1. Sử dụng Merge
MERGE INTO HUYPV_EMP_LOAD empl USING
(select emp_id, first_name, last_name, end_date, start_date,
CASE WHEN end_date >= start_date THEN 0
ELSE 1
END STATUS
from employee 
) emp
ON(emp.emp_id = empl.emp_id )
WHEN MATCHED THEN
  UPDATE 
  SET 
  empl.end_date = emp.end_date,
  empl.status = 0
  WHERE empl.start_date <= emp.end_date
WHEN  NOT MATCHED THEN
INSERT 
(empl.EMP_ID, empl.END_DATE, empl.FIRST_NAME, empl.LAST_NAME, empl.START_DATE, empl.STATUS)
VALUES (emp.EMP_ID, emp.END_DATE, emp.FIRST_NAME, emp.LAST_NAME, emp.START_DATE, emp.STATUS);


-- 2.	Sử dụng Con trỏ
declare
   cursor c_data is
    select   a.emp_id,
                b.emp_id as emp_id_l,
                a.first_name,
                a.last_name,
                a.end_date,
                a.start_date,
                CASE WHEN a.end_date >= a.start_date THEN 0
                ELSE 1
                END STATUS
                from employee a
      left  join HUYPV_EMP_LOAD b
        on a.emp_id = b.emp_id;
        
   type t__data is table of c_data%rowtype index by binary_integer;
   t_data t__data;
   
begin

   open c_data;
   loop
      fetch c_data bulk collect into t_data limit 10000;
      exit when t_data.count = 0;
      for idx in t_data.first .. t_data.last loop
         if t_data(idx).emp_id_l is null then
            insert into HUYPV_EMP_LOAD (EMP_ID, END_DATE, FIRST_NAME, LAST_NAME, START_DATE, STATUS)
            VALUES (t_data(idx).EMP_ID, t_data(idx).END_DATE, t_data(idx).FIRST_NAME, t_data(idx).LAST_NAME,
                            t_data(idx).START_DATE,
                            t_data(idx).STATUS);
         else
            update HUY_EMP_LOAD
               set END_DATE = t_data(idx).END_DATE,
               STATUS = t_data(idx).STATUS
             where emp_id = t_data(idx).emp_id_l ;
         end if;
      end loop;
   end loop;
   close c_data;
end;
--Bài 2: 
--Tạo ra 1 bảng <Tên học viên>_CUST_LOAD lấy từ bảng CUST_LOAD. Sử dụng Merge để 
--xếp hạng khách hàng (RANK_TRANS) của bảng <Tên học viên>_CUST_LOAD theo hướng dẫn sau:
--Dùng hàm ranking để xếp hạng khách hàng theo tổng số lần giao dịch 
--(khách hàng cùng tổng số lần giao dịch sẽ cùng hạng).
--Cập nhật lại xếp hạng (RANK_TRANS) của bảng <Tên học viên>_CUST_LOAD theo 
--như Rank đã tính được ở bước 1 nếu như Rank của chúng khác nhau
--Thêm mới toàn bộ dữ liệu đã tính được từ bước 1 vào bảng <Tên học viên>_CUST_LOAD 
--nếu như khách hàng đó chưa được xếp hạng vào ngày hôm đó
--* Giả sử: Mỗi ngày sẽ phải tính Rank của khách hàng 1 lần. Nghĩ đến phương án làm 
--sao chỉ cho phép cập nhật hoặc thêm mới vào bảng <Tên học viên>_CUST_LOAD 1 lần/1 ngày

CREATE TABLE "INDA02"."HUYPV_CUST_LOAD" 
   (	"CUST_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"RANK_TRANS" NUMBER, 
	"UPDATE_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  MERGE INTO HUYPV_CUST_LOAD cl USING
(select cst.CUST_ID, 
count(1) AS AVL,
DENSE_RANK() OVER(  ORDER BY count(1) DESC) AS RANK_TRANS,
TRUNC(SYSDATE) AS UPDATE_DATE
from customer cst
join account acc on cst.cust_id = acc.cust_id
join acc_transaction acc_t on acc_t.account_id = acc.account_id
GROUP BY cst.CUST_ID,TRUNC(SYSDATE)
) c
ON(c.CUST_ID = cl.CUST_ID AND c.UPDATE_DATE = cl.UPDATE_DATE)
WHEN MATCHED THEN
  UPDATE 
  SET 
  cl.RANK_TRANS = c.RANK_TRANS
  WHERE cl.RANK_TRANS <> c.RANK_TRANS
WHEN  NOT MATCHED THEN
INSERT (cl.CUST_ID,cl.RANK_TRANS,cl.UPDATE_DATE)
VALUES (c.CUST_ID,c.RANK_TRANS,c.UPDATE_DATE);

select *from huypv_cust_load;
--Bài 3:
--Viết câu lệnh lấy ra tổng số dư theo từng tài khoản của mỗi khách hàng. 
--Sử dụng Hàm Ranking để xếp loại tài khoản của mỗi khách hàng theo số dư tài khoản. 
--Lấy ra top 1 và 2 của mỗi tài khoản đó
--SELECT * FROM (
--select cst.CUST_ID, 
--acc.ACCOUNT_ID, 
--SUM(AVAIL_BALANCE) AS AVL,
--ROW_NUMBER() OVER(PARTITION BY cst.CUST_ID  ORDER BY SUM(AVAIL_BALANCE) DESC) AS lowest_score_rank
--from customer cst
--join account acc on cst.cust_id = acc.cust_id
--GROUP BY cst.CUST_ID, acc.ACCOUNT_ID
--)  A WHERE A.lowest_score_rank IN (1,2)


--Bài 4
--Tính tổng số dư tài khoản (AVAIL_BALANCE) theo từng năm và sản phẩm 
--sản phẩm dịch vụ của ngân hàng. Chỉ tính những tài khoản sản phẩm mở từ năm 
--2000 đến năm 2003 (OPEN_DATE).So sánh với năm trước đó và tính % thay đổi


--SELECT
--prd.YEAR, 
--prd.NAME,
--prd.year_sales,
--prd.prev_year_sales,
--NVL(ROUND((prd.year_sales - prd.prev_year_sales) / nullif( prd.year_sales,0), 3) * 100,0) percent_change
--FROM
-- (
-- SELECT
-- EXTRACT( Year FROM OPEN_DATE) AS YEAR,
-- NAME, 
--SUM(AVAIL_BALANCE) year_sales,
--LAG(SUM(AVAIL_BALANCE), 1,0)  OVER (PARTITION BY NAME ORDER BY NAME) prev_year_sales
--  FROM PRODUCT
--  JOIN ACCOUNT ON ACCOUNT.PRODUCT_CD = PRODUCT.PRODUCT_CD
--  WHERE EXTRACT( Year FROM OPEN_DATE)  BETWEEN 2000 AND 2003
--  GROUP BY  EXTRACT( Year FROM OPEN_DATE),NAME
--  ) 









--BAI4:SEQUENCE

--Ví dụ: Câu lệnh sau đây tạo ra một chuỗi tăng dần được gọi là id_seq, bắt đầu từ 10,
--tăng 10, giá trị tối thiểu 10, giá trị tối đa 100. Chuỗi trả về 10 khi nó đạt 100 vì CYCLE tùy
--chọn

--CREATE SEQUENCE id_seq
--INCREMENT BY 10
--START WITH 10
--MINVALUE 10
--MAXVALUE 100
--CYCLE
--CACHE 2;




--CREATE SEQUENCE employee_seq
--START WITH 1
--INCREMENT BY 1
--MAXVALUE 1000
--NOCYCLE;




------------------ SEQUENCE-----------------------------

-- Chèn dữ liệu cho CUST_ID = 1
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (1, 100, TO_DATE('2023-10-01', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 2
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (2, 90, TO_DATE('2023-10-02', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 3
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (3, 80, TO_DATE('2023-10-03', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 4
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (4, 70, TO_DATE('2023-10-04', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 5
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (5, 60, TO_DATE('2023-10-05', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 6
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (6, 50, TO_DATE('2023-10-06', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 7
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (7, 40, TO_DATE('2023-10-07', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 8
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (8, 30, TO_DATE('2023-10-08', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 9
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (9, 20, TO_DATE('2023-10-09', 'YYYY-MM-DD'));

-- Chèn dữ liệu cho CUST_ID = 10
INSERT INTO HUYPV_CUST_LOAD (CUST_ID, RANK_TRANS, UPDATE_DATE)
VALUES (10, 10, TO_DATE('2023-10-10', 'YYYY-MM-DD'));
--Yêu cầu: 
--Bạn hãy mở lại slide bài học về Sequence và thực thành theo các ví dụ đã được đề cập trong đó.
--
--Bài 1: 
--+ Tạo ra một Sequence là my_seq, bắt đầu từ 1, tăng 1, giá trị tối thiểu 1, giá trị tối đa 10, 
--sử dụng tùy chọn Cycle
--+ Lấy ra 10 giá trị tiếp theo của Sequence
--+ Lấy ra giá trị hiện tại của Sequence



CREATE SEQUENCE my_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 10
CYCLE
CACHE 9;

drop sequence my_seq;

select my_seq.Nextval
from dual
connect by level <=10;


SELECT my_seq.CURRVAL
FROM dual;


--
--Bài 2: 
--+ Tạo 1 bảng theo mẫu sau:
--CREATE TABLE My_Table(
--    id NUMBER PRIMARY KEY,
--    title VARCHAR2(255) NOT NULL);

create table HUYPV_Table
(
   id number primary key,
   title varchar2(255) not null
);
--+  INSERT 2 bản ghi mới vào bảng My_Table với ID: tự tăng bằng cách sử dụng Sequence bài 1, Tittle: Tùy chọn
--+ Thực hiện truy vấn Select để kiểm tra
insert into HUYPV_Table(id,title) values (my_seq.nextval, 'HUY');
insert into HUYPV_Table(id,title) values (my_seq.nextval, 'Duyen');
--Bài 3: 
--+ Drop bảng My_Table vừa tạo

drop table HUYPV_Table;


--+ Tạo lại bảng theo code mẫu sau:
--CREATE TABLE tasks(
--    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--    title VARCHAR2(255) NOT NULL);

CREATE TABLE HUYPV_Table(
  id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   title VARCHAR2(255) NOT NULL);

   
--+ INSERT 2 bản ghi mới vào bảng My_Table với Tittle: Tùy chọn (Lưu ý: Không cần khai báo id)
--+ Thực hiện truy vấn để kiểm tra
insert into HUYPV_Table(title) values ( 'HUY');
insert into HUYPV_Table(title) values ( 'Duyen');
--
---------- TRANSACTION ---------
--
--
--Bài 1: 

  CREATE TABLE "INDA02"."HUYPV_CUSTOMER" 
   (	"CUST_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"ADDRESS" VARCHAR2(30 CHAR), 
	"CITY" VARCHAR2(20 CHAR), 
	"CUST_TYPE_CD" VARCHAR2(1 CHAR) NOT NULL ENABLE, 
	"FED_ID" VARCHAR2(12 CHAR) NOT NULL ENABLE, 
	"POSTAL_CODE" VARCHAR2(10 CHAR), 
	"STATE" VARCHAR2(20 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--+ Thêm 1 bản ghi mới vào bảng ‘HOCVIEN_CUSTOMER’ sau đó sử dụng COMMIT
INSERT INTO HUYPV_CUSTOMER (CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FED_ID, POSTAL_CODE, STATE)
VALUES (1, 'Ninh Giang', 'Hai Duong', 'A', '1234567890', '12345', 'Huy');
commit;
--+ Thêm 1 bản ghi mới vào bảng ‘HOCVIEN_CUSTOMER’ sau đó sử dụng ROLLBACK
INSERT INTO HUYPV_CUSTOMER (CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FED_ID, POSTAL_CODE, STATE)
VALUES (1, 'Ninh Giang', 'Hai Duong', 'A', '1234567890', '12345', 'huyphung');
rollback;
--Select dữ liệu và đưa ra nhận xét
select *from HUYPV_CUSTOMER;
--Bài 2:  
--+ Thêm 1 bản ghi mới vào bảng ‘HOCVIEN_CUSTOMER’ sau đó sử dụng SAVEPOINT + Tên_saveponint
Savepoint Huy;
INSERT INTO HUYPV_CUSTOMER (CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FED_ID, POSTAL_CODE, STATE)
VALUES (1, 'Hau Loc', 'Thanh Hoa', 'A', '123456', '12345', 'HuyVanPhung');
--+ Xóa bản ghi trước đó (bản ghi có ID sau bản ghi vừa thêm)
delete from HUYPV_CUSTOMER where cust_id=1;
select *from HUYPV_CUSTOMER;
--+ Sử dụng lệnh ROLLBACK TO Tên_saveponint
Rollback to Huy;
select *from HUYPV_CUSTOMER;
--+ Tiếp tục sử dụng COMMIT
commit ;
--Select dữ liệu và đưa ra nhận xét
select *from HUYPV_CUSTOMER;
--
--Bài 3:
--+  Thêm 1 bản ghi mới vào bảng ‘HOCVIEN_CUSTOMER’
INSERT INTO HUYPV_CUSTOMER (CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FED_ID, POSTAL_CODE, STATE)
VALUES (1, 'Hau Loc', 'Thanh Hoa', 'A', '123456', '12345', 'HuyVanPhung');
--+ Thêm 1 bản ghi mới vào bảng ‘HOCVIEN_CUSTOMER’ (Cố tính ghi sai cấu trúc)
INSERT INTO HUYPV_CUSTOMER (CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FED_ID, POSTAL_CODE, STATE)
VALUES (4, 'Hau Loc', '3', 'A', '123456', '1fds', 'Phung');
INSERT INTO HUYPV_CUSTOMER (CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FED_ID, POSTAL_CODE, STATE)
VALUES (2, '456 Elm St', ' City', '*', '9876543210', '54321', 'State');
commit;
--+ Sử dụng COMMIT
--Select dữ liệu và đưa ra nhận xét
select *from HUYPV_CUSTOMER;







--BÀI 5 : Funtion, Procedure
--Return 

CREATE OR REPLACE FUNCTION tinh_tong(
    p_so1 IN NUMBER,
    p_so2 IN NUMBER
) RETURN NUMBER IS
    v_tong NUMBER;
BEGIN
    v_tong := p_so1 + p_so2;
    RETURN v_tong;
END tinh_tong;



DECLARE
    ket_qua NUMBER;
BEGIN
    ket_qua := tinh_tong(10, 20);
    DBMS_OUTPUT.PUT_LINE('Tong la: ' || ket_qua);
END;



--create  or replace function huypv_concat_name( n1 in nvarchar2, n2 in nvarchar2)
--return nvarchar2 in n3 nvarchar2(20);
--begin n3 := n1 || ' ' || n2;
--return n3;
--end;

select huypv_concat_name ('phung','huy')from dual;



--Ví dụ: Viết Function truyền vào Mã nhân viên và trả về tên phòng ban nhân viên đó đang làm việc
set serveroutput on;
CREATE OR REPLACE FUNCTION Huypv_Get_Emp_Department (p_Emp_Id Number)
RETURN department.name%type IS
v_department department.name%type;
BEGIN
SELECT d.Name
INTO v_department
FROM Employee Emp, department d
WHERE Emp.dept_id = d.dept_id AND Emp.Emp_Id = p_Emp_Id;
EXCEPTION
When No_Data_Found Then v_department := Null;
RETURN v_department;
END;

set serveroutput on;
exec  Huypv_Get_Emp_Department(3);  





-- Làm lại các ví dụ trong Slide
------------------ FUNCTION-----------------------------
--Bài 1.
-- Viết 1 Function với tham số đầu vào là NĂM cần lấy dữ liệu. 
--Tính tổng số dư tài khoản (ACCOUNT) của tất cả khách hàng có Năm mở tài khoản bằng NĂM truyền vào
--

CREATE OR REPLACE FUNCTION get_total_acc(
    in_year PLS_INTEGER
) 
RETURN account.avail_balance%type
IS
v_relt account.avail_balance%type;
BEGIN
    -- get total sales
    select sum(avail_balance) into v_relt
    from account
    where extract(year from open_date) = y;
    RETURN v_relt;    
END;


--Bài 2.  
--Viết 1 Function với tham số đầu vào là ID của khách hàng.
--Lấy ra Tống số TK đã mở của khách hàng có ID = ID truyền vào
--
create or replace function cust_info(cusid in individual.cust_id%type) 
return NUMBER
is v_count NUMBER;
begin
select
  count(account_id) acc_quan into v_count
    from account c
    where  c.cust_id = cusid;
    --group by i.first_name,i.last_name,i.birth_date,c.address;
    return v_count;
end;
--Bài 3.
--Viết 1 Function với tham số đầu vào là ID nhân viên
--Thực hiện Tính số năm đã làm việc của nhân viên đó theo công thức sau:
--work_exp  = Số tháng của Ngày hiện tại so với ngày bắt đầu vào làm / 12
--Thực hiện truy vấn lấy ra thông tin của nhân viên bao gồm: Họ, Tên, Ngày bắt đầu làm việc,
--số tháng đã làm việc (Gọi đến Function trên)
--
select *from employee;
select *from department;
set serveroutput on;
create or replace function emp_workk (empid in employee.emp_id%type)
return int
is v_exp int;
begin 
select round(months_between(sysdate, start_date)/12,0) into v_exp
from employee
where emp_id = empid;
return v_exp;
end;
set serveroutput on;
exec emp_workk(2);

--Bài 4:
--Viết Function “FUNC_Get_Emp_Department” với tham số đầu vào là mã nhân viên EMP_ID
--và trả về tên phòng ban mà nhân viên đó làm việc (Dept_Name).
---Yêu cầu 1: Truyền vào ID là 1 và hiện thị kết quả ra màn hình “Get_Emp_Department(1)”;
---Yêu cầu 2: Viết lệnh SELECT để lấy ra toàn bộ EMP_ID, First_Name, Last_Name 
--và tên phòng ban sử dụng Function “FUNC_Get_Emp_Department”.
--
--
--
--create or replace function FUNC_Get_Emp_Department (p_emp_id number)
--return varchar2 as 
---- khai báo một biến v_emp_frist_name
--v_department department.name%type
-- 
--Begin
--     Select Emp.First_Name
--     Into   v_department
--     From   Employee Emp, department d
--    where Emp.dept_id = d.dept_id
--     and  Emp.Emp_Id = p_emp_id;
--  Exception
--     When No_Data_Found
--     Then
--        -- Gán null trong trường hợp không tìm thấy Employee
--        -- ứng với p_Emp_ID
--        v_Emp_First_Name := Null;
--  End;
--  --
--  Return  v_department;
--End;

/*Bài 1:
 Viết  1 procedure không có tham số. Trả về tất cả thông tin của các nhân viên bao gồm:
 Họ, Tên, Phòng ban, Ngày vào làm
 */
create or replace
PROCEDURE all_emp
AS

    CURSOR c1 IS
    select first_name,last_name,d.name,e.start_date
    from employee e, department d
    where e.dept_id = d.dept_id;
    
    
    firstname employee.first_name%TYPE;
    lastname employee.last_name%TYPE;
    name department.name%TYPE;
    startdate employee.start_date%TYPE;

BEGIN
    open c1;

    LOOP

       fetch c1 into firstname,lastname,name,startdate;
       -- FETCH c1 INTO my_ename;
        --FETCH c1 INTO my_salary;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(firstname || '| ' ||lastname || '| ' || name || '| ' || startdate);
    end loop;
end;
set serveroutput on;
execute all_emp;
 
/*Bài 2:
Viết procedure “PRO_Get_Employee_Info” cho phép truyền vào ID của nhân viên và trả về First_Name, Last_Name, Dept_ID của nhân viên đó.
Gợi ý: khai báo 3 biến: First_Name, Last_Name, Dept_ID để đón kết quả  OUT từ  procedure.
Chạy Procedure và hiển thị kết quả bằng câu lệnh DBMS_OUTPUT.PUT_LINE().
*/
create or replace Procedure HUYPV_Get_Employee_Infos(p_Emp_Id   in  Number
                                             ,v_First_Name Out Varchar2
                                             ,v_Last_Name  Out Varchar2
                                             ,v_Dept_Id    Out Number) Is
Begin
  -- Ghi ra màn hình console.
  -- Dành cho người lập trình biết chương trình chạy thế nào.
  Dbms_Output.Put_Line('Parameter p_Emp_Id = ' || p_Emp_Id);
  --
  -- Nếu câu lệnh Select này nếu không có bản ghi nào
  -- nó sẽ ném ra Exception NO_DATA_FOUND:
  --
  -- Câu lệnh Select ở này sẽ không trả về
  -- nhiều hơn 1 bản ghi vì Emp_Id là duy nhất
  -- trong bảng EMPLOYEE.
  -- Do vậy không xẩy ra ngoại lệ TOO_MANY_ROWS
  --
  Select Emp.First_Name
        ,Emp.Last_Name
        ,Emp.Dept_Id
  Into   v_First_Name
        ,v_Last_Name
        ,v_Dept_Id
  From   Employee Emp
  Where  Emp.Emp_Id = p_Emp_Id;
  --
  -- Ghi ra màn hình Console.
  --
  Dbms_Output.Put_Line('Found Record!');
  Dbms_Output.Put_Line(' v_First_Name= ' || v_First_Name);
  Dbms_Output.Put_Line(' v_Last_Name= ' || v_Last_Name);
  Dbms_Output.Put_Line(' v_Dept_Id= ' || v_Dept_Id);
Exception
  When No_Data_Found Then
     -- Ghi ra màn hình Console.
     Dbms_Output.Put_Line('No Record found with p_Emp_Id = ' || p_Emp_Id);
End Get_Employee_Infos;
/
-- Chạy lệnh và kiểm tra:
SET serveroutput ON;  
DECLARE
v_emp_id number := 1;
v_First_Name VARCHAR2(50);
v_Last_Name VARCHAR2(50);
v_Dept_Id Number;
BEGIN
dbms_output.put_line('Thông tin nhân viên bao gồm: ');
Get_Employee_Infos(v_emp_id, v_First_Name,v_Last_Name,v_Dept_Id);
dbms_output.put_line('ID:' || v_emp_id || '- First Name: ' || v_First_Name || '- Last Name: ' || v_Last_Name);	
END;
-- Chạy lệnh và kiểm tra:
SET serveroutput ON;  
DECLARE
v_emp_id number := 1;
v_First_Name VARCHAR2(50);
v_Last_Name VARCHAR2(50);
v_Dept_Id Number;
BEGIN
dbms_output.put_line('Thông tin nhân viên bao gồm: ');
Get_Employee_Infos(v_emp_id, v_First_Name,v_Last_Name,v_Dept_Id);
dbms_output.put_line('ID:' || v_emp_id || '- First Name: ' || v_First_Name || '- Last Name: ' || v_Last_Name);	
END;


/*Bài 3: 
 Viết 1 Procedure trả ra phân khúc khách hàng theo từng khách hàng truyền vào theo công thức sau:
Nếu:
 “AVAIL_BALANCE <= 4000” thì SEGMENT là: “LOW”,
“AVAIL_BALANCE > 4000 và AVAIL_BALANCE <= 7000” thì SEGMENT là: “MEDIUM”, “AVAIL_BALANCE >7000” thì SEGMENT là: “HIGH”
(Gợi y: 2 tham số: IN – id khách hàng, OUT- segment)
*/

create or replace Procedure Get_Cust_Seg(p_Cust_Id     Number
                                             ,v_Segment Out Varchar2
                                             ) 
Is
   cursor c1 is
     SELECT sum(AVAIL_BALANCE) AVAIL_BALANCE,
     FIRST_NAME || LAST_NAME NAME
     FROM account
     join customer on customer.cust_id = account.cust_id
     join individual on individual.cust_id = customer.cust_id
     WHERE customer.Cust_id = p_Cust_Id
     GROUP BY FIRST_NAME || LAST_NAME;
-- Khái báo Rowtype dựa trên cursor vừa tạo

 
BEGIN
-- Sử dụng vòng lặp.
   FOR rec IN c1 LOOP
       IF rec.AVAIL_BALANCE <= 4000 THEN
          v_Segment := 'Low';
       ELSIF rec.AVAIL_BALANCE > 4000 and rec.AVAIL_BALANCE <= 7000 THEN
          v_Segment := 'Medium';
       ELSE
          v_Segment := 'High';
       END IF;
    -- Điều kiện thoát khỏi vòng lặp.   
       Dbms_Output.Put_Line('KH: ' || rec.NAME || '-' || v_Segment);
   end loop;
END;

SET SERVEROUTPUT ON

DECLARE
    v_customer_id NUMBER;
    v_segment VARCHAR2(50);
BEGIN
    FOR cust_rec IN (SELECT cust_id FROM customer) LOOP
        -- Gọi thủ tục và truyền tham số
        Get_Cust_Seg(cust_rec.cust_id, v_segment);

        -- Hiển thị kết quả
       -- DBMS_OUTPUT.PUT_LINE('Segment for Customer ID ' || cust_rec.cust_id || '- ' || v_segment);
    END LOOP;
END;





------ BÀI TẬP VỀ NHÀ -----
/* 1.	Viết 1 FUNCTION cho phép truyền vào 1 tham số. Nếu tham số truyền vào là ‘EMP’ thì lấy ra tổng số nhân viên, nếu tham số truyền vào là ‘DEPT’ thì lấy ra tổng số phòng ban.
*/
CREATE OR REPLACE FUNCTION names_for (
         name_type_in IN VARCHAR2)
      RETURN NUMBER
   IS
      l_return   NUMBER;
   BEGIN
      CASE name_type_in
         WHEN 'EMP'
         THEN
                SELECT count(1) into l_return
                  FROM employee;
        WHEN 'DEPT'
        THEN
    
                SELECT count(distinct name) into l_return
                  FROM department;
     END CASE;

     RETURN l_return;
  END names_for;

/*2.	Viết 1 FUNCTION cho phép truyền vào ID tài khoản (account_id). Lấy ra trạng thái của giao dịch mới nhất ứng với ID tài khoản đó theo yêu cầu sau:
+ Nếu Giao dịch mới nhất >= ngày hiện tại thì trạng thái : 'The payment has been Completed'
+ Nếu Giao dịch mới nhất < ngày hiện tại thì trạng thái : Ngày giao dịch + ' yet to be paid'
+ Còn lại: 'Invalid payment'
*/
CREATE OR REPLACE FUNCTION find_balance ( acc_id  IN  account.account_id%type) 
RETURN VARCHAR2
IS      date_status varchar(100); 
        v_date date; 
        BEGIN
        SELECT max(CAST(FUNDS_AVAIL_DATE AS DATE)) INTO v_date
        FROM account acc 
        , acc_transaction acc_tran
        WHERE acc.account_id = acc_tran.account_id
        AND acc_tran.account_id = acc_id;
        
        IF      v_date = sysdate THEN date_status := 'The payment has been Completed';
        ELSIF   v_date < sysdate THEN date_status := TO_CHAR(v_date) ||' yet to be paid';
        ELSE    date_status := 'Invalid payment';
        END IF;
        
        RETURN date_status;
        END find_balance;

/*3.	Viết 1 Function cho phép truyền vào tham số là ngày bất kỳ.
Lấy ra tất cả nhân viên có ngày bắt đầu làm việc >= ngày truyền vào
(Lưu ý: Có trường hợp nhân viện đã nghỉ và lại tiếp tục đi làm trở lại)
*/
create type short_string_tt as table of varchar2(100);
create or replace function get_employees
    ( p_role_date_cutoff employee.start_date%type )
    return short_string_tt
as

    l_employee_list short_string_tt;
begin
    select emp_id bulk collect into l_employee_list
    from   ( select emp_id
                  , row_number() over(partition by emp_id order by start_date desc, emp_id desc) rn
             from   ( select distinct e.emp_id, e.first_name, e.last_name, e.start_date, d.name
                      from   employee e
                             join department d
                                  on  e.dept_id = d.dept_id
                      where  e.start_date >= p_role_date_cutoff )
           )
    where  rn = 1;

    return l_employee_list;
end;
/

SELECT * from table(get_employees(to_date('09/02/2000', 'dd/mm/yyyy')));

/*4.	Viết 1 Function cho phép truyền vào tham số là ngày bất kỳ.
Lấy ra tổng số các tài khoản đã được mở của tất cả nhân viên tính đến
thời điểm là ngày truyền vào và chỉ tính những nhân viên có số tháng làm 
việc tính đến thời điểm ngày truyền vào là >13 tháng
*/
CREATE OR REPLACE FUNCTION date_cal ( o_date employee.start_date%type )
RETURN INT
IS
diff INT :=0;
sum_ INT;
CURSOR cur IS SELECT * FROM employee;
BEGIN
sum_ := 0;
FOR usr IN cur LOOP
    SELECT count(1)
    INTO diff
    FROM account
    WHERE open_emp_id = usr.emp_id
    and OPEN_DATE < o_date;


    IF round(months_between(sysdate,usr.start_date)/12,0) > 13 THEN
       sum_ := sum_ + diff;
    END IF;

    DBMS_OUTPUT.PUT_LINE('return: ' || sum_);
END LOOP;

DBMS_OUTPUT.PUT_LINE('return: ' || sum_);
RETURN sum_;
END date_cal;

/*5.	Viết 1 Procedure cho phép truyền vào 2 tham số: Mã phòng ban, Hệ  số lương.
Cập nhật lại lương của NV có mã phòng ban truyền vào theo yêu  cầu sau:
* Sử dụng Function work_time để kiểm tra xem nhân viên đó có số năm làm việc  >=13 hay không.
Nếu đủ thì update lại lương của NV (Bảng hocvien_employee) đó theo CT:
Lương mới = lương cũ + lương cũ * hệ số lương
*/
CREATE OR REPLACE PROCEDURE increase_salary (
   department_id_in   IN employee.dept_id%TYPE,
   increase_pct_in    IN NUMBER)
IS
   l_eligible  INT;
BEGIN
   FOR employee_rec
      IN (SELECT emp_id
            FROM employee
           WHERE dept_id =
                    increase_salary.department_id_in)
   LOOP
      l_eligible := work_time (employee_rec.emp_id);

      IF l_eligible >=13
      THEN
         UPDATE hocvien_employee emp
            SET emp.salary =
                     emp.salary
                   +   emp.salary
                     * increase_salary.increase_pct_in
          WHERE emp.emp_id = employee_rec.emp_id;
      END IF;
   END LOOP;
END increase_salary;

/*6.	Viết 1 Procedure cho phép truyền vào tên sản phẩm dịch vụ của ngân hàng đang cung cấp 
và thực hiện công việc sau:
+ Tính tổng số dư theo từng tên sản phẩm dịch vụ của ngân hàng đang cung cấp 
tính đến ngày hiện tại (sysdate) (Mã sản phẩm, Tổng số dư, Ngày tính toán)
+ INSERT dữ liệu đó vào bảng HOCVIEN_BC_PRODUCT theo các trường thông tin
tương ứng (Check điều kiện: Mỗi sản phẩm chỉ được INSERT 1 lần/1 ngày)
*/
create or replace PROCEDURE insert_product (prd_name IN VARCHAR2)
IS
    TYPE product_cd_tb IS TABLE OF account.product_cd%TYPE; 
    TYPE product_avail_tb IS TABLE OF account.avail_balance%TYPE; 
    product_cd_rec  product_cd_tb;
    product_avail_rec  product_avail_tb;
BEGIN

   SELECT account.product_cd, sum(AVAIL_BALANCE) as avail_balance 
   BULK COLLECT INTO product_cd_rec, product_avail_rec
   FROM account, product  
    WHERE account.product_cd = product.product_cd
    AND product.NAME = insert_product.prd_name
    group by account.product_cd;
    FORALL i IN 1 .. product_cd_rec.COUNT  
            INSERT INTO hocvien_bc_product(PRODUCT_CD, AVAIL_BALANCE, ETL_DATE)
            SELECT product_cd_rec(i), product_avail_rec(i), sysdate FROM DUAL
            WHERE  NOT EXISTS 
            (   SELECT  1
                FROM    hocvien_bc_product 
                WHERE   PRODUCT_CD = product_cd_rec(i)
                AND     ETL_DATE = sysdate
            );
            --VALUES (product_cd_rec(i), product_avail_rec(i), sysdate);


  COMMIT;
  --total := select count(*) from hocvien_bc_product where ETL_DATE = sysdate;  
END insert_product;


EXEC insert_product('checking account')

/*7.	Viết 1 Procedure không tham số thực hiện công việc UPDATE/INSERT dữ liệu trong bảng hocvien_customer theo điều kiện sau:
Kiểm tra trong bảng hocvien_customer đã có dữ liệu khách hàng của bảng customer chưa? (So sánh cust_id 2 bảng với nhau)
+ Nếu đã có thì UPDATE lại toàn bộ dữ liệu của các trường bảng hocvien_customer theo dữ liệu các trường tương ứng bảng customer
+ Nếu chưa thì INSERT dữ liệu vào bảng hocvien_customer  theo các trường tương ứng của bảng customer
*/
create or replace PROCEDURE update_cust 
IS
  CURSOR cus IS SELECT * FROM customer;
  EX PLS_INTEGER;
BEGIN

  FOR c IN cus
  LOOP

    SELECT COUNT(*) INTO EX FROM hocvien_customer hv_cust WHERE
    hv_cust.CUST_ID = c.CUST_ID ;

    IF EX > 0 THEN
      UPDATE hocvien_customer SET address = c.address,
                              city = c.city,
                              cust_type_cd = c.cust_type_cd,
                              fed_id = c.fed_id,
                              postal_code = c.postal_code,
                              state = c.state
      WHERE CUST_ID = c.CUST_ID ;
      ELSE

      INSERT INTO hocvien_customer(cust_id, address, city, cust_type_cd, fed_id, postal_code, state)
        VALUES (c.cust_id, c.address, c.city, c.cust_type_cd, c.fed_id, c.postal_code, c.state);

    END IF;

  END LOOP;
  COMMIT;

END update_cust;

/*8.	Viết 1 Procedure cho phép truyền 3 tham số: User đăng nhập db, kiểu dữ liệu của cột, giá trị cần tìm. Tìm tổng số bản ghi của mỗi trường trong mỗi bảng có giá trị giống với giá trị truyền vào. In ra kết quả theo mẫu sau: TÊN BÁNG + TÊN CỘT + TỔNG SỐ GIÁ TRỊ
(Ví dụ: Với bảng CUSTOMER với giá trị cần tìm là ‘%ma%’ thì mỗi CỘT trong bảng CUSTOMER sẽ có tổng những giá trị tương ứng vs giá trị cần tìm như sau :
CUSTOMER - ADDRESS - 4
CUSTOMER - CITY - 4
)
* Gợi ý: Sử dụng câu lệnh sau để lấy ra tất cả bảng + cột trong db: SELECT  owner, table_name, column_name FROM all_tab_columns WHERE owner = 'USER01' and data_type LIKE '%CHAR%'
*/
create or replace PROCEDURE find_value (
   v_user   IN VARCHAR2,
   v_type    IN VARCHAR2,
   v_value IN VARCHAR2
   )
IS
      match_count INTEGER;
    BEGIN
      FOR t IN (SELECT  owner, table_name, column_name
                  FROM all_tab_columns
                  WHERE owner = find_value.v_user and data_type LIKE UPPER('%'||find_value.v_type||'%')) LOOP

        EXECUTE IMMEDIATE
          'SELECT COUNT(*) FROM ' || t.owner || '.' || t.table_name ||
          ' WHERE '||t.column_name||' like  UPPER(''%'||find_value.v_value||'%'')'
          INTO match_count;

        IF match_count > 0 THEN
          dbms_output.put_line( t.table_name ||' '||t.column_name||' '||match_count );
        ELSE
        dbms_output.put_line( 'No Count' );
        END IF;

      END LOOP;

END find_value;


EXEC find_value('USER01', 'CHAR', 'S')




--Bai6: PACKAGE, TRIGGER

--vidu

create or replace package Phunghuy_Account_spec
as
v_active_status Constant varchar(10) := 'Active';
v_inactive_status Constant varchar(10) := 'Inactive';
--cursor that returns the order detail
cursor g_cust_acc(p_cust_id number)
is 
select 
customer.cust_id,
customer.address,
account.account_id,
account.avail_balance,
account.status
from account 
inner join customer on customer.cust_id = account.cust_id;
--get avail_balance of cust
function get_avail_value(p_cust_id number)
return number;
--get avail_balance of emp
function get_avail_by_emp(p_emp_id number, p_year number)
return number;
end Phunghuy_Account_spec;


--body
create or replace package body  Phunghuy_Account_spec
as
--get avail_balance of cust
function get_avail_value(p_cust_id number)
return number 
is
In_vail_value number;
begin
select 
sum(avail_balance) into In_vail_value
from account
where cust_id = p_cust_id;
return p_cust_id;
exception
when no_data_found then
dbms_output.put_line(sqlerrm);
end get_avail_value;
end Phunghuy_Account_spec;


create or replace package body  Phunghuy_Account_spec
as
--get avail_balance of cust
function get_avail_by_emp(p_emp_id number, p_year number)
return number 
is
In_vail_value number;
begin
select 
sum(avail_balance) into In_vail_value
from account
where 
extract(year from open_date) = p_year
and open_emp_id = p_emp_id
and status = v_active_status;
return In_vail_value;
exception
when no_data_found then
dbms_output.put_line(sqlerrm);
end get_avail_by_emp;
end Phunghuy_Account_spec;

drop package Phunghuy_Account_spec;
select Phunghuy_Account_spec.get_avail_value(0) from dual;



/*Bài 1.
Làm lại ví dụ mẫu trong Slide
Viết 1 Package thực hiện yêu cầu sau:
-  1 Con trỏ trả về chi tiết tài khoản theo ID khách hàng truyền vào bao gồm 
các thông tin sau: Mã khách hàng, Địa chỉ khách hàng, ID tài khoản, Số dư, Trạng thái
-  1 Hàm cho phép truyền vào: ID khách hàng. Trả về Tổng số dư theo khách hàng
-  1 Hàm cho phép truyền vào: ID nhân viên mở + Năm mở tài khoản. Trả về Tổng số dư
theo nhân viên mở tài khoản 
Gọi con trỏ, Hàm thông qua package vừa tạo
*/
create or replace package cust_pak is

    cursor cust_inf (v_cusid customer.cust_id%type)is
        select a.cust_id,c.address,a.account_id,sum(a.avail_balance) tot_bal,a.status
        from account a, customer c
        where a.cust_id = c.cust_id
        and a.cust_id = v_cusid
        group by a.cust_id,c.address,a.account_id,a.status;
    function cust_bal(v_cusid customer.cust_id%type) return float;
    function ybal_by_emp (v_emp employee.emp_id%type, v_year int) return float;

end cust_pak;

create or replace package body cust_pak is
    
    function cust_bal(v_cusid customer.cust_id%type) return float
    is v_bal float;
    begin
        select sum(avail_balance)
        into v_bal
        from account
        where cust_id  = v_cusid;
        
        return v_bal;
        exception
            when no_data_found then
            dbms_output.put_line('NO DATA FOUND');
    end cust_bal;
    
    function ybal_by_emp (v_emp employee.emp_id%type, v_year int) return float
    is v_tot_bal int;
    begin
        select sum(avail_balance)
        into v_tot_bal
        from account
        where open_emp_id = v_emp
        and extract(year from open_date) = v_year;
        return v_tot_bal;
        exception
            when no_data_found then
            dbms_output.put_line('NO DATA FOUND');
    end ybal_by_emp;

end cust_pak;

select cust_pak.cust_inf(1) from dual;
select cust_pak.cust_bal(2) from dual;
select cust_pak.ybal_by_emp(10,2005) from dual;
set serveroutput on;
DECLARE
    cust_id number;
    address varchar2(100);
    account_id number;
    tot_bal number;
    status varchar2(100);
BEGIN
   OPEN cust_pak.cust_inf (10);
   LOOP
      FETCH cust_pak.cust_inf INTO cust_id,address,account_id,tot_bal,status; 
      Dbms_Output.Put_Line(' v_First_Name= ' || cust_id);
      EXIT WHEN  cust_pak.cust_inf%NOTFOUND;
   END LOOP;
  CLOSE cust_pak.cust_inf;
END;

/*Bài 2.  
Viết 1 Package thực hiện yêu cầu sau:
- 1 Thủ tục cho phép truyền vào: ID nhân viên. Trả về Họ, Tên, Mã phòng ban nhân viên đó.
- 1 Hàm cho phép truyền vào: ID nhân viên. Trả về Tên phòng ban của nhân viên đó.
Gọi Thủ tục và Hàm thông qua Package vừa tạo
*/

-- Khai báo Package Spec
Create Or Replace Package Pkg_Emp 
Is
 -- Procedure trả về thông tin của nhân viên
 Procedure Get_Emp_Infos(p_Emp_Id Number
                          ,v_First_Name Out Varchar2
                          ,v_Last_Name Out Varchar2
                          ,v_Dept_Id Out Number);-- hoặc khai báo theo kiểu %row(p_emp_rec IN Employee%ROWTYPE);
 
 -- Hàm trả về tên phòng ban của nhân viên.
 Function Get_Dept_Name(p_Emp_Id number) --hoặc khai báo theo kiểu %type(p_Emp_Id Employee.Emp_Id%Type)
    Return Department.Name%Type;
    --hoặc trả về theo kiểu %typeDepartment.Name%Type
End Pkg_Emp;

-- Khai báo Package Body
create or replace Package Body Pkg_Emp Is
 
 -- =====================================================
 -- Thủ tục trả về thông tin nhân viên
 -- Gồm 2 tham số đầu ra v_First_Name, v_Last_Name
 -- =====================================================
 Procedure Get_Emp_Infos(p_Emp_Id Number
                          ,v_First_Name Out Varchar2
                          ,v_Last_Name Out Varchar2
                          ,v_Dept_Id Out Number) 
                          -- Hoặc có thể khai báo theo kiểu % type:
                          --(p_Emp_Id  Employee.Emp_Id%Type
                       -- ,v_First_Name Out Employee.Emp_Id%Type
                       -- ,v_Last_Name  Out Employee.Last_Name%Type) 
As
 Begin
    Begin
       Select Emp.First_Name
             ,Emp.Last_Name
       Into   v_First_Name
             ,v_Last_Name
       From   Employee Emp
       Where  Emp.Emp_Id = p_Emp_Id;
    Exception
       -- Không tìm thấy nhân viên ứng với p_Emp_Id
       When No_Data_Found Then
          v_First_Name := Null;
          v_Last_Name  := Null;
    End;
 End;

 -- =====================================================
 -- Hàm trả về Dept_Name ứng với Emp_ID.
 -- (Trả về tên phòng ban của nhân viên)
 -- =====================================================
 Function Get_Dept_Name(p_Emp_Id Number) -- hoặc khai báo theo kiểu %type (p_Emp_Id Employee.Emp_Id%Type)
    Return VARCHAR2 --hoặc trả về theo kiểu %type: Department.Name%Type;
    As
    -- Khai báo một biến.
    v_Emp_Department_name Department.name%Type;
Begin
  Begin
     Select department.name
     Into   v_Emp_Department_name
     From   Employee 
     join department on department.dept_id = Employee.dept_id
     Where  Employee.Emp_Id = p_Emp_Id;
  Exception
     When No_Data_Found Then
        -- Gán null trong trường hợp không tìm thấy Employee
        -- ứng với p_Emp_ID
        v_Emp_Department_name := Null;
  End;
  --
  Return v_Emp_Department_name;
End;

End Pkg_Emp;

-- Chạy và kiểm tra kết quả 

SET serveroutput ON;  
DECLARE
v_emp_id number := 1;
v_First_Name VARCHAR2(50);
v_Last_Name VARCHAR2(50);
v_Dept_Id Number;
v_Emp_Department_name VARCHAR2(100);
BEGIN
dbms_output.put_line('Thông tin nhân viên bao gồm: ');
Pkg_Emp.Get_Emp_Infos(v_emp_id, v_First_Name,v_Last_Name,v_Dept_Id);
v_Emp_Department_name:= Pkg_Emp.Get_Dept_Name(v_emp_id);
dbms_output.put_line('ID:' || v_emp_id || '- First Name: ' || v_First_Name || '- Last Name: ' || v_Last_Name || '- Department: ' || v_Emp_Department_name);	
END;
/



----------- TRIGGER------------------------
/*Bài 1:
Tạo 1 Trigger cho phép backup lại tất cả những thay đổi của bảng EMPLOYEE (Insert dữ liệu thay đổi của các trường tường ứng bảng EMPLOYEE vào bảng EMPLOYEE_BACKUP, CHANGE_DATE = SYSDATE)
*/
CREATE OR REPLACE TRIGGER before_insert_inda_employee
BEFORE INSERT ON INDA_EMPLOYEE
    FOR EACH ROW
    BEGIN
        INSERT INTO INDA_EMPLOYEE_BACKUP(EMP_ID, END_DATE, FIRST_NAME,
            LAST_NAME, START_DATE, TITLE,
            ASSIGNED_BRANCH_ID, DEPT_ID,
            SUPERIOR_EMP_ID, SALARY, CHANGE_DATE)
        VALUES(:new.EMP_ID, :new.END_DATE, :new.FIRST_NAME,
            :new.LAST_NAME, :new.START_DATE, :new.TITLE,
            :new.ASSIGNED_BRANCH_ID, :new.DEPT_ID,
            :new.SUPERIOR_EMP_ID, :new.SALARY, SYSDATE);
END;

CREATE OR REPLACE TRIGGER before_update_inda_employee
BEFORE UPDATE ON INDA_EMPLOYEE
    FOR EACH ROW
    BEGIN
        INSERT INTO INDA_EMPLOYEE_BACKUP(EMP_ID, END_DATE, FIRST_NAME,
            LAST_NAME, START_DATE, TITLE,
            ASSIGNED_BRANCH_ID, DEPT_ID,
            SUPERIOR_EMP_ID, SALARY, CHANGE_DATE)
        VALUES(:new.EMP_ID, :new.END_DATE, :new.FIRST_NAME,
            :new.LAST_NAME, :new.START_DATE, :new.TITLE,
            :new.ASSIGNED_BRANCH_ID, :new.DEPT_ID,
            :new.SUPERIOR_EMP_ID, :new.SALARY, SYSDATE);
END;

CREATE OR REPLACE TRIGGER before_delete_inda_employee
BEFORE DELETE ON INDA_EMPLOYEE
    FOR EACH ROW
    BEGIN
        INSERT INTO INDA_EMPLOYEE_BACKUP(EMP_ID, END_DATE, FIRST_NAME,
            LAST_NAME, START_DATE, TITLE,
            ASSIGNED_BRANCH_ID, DEPT_ID,
            SUPERIOR_EMP_ID, SALARY, CHANGE_DATE)
        VALUES(:old.EMP_ID, :old.END_DATE, :old.FIRST_NAME,
            :old.LAST_NAME, :old.START_DATE, :old.TITLE,
            :old.ASSIGNED_BRANCH_ID, :old.DEPT_ID,
            :old.SUPERIOR_EMP_ID, :old.SALARY, SYSDATE);
END;
/*Bài 2: 
Tạo 1 Trigger cho phép update lại trạng thái của 2 trường: Updated_date = sysdate, Updated_by = User khi có thay đổi bảng ETL_CUSTOMER
*/
CREATE OR REPLACE TRIGGER before_insert_sondv_etl_customer
BEFORE INSERT OR UPDATE ON SONDV_ETL_CUSTOMER
    FOR EACH ROW
BEGIN
    :new.Updated_by := User;
    :new.Updated_date := sysdate;
END;

/*Bài 3:
Viết 1 Trigger cho phép tự động Bonus cho người quản lý 10% lương của nhân viên mới 
Gợi ý: Khi có nhân viên mới được thêm vào database. Insert thêm 1 bảng ghi mới vào bảng BONUS với (ID nhân viên quản lý, 10% lương tương ứng)
*/
Create Trigger Tang_Bonus AFTER INSERT ON emp
FOR EACH ROW
declare
v_sal EMP.SAL%TYPE;
Begin
if :new.SAL IS NOT NULL then
--trich 10% luong cua nguoi moi vao*/
--Note: In the trigger body, NEW and OLD must be preceded by a colon (":"), but in the WHEN clause, they do
--not have a preceding colon! 
v_sal:= :new.Sal*10/100;
--bonus cho nguoi quan ly = 10% luong nguoi moi vao*/
insert into BONUS (empno, sal) values (:new.MGR,v_sal) ;
End if;
End;




























select *from employees;