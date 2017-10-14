---Cursores PL-SQL: Un cursor es una sentencia select, la cual podemos
---detenerla en cada registro para operar ierta logica deseada

-------creamos tabla----------
create table usuario_x(id integer primary key,
                        nombre varchar2(40),
                        edad integer);
                        
----LLenamos la tabla ------------

insert into usuario_x values (1,'Juan',40);
insert into usuario_x values (2,'Ana',32);
insert into usuario_x values (3,'Pedro',27);
insert into usuario_x values (4,'Maria',30);

select * from usuario_x;
------Esto sirve para depurar--------
set serveroutput on;


--------declaracion de cursor-----Ejercicio 1-------------
-----Generar un cursor en la tabla usuario que al ver cada registro 
-----imprima capo nombre de cada registro
  declare 
    cursor cur_1 is  select * from usuario_x;
  
  begin --<---- Aquien viene la logica del cursor
    for fila in cur_1 loop

      dbms_output.put_line ('El nombre actual es '|| fila.nombre);
    end loop;
  end;
  /
  
  -----------------------------------Ejercciio 2--------------------------------
  ----Generar un cursor qque contenga una variable interna y que realice la
  ----siguiente operacion si la edad estrictamente mayor a 30, asignar 
  ----sueldo_base un factor de 1.5 y si es menor, no asignar el factor 
  ----donde sueldo_base=6000 pesos
      
  declare 
  cursor cur_2 is select * from usuario_x;
  sueldo_base integer;
  begin    
  ---Inicializamos suelo base
  for fila in cur_2 loop
    sueldo_base:=6000;
    if fila.edad>30 then
      sueldo_base:=sueldo_base*1.5;
    end if;
    dbms_output.put_line ('El sueldo es: '||sueldo_base || ' Edad: ' || fila.edad);
  end loop;
  end;
/


                        