-- Viết chương trình PL/SQL cho phép truyền vào 1 tham số: Id 
--nhân viên. Lấy ra first_name, last_name của nhân viên đó.

set SERVEROUTPUT on 
DECLARE 
vr_employee employee%Rowtype;
z_emp_id number:=&employee_id;
begin
select *
into vr_employee 
from employee
where emp_id = z_emp_id;
dbms_output.put_line (vr_employee.first_name || ' ' || vr_employee.last_name || 'has an id of ' || z_emp_id);
EXCEPTION 
when no_data_found then 
Raise_application_error (-2001, 'the employee is not in the data');
end;



--Viết chương trình PL/SQL để hiển thị thông tin chi tiết của tất 
--cả nhân viên bao gồm: emp_id, first_name, last_name.
set SERVEROUTPUT on 
DECLARE 
cursor z_emp_info IS
Select emp_id,
       first_name,
       last_name,
       salary
from employee;
r_emp_info z_emp_info%ROWTYPE;
begin
   open z_emp_info;
   loop
      fetch z_emp_info 
      into r_emp_info;
      exit
    when z_emp_info%notfound;
    dbms_output.put_line('Employee Information: '
                         || 'ID: '
                         ||r_emp_info.emp_id
                         ||'Name: '
                         ||r_emp_info.first_name
                         ||' '
                         ||r_emp_info.last_name);
    end loop;
    dbms_output.put_line('Total number of row: '
                         ||z_emp_info%rowcount);
    close z_emp_info;
end;




--Lấy ra thông tin: Tổng số tài khoản đã được mở bởi nhân viên 
--có ID = 10
--Điều kiện:
--“Tổng số tài khoản đã mở <= 1” thì Level là: “LOW”, 
--“Tổng số tài khoản đã mở > 2 và Tổng số tài khoản đã mở 
--<= 4” thì Level là: “Avg”, 
--Hình 38.1 Kết quả yêu cầu 1
--49
--“Tổng số tài khoản đã mở > 4 và Tổng số tài khoản đã mở 
--<= 6” thì Level là: “Moderate”, 
--Trường hợp còn lại Level là: “Hight”

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




--4.Lấy ra báo cáo bao gồm: Mã nhân viên, họ và tên nhân viên
--và ngày đầu tiên mà nhân viên đó đã mở tài khoản cho khách hàng 
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




--5. Lấy ra báo cáo bao gồm: Mã nhân viên, họ và tên nhân viên,
--ngày băt đầu vào làm và số tiền thưởng đạt được theo kinh nghiệm làm việc.
-- Điều kiện nhận thưởng: 
--+ Nếu thời gian làm việc > 13: Tiền thưởng = 8000 
--+ Nếu thời gian làm việc > 11: Tiền thưởng = 5000 
--+ Nếu thời gian làm việc > 9: Tiền thưởng = 3000 
--+ Nếu thời gian làm việc > 7: Tiền thưởng = 2000 
--+ Nếu thời gian làm việc > 4: Tiền thưởng = 1000 


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


--
--6.Viết procedure cho phép truyền vào ID của nhân viên và trả
--về First_Name, Last_Name, Dept_ID của nhân viên đó. 

create or replace Procedure HUYPV_Get_Employee_Infos
(p_Emp_Id     Number
,v_First_Name Out Varchar2
,v_Last_Name  Out Varchar2
,v_Dept_Id    Out Number)
Is
Begin
  Select Emp.First_Name
        ,Emp.Last_Name
        ,Emp.Dept_Id
  Into   v_First_Name
        ,v_Last_Name
        ,v_Dept_Id
  From   Employee Emp
  Where  Emp.Emp_Id = p_Emp_Id;
  Dbms_Output.Put_Line('Found Record!');
  Dbms_Output.Put_Line(' v_First_Name= ' || v_First_Name);
  Dbms_Output.Put_Line(' v_Last_Name= ' || v_Last_Name);
  Dbms_Output.Put_Line(' v_Dept_Id= ' || v_Dept_Id);
Exception
  When No_Data_Found Then
     Dbms_Output.Put_Line('No Record found with p_Emp_Id = ' || p_Emp_Id);
End HUYPV_Get_Employee_Infos;


