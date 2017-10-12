
----------Generams la tabla menores de edad---
create table menores_de_edad (id_menores integer,
                       nombre varchar (60),
                       edad integer,
                       constraint pk_me primary key(id_menores)
                    );
                    
----------Problema del 11/10/17---------
create or replace procedure generar_mil
as begin
---generamos los mil
for i in 1..1000 loop
insert into menores_de_edad values (i,'Alfredo Sánchez',20);
end loop;
end;
/

-------Vamos a ejecutar el rpocedimiento

begin 
generar_mil();
end;
/

select count(*) from menores_de_edad;

---------Solucion
create or replace procedure actualizar_edad(age in integer,id in integer)as
begin
if age<18 then
raise_application_error(-20001, 'No acepecto edades a 18');
else
update menores_de_edad set edad=age where id_menores=id;
end if;
end;
/

