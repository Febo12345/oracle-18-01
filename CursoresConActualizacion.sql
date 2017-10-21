----------Creamos la tabla

create table alumno (id_alumno integer primary key,
                      nombre varchar2(80), semestre integer);
                       
insert into alumno values (1,'Juan',1);
insert into alumno values (2,'Ana',1);                      
insert into alumno values (3,'Pedro',1);
insert into alumno values (4,'Maria',1);
insert into alumno values (5,'Luis',1);

select * from alumno;
1
----Creamos cursor

declare
cursor cur_alumno is select * from alumno for update of semestre;
begin
----Esta es una logica muy simple
for rec in cur_alumno loop----------------------------------------->Rec es record que es para cada fila pero como in que es por indice
update alumno set semestre=2 where current of cur_alumno;
end loop;
end;
/



---Ejercicio 2
create table materia (id_materia integer, id_alumno integer,
                      materia varchar2(80), calificacion float,
                      constraint pk_idm primary key (id_materia),
                      constraint fk_ida foreign key (id_alumno) 
                      references alumno(id_alumno)
                      );
select * from materia;
                      
------------Creamos secuencia de autoincremento
create sequence sec_materia
start with 1
increment by 1
nomaxvalue; 

-----Creamos for
--set serveroutput on;



  declare 
    cursor cur_1 is  select * from alumno;
  
  begin --<---- Aquien viene la logica del cursor
    for fila in cur_1 loop
      
      insert into materia values('',id_alumno,materia,calificaciones)
  
    end loop;
  end;
  /












---Paso 3 Crear procedimiento de enlace de tabla y secuencia

create or replace procedure guardar_materia(my_id_materia out integer,
my_id_alumno in integer, my_materia in varchar, my_calificacion in float)
as
begin
select sec_materia.nextval into my_id_materia  from dual;
insert into materia values (my_id_materia, my_id_alumno,,my_materia,my_calificacion);
end;
/


-----Procedimiento de almacenamiento
 declare 
 valor integer;
 begin
 guardar_materia (valor,1,'BD',7.7);
 dbms_output.put_line('El P K generado es:  ' || valor);
 end;
 /