SET serveroutput ON;  
DECLARE
v_emp_id number := 1;
v_First_Name VARCHAR2(50);
v_Last_Name VARCHAR2(50);
v_Dept_Id Number;
BEGIN
dbms_output.put_line('Thông tin nhân viên bao gồm: ');
HUYPV_Get_Employee_Infos(v_emp_id, v_First_Name,v_Last_Name,v_Dept_Id);
dbms_output.put_line('ID:' || v_emp_id || '- First Name: ' || v_First_Name || '- Last Name: ' || v_Last_Name);	
END;


--7.Lấy ra thông tin gồm Tên Khách hàng,AVAIL BALANCE Nếu:
-- “AVAIL_BALANCE <= 4000” thì SEGMENT là: “LOW”,
--“AVAIL_BALANCE > 4000 và AVAIL_BALANCE <= 7000” thì
--SEGMENT là: “MEDIUM”, “AVAIL_BALANCE >7000” thì SEGMENT là: “HIGH” 

SET SERVEROUTPUT ON
DECLARE 
CURSOR KH_Loai_So_Du 
IS
    Select 
    ind.first_name,
    ind.last_name,
    Sum(acc.avail_balance) as avail_balance,
    (case when Sum(acc.avail_balance)>7000 then 'High'
          when  Sum(acc.avail_balance)> 4000 AND Sum(acc.avail_balance) <= 7000 then 'Medium'
          else 'Low'
    end) as segment
    from customer cus
    join individual ind 
    on cus.cust_id = ind.cust_id
    join account acc
    on cus.cust_id = acc.cust_id
    GROUP by ind.first_name,ind.last_name;
begin
  for v_KH_Loai_So_Du in KH_Loai_So_Du
    loop
            dbms_output.put_line(v_KH_Loai_So_Du.first_name ||
                                 ' ' ||v_KH_Loai_So_Du.last_name ||
                                 '-' ||v_KH_Loai_So_Du.avail_balance ||
                                  '-' ||v_KH_Loai_So_Du.segment );

    end loop;
end;




--8.Viết 1 Package thực hiện yêu cầu sau:
---  1 Con trỏ trả về chi tiết tài khoản theo ID khách hàng truyền vào
--bao gồm các thông tin sau: Mã khách hàng, Địa chỉ khách hàng, ID tài khoản, Số dư, Trạng thái
---  1 Hàm cho phép truyền vào: ID khách hàng. Trả về Tổng số dư theo khách hàng
---  1 Hàm cho phép truyền vào: ID nhân viên mở + Năm mở tài khoản. Trả về Tổng số dư theo nhân viên mở tài khoản 


create or replace package HUYPV_cust_pak is

    cursor cust_inf (v_cusid customer.cust_id%type)is
        select a.cust_id,c.address,a.account_id,sum(a.avail_balance) tot_bal,a.status
        from account a, customer c
        where a.cust_id = c.cust_id
        and a.cust_id = v_cusid
        group by a.cust_id,c.address,a.account_id,a.status;
    function HUYPV_cust_bal(v_cusid customer.cust_id%type) return float;
    function HUYPV_ybal_by_emp (v_emp employee.emp_id%type, v_year int) return float;

end HUYPV_cust_pak;

create or replace package body HUYPV_cust_pak is  
    function HUYPV_cust_bal(v_cusid customer.cust_id%type) return float
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
    end HUYPV_cust_bal;  
    function HUYPV_ybal_by_emp (v_emp employee.emp_id%type, v_year int) return float
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
    end HUYPV_ybal_by_emp;
end HUYPV_cust_pak;

select HUYPV_cust_pak.cust_inf(1) from dual;
select HUYPV_cust_pak.cust_bal(2) from dual;
select HUYPV_cust_pak.ybal_by_emp(10,2005) from dual;


set serveroutput on;
DECLARE
    cust_id number;
    address varchar2(100);
    account_id number;
    tot_bal number;
    status varchar2(100);
BEGIN
   OPEN HUYPV_cust_pak.cust_inf (10);
   LOOP
      FETCH HUYPV_cust_pak.cust_inf INTO cust_id,address,account_id,tot_bal,status; 
      Dbms_Output.Put_Line(' v_First_Name= ' || cust_id);
      EXIT WHEN  HUYPV_cust_pak.cust_inf%NOTFOUND;
   END LOOP;
  CLOSE HUYPV_cust_pak.cust_inf;
END;




