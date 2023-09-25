use Assignment_01;

-- 1. Truy vấn first name, last name, job id và salary của các nhân viên có tên bắt đầu bằng chữ “S”.
  select first_name, last_name,job_id, salary from employees where first_name like 'S%';

-- 2. Viết truy vấn để tìm các nhân viên có số lương (salary) cao nhất.
select  employee_id,first_name,last_name,job_id,salary
from employees
where salary =  (select salary 
					from employees 
					group by salary
					order by salary desc
					limit 1 offset 0);

-- 3. Viết truy vấn để tìm các nhân viên có số lương lớn thứ hai.
with
 luong_thu_2 as (
 select salary 
  from employees 
  group by salary
  order by salary desc
  limit 1 offset 1)
select  employee_id,first_name,last_name,job_id,salary
from employees
where salary = (select salary from luong_thu_2);

-- 4. Viết truy vấn để tìm các nhân viên có số lương lớn thứ ba.
select  employee_id,first_name,last_name,job_id,salary
from employees
where salary =  (select salary 
					from employees 
					group by salary
					order by salary desc
					limit 1 offset 2);
  
-- 5. Viết truy vấn để hiển thị mức lương của nhân viên cùng với người quản lý tương ứng, tên nhân viên và quản lý kết hợp từ first_name và last_name.
select concat(emp.first_name,' ', emp.last_name) as 'Tên nhân viên',emp.salary,concat(man.first_name ,' ', man.last_name) as 'Tên quản lý',man.salary 
from employees as emp , employees as man
where man.employee_id = emp.manager_id;


-- 6. Viết truy vấn để tìm số lượng nhân viên cần quản lý của mỗi người quản lý, tên quản lý kết hợp từ first_name và last_name.
select emp.employee_id,concat(emp.first_name,' ', emp.last_name) as 'Tên quản lý', count(emp.employee_id) as 'Số lượng nhân viên'
from employees as emp , employees as man
where emp.employee_id = man.manager_id
group by emp.employee_id 
order by count(emp.employee_id) desc;


-- 7. Viết truy vấn để tìm được số lượng nhân viên trong mỗi phòng ban sắp xếp theo thứ tự số nhân viên giảm dần.
select department_name,count(*)
from departments dep,employees emp
where dep.department_id = emp.department_id
group by dep.department_id
order by count(emp.employee_id) desc;

-- 8. Viết truy vấn để tìm số lượng nhân viên được thuê trong mỗi năm sắp xếp theo thứ tự số lương nhân viên giảm dần.
select date_format(hire_date,'%Y') as 'Năm',count(*) as 'Số lượng nhân viên'
from employees
group by  date_format(hire_date,'%Y')
order by count(employee_id) desc ;


-- 9. Viết truy vấn để lấy mức lượng lớn nhất, nhỏ nhất và mức lương trung bình của các nhân viên (làm tròn mức lương trung bình về số nguyên).
select min(salary) as 'Mức lương thấp nhất', max(salary) as 'Mức lương cao nhất' ,round(avg(salary),0) as 'Mức lương trung bình'
from employees;


-- 10. Viết truy vấn để chia nhân viên thành ba nhóm dựa vào mức lương, tên nhân viên được kết hợp từ first_name và last_name, kết quả sắp xếp theo tên thứ tự tăng dần.
select concat(first_name,' ', last_name) as 'Tên nhân viên',salary,
Case
when salary >= 2000 and salary < 5000  then 'Low'
when salary >= 5000 and salary < 10000 then 'Mid'
else 'Hight'
end
from employees
order by first_name;

-- 11. Viết truy vấn hiển thị họ tên nhân viên và số điện thoai theo định dạng (_ _ _)-(_ _ _)-(_ _ _ _). Tên nhân viên kết hợp từ first_name và last_name.
select concat(first_name,' ', last_name) as 'Tên nhân viên',replace(phone_number,'.','-') as 'Số điện thoại'
from employees;

-- 12. Viết truy vấn để tìm các nhân viên gia nhập vào tháng 08-1994, tên nhân viên kết hợp từ first_name và last_name.
select concat(first_name,' ', last_name) as 'Tên nhân viên',hire_date
from employees
where hire_date  like '1994-08%';

-- 13. Viết truy vấn để tìm những nhân viên có mức lương cao hơn mức lương trung bình của các nhân viên, kết quả sắp xếp theo thứ tự tăng dần của department_id
select concat(emp.first_name,' ', emp.last_name) as 'Tên nhân viên',emp.employee_id, dep.department_name as 'DepartmentName', dep.department_id,emp.salary
from departments dep
join employees emp
on emp.department_id = dep.department_id
group by emp.employee_id
having emp.salary > (select avg(salary) from employees)
order by dep.department_id asc;


-- 14. Viết truy vấn để tìm mức lương lớn nhất ở mỗi phòng ban, kết quả sắp xếp theo thứ tự tăng dần của department_id.
 select dep.department_id,dep.department_name,max(emp.salary)
 from departments dep
 join employees emp
 on dep.department_id = emp.department_id
 group by dep.department_id 
 order by dep.department_id asc;

--   15. Viết truy vấn để tìm 5 nhân viên có mức lương thấp nhấtv
 select first_name,last_name,employee_id,salary
 from employees
 order by salary asc limit 5;


-- 16. Viết truy vấn để hiển thị tên nhân viên theo thứ tự ngược lại.
select first_name , reverse(first_name)
from employees;

-- 17. Viết truy vấn để tìm những nhân viên đã gia nhập vào sau ngày 15 của tháng.
select employee_id,concat(first_name,' ', last_name) as 'Tên nhân viên',hire_date
from employees
where date_format(hire_date,'%d') > 15;

-- 18. Viết truy vấn để tìm những quản lý và nhân viên làm trong các phòng ban khác nhau, 
 -- kết quả sắp xếp theo thứ tự tăng dần của tên người quản lý (tên nhân viên và quản lý kết hợp từ first_name và last_name).
select a.manager, employee,  a.mgr_dept , emp_dept
from (select concat(first_name,' ',last_name) as manager, department_id as mgr_dept
		from  employees 
		where employee_id in (select distinct manager_id from employees where manager_id is not null)) as a
join (select concat(first_name,' ',last_name) as employee, department_id as emp_dept
		from  employees 
		where employee_id not in (select distinct manager_id from employees where manager_id is not null)) as b
on a.mgr_dept <> b.emp_dept


















