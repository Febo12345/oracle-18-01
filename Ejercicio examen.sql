create table primera (id integer primary key, nombre varchar2(60), edad integer );

create table respaldo_menores (id integer primary key, nombre varchar2(60), edad integer );

create table respaldo_mayores(id integer primary key, nombre varchar2(60), edad integer );

----------Disparador
create or replace trigger disp_primera after insert on primera 
for each row
begin
if :new.edad<18 then
insert into respaldo_menores values(:new.id, :new.nombre, :new.edad);
else
insert into respaldo_mayores values (:new.id, :new.nombre, :new.edad);
end if;
end;
/

------Inserciones
insert into primera values (2,'Ana',17);
select * from primera
select * from respaldo_mayorer
select * from respaldo_menores


------------Ejercicios 
--a)Crear tabla
create table pago_honorarios(id integer primary key, subtotal float, iva float,
                              isr float,ret_venta float,total_pagar float);
select * from pago_honorarios;
---B)Crear un bloque pl-sql que llene la tabla anterior con un tototal de 3 registros con el siguiente formato
---el id se debera incrementar de 1 en 1 hasta 300
---el iva.retencion del iva, isr y total a pagar no debn insertarse 
---solo debera insertarse el subtotal y este debe incrementarse de 100 en 100 empezando desde 1500
---Crear un procedimeinto almacenado para hacer la actualizacion con los datos del subtotal para todos los registros como sigue:
----iva=subtotl*0.16---ret_va=iva/3*2-----isr=subtotal*0.10-----total_pagar=subtotal+ret_iva-iva-isr
-----Secuencia de 1 en 1
-----Realizar el diagrama de una arquitectura de un sistema de base de datos distribuido, muestra cada una de las componentes
---del mismo y describe una breve cada unsa de ellas
---Explica cual es la tarea de la capa cntroladora, vista y modelo
---Explica cual es el objetivo principal del mapeo objetos_relacional, dentro de una arquitectura de base de datos distribuida 

create sequence sec_pagohono
start with 1
increment by 1
nomaxvalue; 

create or replace procedure guardar_honorario (my_id out integer,my_subtotal in float, my_iva float,
                              my_isr in float ,my_ret_venta float ,my_total_pagar in float  )
as 
begin
select sec_pagohono.nextval into my_id from dual;
insert into pago_honorarios values(my_id,my_subtotal, my_iva ,
                              my_isr ,my_ret_venta,my_total_pagar);
end;
/

begin
guardar_honorario(,1,2,3,4,5);
end;
/
----trigger 