--------------------Clase del sabado 07/10/2017------------------

CREATE TABLE almacen (numero_almacen integer, 
                    ubicacion_alamacen varchar (80),
                    constraint pk_na primary key (numero_almacen)
                    );
                    
-------------------Se genera SP para guarda una entidad o registro de tipo almacen---------

create or replace procedure guardar_almacen (mi_id in integer,
                            mi_ubicacion in varchar2)
                            as 
                            begin 
                            ---Aqui la logica del procedimiento
                  insert into almacen values (mi_id,mi_ubicacion);
                  end;
                  /
                  
                  
-----------------Vamos a probar que funciona nuestro procedimiento---------------

begin
guardar_almacen(1,'PLYMOUTH');
end;
/

select * from almacen;

----- Generamos la tabla vendedor-----

create table vendedor (numero_vendedor integer,
                        nombre_vendedor varchar2(60),
                       area_ventas varchar2 (60),
                       constraint pk_nv primary key (numero_vendedor)
                    );

describe almacen; 
describe vendedor;

-------------Generamos tabla cliente---
create table cliente (numero_cliente integer,
                        numero_almacen integer,
                       nombre_cliente varchar2 (60),
                       constraint pk_nc primary key (numero_cliente),
                       constraint fk1_na foreign key (numero_almacen)
                       references almacen(numero_almacen)
                    );
describe cliente;

--------------Generamos la tabla ventas------------

create table ventas (id_ventas integer,
                       numero_cliente integer,
                       numero_vendedor integer,
                       monto_venta float (126),
                       constraint pk_idv primary key (id_ventas),
                       constraint fk1_nc foreign key (numero_cliente)
                       references cliente(numero_cliente),
                       constraint fkl_nv foreign key (numero_vendedor)
                       references vendedor(numero_vendedor)
                    );
describe ventas;
-----------------Hasta aqui es el entregable numero 2------------