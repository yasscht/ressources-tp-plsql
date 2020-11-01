------------1------------------------
set serveroutput on;
declare
v_nom varchar2(20):='&v_nom';
v_prenom varchar2(20) := '&v_prenom';



begin
dbms_output.put_line('le nom :' || v_nom || 'le prenom : ' || v_prenom);
end;

--------------2---------------------
set serveroutput on;
declare
v_nombre number;

begin
select count(*) into v_nombre from employees;
dbms_output.put_line('le nombre des employees est : ' || v_nombre);

end;

------------3-------------------
set serveroutput on;
declare
v_nombre number;



begin
select count(*) into v_nombre from employees where manager_id=1;
dbms_output.put_line('le nombre des employees est : ' || v_nombre);

end;

---------------4--------------
set serveroutput on;
declare
v_nombre number;
v_nombre_manager number;
proportion number;


begin
select count(*) into v_nombre from employees;
select count(*) into v_nombre_manager from employees where manager_id=1;
proportion:=(v_nombre_manager/v_nombre)*100;

dbms_output.put_line('la proportion des employees dont le manager ID = 1 est: ' || proportion || '%');

end;

-----------5-------------------

set serveroutput on;
declare
v_first_name employees.firstname%type;
v_last_name employees.lastname%type;
v_hire_date employees.hire_date%type;
v_id number:=&v_id;
begin
select FIRSTNAME,LASTNAME,HIRE_DATE into v_first_name,v_last_name,v_hire_date from employees where id=v_id;
dbms_output.put_line('les information de l employee dont l ID est '|| v_id || ' nom:'|| v_first_name || ' ,prenom:'|| v_last_name || ' , date:' || v_hire_date);


end;

-------------6-------------------
set serveroutput on;
declare
type information 
is
record
(
v_first_name employees.firstname%type,
v_last_name employees.lastname%type,
v_hire_date employees.hire_date%type

);
v_id number := &v_id;
info information;


begin
select FIRSTNAME,LASTNAME,HIRE_DATE into info.v_first_name,info.v_last_name,info.v_hire_date from employees where id=v_id;
dbms_output.put_line('les information de l employee dont l ID est '|| v_id || ' nom:'|| info.v_first_name || ' ,prenom:'|| info.v_last_name || ' , date:' || info.v_hire_date);


end;

-----------------7------------------
set serveroutput on;
declare
type produits
is
record
(
v_product_name products.product_name%type,
v_product_description products.description%type,
v_cost products.standard_cost%type,
v_list_price products.list_price%type,
v_categorie_id products.category_id%type

);
v_id number := &v_id;
product produits;


begin
select product_name,description,standard_cost,list_price,category_id into product.v_product_name,product.v_product_description,
product.v_cost,
product.v_list_price,product.v_categorie_id
from products where PRODUCT_ID=v_id;
dbms_output.put_line('les information de l employee dont l ID est '|| v_id || ' nom:'|| product.v_product_name || ' , description:'||
product.v_product_description || ' , standard cost:' || product.v_cost || ', liste price : '
|| product.v_list_price || ' categorie id : '|| product.v_categorie_id);


end;

----------------8---------------
set serveroutput on;
declare
type r_mgr
is
record(
v_manager_id employees.manager_id%type);
type r_emp
is 
record(
v_firstname employees.firstname%type,
v_lastname employees.lastname%type,
v_salary employees.salary%type,
v_date EMPLOYEES.HIRE_DATE%type);
v_id number := &v_id;
mng r_mgr;
emp r_emp;
begin
select firstname,lastname,salary,hire_date,manager_id into emp.v_firstname,emp.v_lastname,
emp.v_salary,emp.v_date,mng.v_manager_id from employees where id=v_id;
dbms_output.put_line('les information de l employee dont l ID est '|| v_id || ' nom:'|| emp.v_firstname || ' , last name:'||
emp.v_lastname || ' , salaire:' || emp.v_salary || ', date hire  : '|| emp.v_date || ' le manager id est : '||mng.v_manager_id);
end;

------------------9------------------
set serveroutput on;
declare
type ord
is
record
(
v_name orders.name%type,
v_statut orders.status%type,
v_salsman orders.salsman%type,
v_order_date orders.order_date%type
);
v_order ord;
type cust is table of CUSTOMER.CUSTOMER_ID%type ;
custm cust;
nb number;
begin
select count(*),customer.customer_id into nb,custm from customer;
select orders.name,orders.status,orders.salsman,orders.order_date 
into v_order.v_name,v_order.v_statut,v_order.v_salsman,v_order.v_order_date from orders,customer where orders.customer_id=custm and orders.customer_id= customer.customer_id;
for n in 1..nb loop
select orders.name,orders.status,orders.salsman,orders.order_date 
into v_order.v_name,v_order.v_statut,v_order.v_salsman,v_order.v_order_date from orders,customer where orders.customer_id=custm(n)
and orders.customer_id= customer.customer_id;
dbms_output.put_line(v_order.v_name || v_order.v_statut ||  v_order.v_salsman );
end loop;
end;