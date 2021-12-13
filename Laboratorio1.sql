-- CREO LOS PROCEDIMIENTOS PARA LA TABLA ARTICULOS

drop procedure if exists SP_insert_articulos;
delimiter //
create procedure SP_insert_articulos(in
	Pnombre varchar(40) ,
    Pdescripcion varchar(150),
    Ptipo enum('PRENDA','JUGUETE','ALIMENTO','SNACK','ACCESORIO','CORREAS','MEDICAMENTO'),
    PespecieRecomendada enum('CANINO','FELINO','AVE','PEZ','ROEDOR'),
    Pcosto double,
    Pprecio double,
    Pstock int,
    PstockMinimo int,
    PstockMaximo int,
    Pcomentarios varchar(255),
    Pactivo boolean
)
begin
insert into articulos (nombre , descripcion, tipo, especieRecomendada, costo, precio, stock, stockMinimo,
    stockMaximo, comentarios, activo)
    values(Pnombre,Pdescripcion,Ptipo,PespecieRecomendada,Pcosto ,Pprecio,Pstock,PstockMinimo,
    PstockMaximo,Pcomentarios,Pactivo);
end //
delimiter ; 

-- creo un articulo y pruebo el procedimiento
call SP_insert_articulos('Pepe','se durmio','PRENDA','CANINO',500,700,10,2,50,'es muy bueno',TRUE);
select * from articulos;

drop procedure if exists SP_delete_articulos;
delimiter //
create procedure SP_delete_articulos(in  Pid int)
begin
delete from articulos where id=Pid;
end ;
// delimiter ;

-- pruebo el procedimiento eliminando el articulo que ingrese antes
call SP_delete_articulos(10);
select * from articulos;

drop procedure if exists SP_update_articulos;
delimiter //
create procedure SP_update_articulos(Pid int,
    Pnombre varchar(40) ,
    Pdescripcion varchar(150),
    Ptipo enum('PRENDA','JUGUETE','ALIMENTO','SNACK','ACCESORIO','CORREAS','MEDICAMENTO'),
    PespecieRecomendada enum('CANINO','FELINO','AVE','PEZ','ROEDOR'),
    Pcosto double,
    Pprecio double,
    Pstock int,
    PstockMinimo int,
    PstockMaximo int,
    Pcomentarios varchar(255),
    Pactivo boolean)
begin
	update articulos set nombre=Pnombre, descripcion=Pdescripcion, tipo=Ptipo, especieRecomendada=PespecieRecomendada,
						 costo=Pcosto, precio=Pprecio, stock=Pstock, stockMinimo=PstockMinimo, stockMaximo=PstockMaximo,
                         comentarios=Pcomentarios, activo=Pactivo
                         where id=Pid;
end ;
// delimiter ;

-- vuelvo a introducir el articulo creandolo de nuevo
call SP_insert_articulos('Pepe','se durmio','PRENDA','CANINO',500,700,10,2,50,'es muy bueno',TRUE);
select * from articulos;

call SP_update_articulos(10,'Pepe','lo despertaron','JUGUETE','CANINO',500,700,10,2,50,'es muy bueno',TRUE);
select * from articulos;