--9. Chuyển đổi nhiệt độ theo thang độ F sang độ C và ngược lại. 
--(Truyền tham số bao gồm: Nhiệt độ, thang độ cần chuyển) 
--Công thức tính :
--T (° F) = T (° C) × 9/5 + 32
--T (° C) = T (° F) - 32 * 5/9


CREATE OR REPLACE FUNCTION HUYPV_Temp(
    p_temp NUMBER,
    p_scale VARCHAR2
) RETURN NUMBER
IS
    v_result NUMBER;
BEGIN
    IF p_scale = 'C' THEN
        -- Chuyển độ C sang độ F
        v_result := p_temp * 9/5 + 32;
    ELSIF p_scale = 'F' THEN
        -- Chuyển độ F sang độ C
        v_result := (p_temp - 32) * 5/9;
    ELSE      
        v_result := NULL;
    END IF;

    RETURN v_result;
END;


SET SERVEROUTPUT ON;
DECLARE
    v_temp NUMBER := 25; -- Độ nhiệt độ cần chuyển đổi
    v_scale VARCHAR2(1) := 'C'; -- Thang độ cần chuyển đổi ('C' hoặc 'F')
    v_result NUMBER;
BEGIN
    v_result := HUYPV_Temp(v_temp, v_scale);
    DBMS_OUTPUT.PUT_LINE(v_temp || '°' || v_scale || ' tương đương với ' || 
                         v_result || '°' || 
                         CASE v_scale 
                             WHEN 'C' THEN 'F'
                             WHEN 'F' THEN 'C'
                         END);
END;




--10.Viết Function cho phép truyền vào mã khách hàng, ngày bất kỳ.
--Kiểm tra xem tính từ ngày là tham số truyền vào đã bao nhiêu ngày 
--khách hàng chưa phát sinh giao dịch (TXN_date). Nếu >=50 ngày đưa ra cảnh báo.

CREATE OR REPLACE FUNCTION HUYPV_Check(
    acc_id in acc_transaction.account_id%type,
    c_date in DATE
) RETURN VARCHAR2
IS
    v_min_txn_date DATE;
    v_sub_date NUMBER;
    v_result VARCHAR2(1000);
BEGIN
    SELECT MAX(TXN_date)
    INTO v_min_txn_date
    FROM acc_transaction acc_tr
    JOIN account acc
    ON acc_tr.account_id = acc.account_id
    WHERE acc.cust_id = cust_id;
    v_sub_date := trunc(c_date) - trunc(v_min_txn_date);
    IF v_sub_date >=50
    THEN
      v_result := acc_id ||'Khách hàng đã không phát sinh giao dịch trên 50 ngày tính từ ngày'
                         || c_date;
    ELSE
       v_result := acc_id ||'Khách hàng đã  phát sinh giao dịch ' || to_char(v_sub_date)||
                          'tính từ ngày'|| c_date;
    END IF;
       RETURN v_result;
END;



SET SERVEROUTPUT ON;
DECLARE
v_result varchar(100);
begin
v_result := HUYPV_Check(100,sysdate);
DBMS_OUTPUT.PUT_LINE('Return : ' || v_result);
end;



-- 11. Viết 1 Function cho phép truyền vào mã phòng ban, 
-- đếm tổng số lượng nhân viên của phòng ban đó và kiểm tra
-- xem phòng ban đó có cần tuyển dụng thêm hay không . 


CREATE OR REPLACE FUNCTION HUUPV_Check_Dept(get_dept_id NUMBER)
RETURN VARCHAR2
IS
    v_tot_emp NUMBER;
    v_result VARCHAR2(100);   
BEGIN
    SELECT COUNT(*)
    INTO v_tot_emp
    FROM employee e
    JOIN department d
    ON e.dept_id = d.dept_id
    WHERE e.dept_id = get_dept_id;
    DBMS_OUTPUT.PUT_LINE('Nhân viên phòng ban  ' || get_dept_id ||
                         'có:'|| ' '|| to_char(v_tot_emp));
    IF v_tot_emp >=45 THEN
        v_result := 'Không cần tuyển dụng thêm nhân viên cho phòng ban' || get_dept_id;
    ELSE
        v_result := 'Cần tuyển dụng thêm ' ||to_char(45 - v_tot_emp) ||' nhân viên cho phòng ban' ||get_dept_id;
    END IF;
    RETURN v_result;
END;



SET SERVEROUTPUT ON;
DECLARE
v_result varchar(100);
begin
v_result := HUUPV_Check_Dept(4);
DBMS_OUTPUT.PUT_LINE('Return : ' || v_result);
end;


