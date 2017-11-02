----------Disparadores tipo before

create table mayores (id integer primary key,
                      nombre varchar (60), edad integer);
                      
create or replace trigger disp_mayores before insert on mayores
for each row -----------Este for each es para garantizar que dispare en cada fila, si se ejecuta un cursor.
begin
if :new.edad<18  then 
raise_application_error(-20000, 'Edad incorrecta'); ----Es como una excepcion
end if;
end;
/

 insert into mayores values (1,'Juan carlos',20);
 select * from mayores;
 insert into mayores values (2,'Ana',16);
 
 
 -------------Ejercicio con update
 
 create table nomina (id integer primary key, suledo_base float,
                      horas_laboradas integer, deposito float);
                      
 insert into nomina values(1,2000.00,20,28000.00);
 insert into nomina values(2,1000.00,16,50000.00);
 
 select * from nomina;
 
 create or replace trigger disp_nomina before update on nomina
 for each row
 begin
 ----inciamos logica del disparador
 :new.deposito := :old.deposito+:new.horas_laboradas * :old.sueldo_base;
 end;
 /
 ---solucion al otro ejercicio
 update nomina set horas_laboradas=30 where id=1; 
 select * from nomina;
 