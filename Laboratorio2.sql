use negocioweb;

-- TP 2
-- creo la tabla control
drop table if exists control_tablas;
create table control_tablas(
	id int auto_increment primary key,
    tabla varchar(30) not null,
    accion enum('insert','delete','update') not null,
    fecha date not null,
    hora time not null,
    usuario varchar(20),
    terminal varchar(100),
    idRegistro int not null
);

-- creo el disparador insert
drop trigger if exists TR_articulos_insert;
delimiter //
create trigger TR_articulos_insert
	after insert
    on articulos for each row
    begin
		insert into control_tablas(tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulos','insert',current_date(),current_time(),current_user(), 
			(select user()),new.id);
    end;
// delimiter ;
-- pruebo el disparador
call SP_insert_articulos(15,'Pepe','se durmio','PRENDA','CANINO',500,700,10,2,50,'es muy bueno',TRUE);
select * from control_tablas;

-- creo el disparador update
drop trigger if exists TR_articulos_delete;

delimiter //
create trigger TR_articulos_delete
	after delete
    on articulos for each row
    begin
		insert into control_tablas(tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulos','delete',current_date(),current_time(),current_user(), 
			(select user()),old.id);
    end;
// delimiter ;
-- pruebo el disparador

call SP_delete_articulos(15);
select * from control_tablas;

-- creo el disparador update
drop trigger if exists TR_articulos_update;

delimiter //
	create trigger TR_articulos_update
    after update on articulos for each row
    begin
		insert into control_tablas(tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulos','update',current_date(),current_time(),current_user(), 
			(select user()),old.id);
    end;
// delimiter ;

-- pruebo el disparador
call SP_insert_articulos('Pepe','se durmio','PRENDA','CANINO',500,700,10,2,50,'es muy bueno',TRUE);
call SP_update_articulos('llenar el id correspondiente','Pepe','lo despertaron','JUGUETE','CANINO',500,700,10,2,50,'es muy muy bueno',TRUE);
select * from control_tablas;