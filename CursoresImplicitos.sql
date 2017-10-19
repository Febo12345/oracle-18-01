


-------Creamos la soguiente tabla
create table cartera_clientes (id integer primary key, nombre varchar (40),
                                edad integer, sueldo_base float);
                                
                                
----Insertamos datos
insert into cartera_clientes values (1, 'Juan',25,60000);
insert into cartera_clientes values (2, 'Ana',45,40000);
insert into cartera_clientes values (3, 'Pedro',32,40000);
insert into cartera_clientes values (4, 'Irma',45,70000);
insert into cartera_clientes values (5, 'Luis',55,20000);

---Ejercicio1----------------------------------------
declare 
sueldo float;
pago_nomina float;
begin

----Declaramos cursor implicito
select sueldo_base into sueldo from cartera_clientes where id=3;
pago_nomina:=sueldo*20;
dbms_output.put_line('EL pago es ' || pago_nomina);
end;
/
---set serveroutput on;


----Ejercicio 2---------------------------------------------

-----Paso 1 Generar la tabla
create table nominas (id_nomina integer primary key, nombre varchar2 (20));

---Paso 2 Generar una secuencia
create sequence sec_nominas
start with 1
increment by 2
nomaxvalue; 

---Paso 3 Crear procedimiento de enlace de tabla y secuencia

create or replace procedure guardar_nomina(my_id out integer,
my_nombre in varchar2)
as
begin
select sec_nominas.nextval into my_id from dual;
insert into nominas values (my_id, my_nombre);
end;
/
 
 
 
 -----Finalmente vamos a probar el procedimiento con un bloque pl sql
 declare 
 valor integer;
 begin
 guardar_nomina (valor,'Juan');
 dbms_output.put_line('El P K generado es:  ' || valor);
 end;
 /

select * from nominas