--12. Viết 1 Function cho phép truyền vào mã tài khoản (account_id) 
--và kiểm tra xem ngày mở tài khoản (open_date) đó có phải là ngày
--cuối tuần hay không (T7,CN). 

create or replace function HUYPV_Check_Day(acc_id in number)
return varchar2
is 
get_day varchar2(15);
new_day varchar2(400);
max_open_date date;
begin 
       select open_date
       into max_open_date
       from account
       where account_id = acc_id;
       get_day := rtrim(to_char(max_open_date, 'DAY'));
       if get_day in ('SATUDAY', 'SUNDAY') then
       new_day := 'Ngày được chọn  : ' || get_day ||'  là ngày cuối tuần';
       else 
       new_day := 'Ngày được chọn  : ' || get_day ||' không phải là ngày cuối tuần';
       end if;
return new_day;
end;
      
      
SET SERVEROUTPUT ON;
DECLARE
new_day varchar(100);
begin
new_day := HUYPV_Check_Day(80);
DBMS_OUTPUT.PUT_LINE('Return : ' || new_day);
end;


--13. Viết chương trình PL/SQL để hiển thị ra họ và 
--tên của những nhân viên đang có mức lương > mức lương 
--trung bình của phòng ban nhân viên đó đang làm việc 
SET SERVEROUTPUT ON;
DECLARE 
     CURSOR emp_cur
is 
     Select 
     dept_id,
     first_name,
     last_name,
     salary
     from employee e
     where salary > (Select avg(salary)
                       from employee
                       where e.dept_id = dept_id
                       )
    order by dept_id, last_name;
begin 
    for each_emp in emp_cur
    loop
    DBMS_OUTPUT.PUT_LINE(rpad(each_emp.last_name,10) ||
                         'draw more than the average salary of deparment'|| ' ' ||
                         each_emp.dept_id);
    end loop;
end;




--
--14. Viết chương trình PL/SQL để hiển thị thông tin chi tiết của 
--tất cả nhân viên bao gồm: emp_id,first_name,last_name, salary 
--(Kiểm tra nếu salary > 500 thì trả về salary hiện tại,
--nếu < 500 thì trả ra thông báo: salary is less then 500).
SET SERVEROUTPUT ON;
DECLARE 
  z_empid employee.emp_id%type;
  z_empname employee.first_name%type;
  z_salary employee.salary%type;
     CURSOR emp_cur
is 
     Select 
     emp_id,
     first_name,
     salary
     from employee;
begin 
    open emp_cur;
    loop
    fetch emp_cur
    into z_empid,
         z_empname,
         z_salary;
    exit
    when emp_cur%notfound;
    if(z_salary > 500) then
    DBMS_OUTPUT.PUT_LINE(z_empid || ' ' || z_empname || ' ' ||z_salary);
    else 
    DBMS_OUTPUT.PUT_LINE(z_empname || ' ' ||'salary is less then 500');
    end if;
    end loop;
    close emp_cur;
end;


select * from acc_transaction;
select * from account;
--
--
--15. Viết Procedure cho phép truyền mã khách hàng. Kiểm tra xem ứng 
--với mỗi tài khoản của khách hàng đó ngày thực hiện giao dịch 
--đầu tiên (funds_avail_date) có trùng với ngày mở 
--tài khoản (open_date) hay không? Nếu có thì in ra thông báo.

create or replace procedure HUYPV_Check_Cust(cust_id in number)
is 
  day_trant acc_transaction.funds_avail_date%type;
  cursor acc_cur 
  is
     Select a.account_id,
            a.open_date
     from account a
     where a.cust_id = cust_id;
  acc_container acc_cur%rowtype;
begin
     open acc_cur;
    loop
      fetch acc_cur
        into  acc_container;
      exit
      when  acc_cur%notfound;
      select acc_tran.funds_avail_date
      into day_trant
      from acc_transaction acc_tran
      where acc_tran.account_id = acc_container.account_id;
      if  trunc(day_trant) = trunc(acc_container.open_date)
      then 
      DBMS_OUTPUT.PUT_LINE(acc_container.account_id ||' khách hàng rút ngay sau khi mở');
      end if;
      end loop;
      close acc_cur;
end HUYPV_Check_Cust;

SET SERVEROUTPUT ON;
exec HUYPV_Check_Cust(1);