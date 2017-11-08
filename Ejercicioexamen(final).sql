
------------Ejercicios 

---Crear un bloque pl-sql que llene la tabla anterior con un tototal de 3 registros con el siguiente formato (Este se hace en la prueba de sp)
---b)el id se debera incrementar de 1 en 1 hasta 300
---c)el iva.retencion del iva, isr y total a pagar no debn insertarse 
---d)solo debera insertarse el subtotal y este debe incrementarse de 100 en 100 empezando desde 1500
---e)Crear un procedimeinto almacenado para hacer la actualizacion con los datos del subtotal para todos los registros como sigue:
----iva=subtotl*0.16---ret_va=iva/3*2-----isr=subtotal*0.10-----total_pagar=subtotal+ret_iva-iva-isr
-----Secuencia de 1 en 1
-----Realizar el diagrama de una arquitectura de un sistema de base de datos distribuido, muestra cada una de las componentes
---del mismo y describe una breve cada unsa de ellas
---Explica cual es la tarea de la capa cntroladora, vista y modelo
---Explica cual es el objetivo principal del mapeo objetos_relacional, dentro de una arquitectura de base de datos distribuida 
-----------Soluciones----------------
--a)Crear tabla
create table pago_honorarios(id integer primary key, subtotal float, iva float,
                              isr float,ret_venta float,total_pagar float);
--select * from pago_honorarios;

------------- b): Secuencia hasta 300----
create sequence sec_pagohono
start with 1
increment by 1
maxvalue 300 ; -----Aqui se declara hasta donde llega; sino se necesita limite es nomaxvalue

--------d) Secuencia que incrementa el subtotal de 100 en 100 empezando por 1500
create sequence sec_pagohono_subtotal
start with 1500
increment by 100
nomaxvalue ;


------------Este pertenece al inciso b y creo tambien va el e Procedimeinto que va almancenando en la tabla 
create or replace procedure guardar_honorario (my_id out integer,my_subtotal out float, my_iva out float,
                              my_isr out float ,my_ret_venta out float ,my_total_pagar out float  )----Importante: si se calculan en el procedimiento van con out,
                                                                                                  -----si se reciben a la hora de hacer la prueba van con in
as 
begin
for i in 1..30 loop---------------------------Este loop generara los 30 regitros
select sec_pagohono.nextval into my_id from dual;----Esto llamara la secuencia del id de 1 en 1
select sec_pagohono_subtotal.nextval into my_subtotal from dual;---Esto llamara la secuencia de de 100 en 100
my_iva:=my_subtotal * 0.16; -----------------------------------Estos son los calculos                         
my_isr:=my_subtotal * 0.10;
my_ret_venta:=my_iva/ 3 * 2;
my_total_pagar:=my_subtotal + my_ret_venta - my_iva -my_isr;
insert into pago_honorarios values(my_id,my_subtotal, my_iva ,------Este insert hara el llenado de la tabla
                              my_isr ,my_ret_venta,my_total_pagar);
end loop;                              
end;
/

---------c) Trigger para solo dejar insetar el subtotal (Este ya no va, pero no esta demas estudiarlo por si viene)-------------
/*
create or replace trigger disp_PagoHonorarios before insert on pago_honorarios
for each row -----------Este for each es para garantizar que dispare en cada fila, si se ejecuta un cursor.
begin
if :new.iva >=0 and :new.isr>=0 and :new.ret_venta>=0 and :new.total_pagar>=0  then 
raise_application_error(-20000, 'Los datos ingresados son invalidos'); ----Es como una excepcion
end if;
end;
/
*/


-------------------------Hasta aqui se corre primero, despues se corre la prueba para comprobar--------------------

-------------Prueba de ejecucion del procedimiento (o sea tdo :) )
declare 
valor_id integer;
valor_subtotal float;---------------------------Importante: sino se declara la variable  y se pone en el insert da error
valor_iva float;
valor_isr float;
valor_ret_venta float;
valor_total_pagar float;

begin
guardar_honorario(valor_id,valor_subtotal,valor_iva,valor_isr,valor_ret_venta,valor_total_pagar);------------- para imprimir se utiliza: dbms_output.put_line('El P K generado es:  ' || valor);
--guardar_honorario(valor_id,valor_subtotal,2,3,4,5);*/-----Este marca error por que el trigger entra al querer insertar mas valores
end;
/
select * from pago_honorarios;


----------------Para borra todos los obejtos e inizializar todo----------------------------------------------------
/*create table pago_honorarios(id integer primary key, subtotal float, iva float,
                              isr float,ret_venta float,total_pagar float);*/
DROP table pago_honorarios;
drop trigger disp_PagoHonorarios;
drop sequence sec_pagohono;
drop  procedure guardar_honorario;
drop sequence sec_pagohono_subtotal;