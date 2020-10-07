use bdturnos;

-- Queries
                  
select * from especialidades;
select * from especialistas;
select * from pacientes;
select * from turnos;
select * from horas;

drop view if exists v_total;
create view v_total As
		 select t.fecha, h.nombre hora, p.id IdPaciente, p.tipoDocumento, p.numDocumento, p.nombre, p.apellido, p.fechanac, p.tlf_cel, p.email, p.prepaga, t.cancelado, e.id IdEspecialista, e.tipoDocumento tipoDocumentoEspecialista, e.numDocumento numDocumentoEspecialista, e.nombre nombreEspecialista, e.apellido apellidoEspecialista, e.tlf_cel tlf_especialista, e.titulo, ee.nombre nombreEspecialidad
         from  pacientes p join turnos t on  t.idPaciente = p.id
                           join especialistas e on t.idEspecialista = e.id
                           join especialidades ee on t.IdEspecialidad = ee.id
                           join horas h on t.idHora = h.id;
select * from v_total;

select nombre  from horas where nombre not in (select h.nombre from  pacientes p join turnos t on  t.idPaciente = p.id join especialistas e on t.idEspecialista = e.id join especialidades ee on t.idEspecialidad = ee.id join horas h on t.idHora = h.id where e.id=2 and t.fecha='2020-08-12');

-- 1. Pacientes que debe atender el doctor 'Roberto' 'Lara' este mes
select monthname(fecha) mes, dayname(fecha) dia, hora, nombre, apellido, tlf_cel from v_total 
                                     where year(fecha)=year(curdate()) 
                                       and month(curdate())=month(fecha) 
                                       and nombreEspecialista='Roberto' 
                                       and apellidoEspecialista ='Lara' 
                                       and cancelado = false
                                       order by mes, apellido, nombre desc;

-- 2. Pacientes que asisten a consulta los días jueves en la tarde
select distinct dayname(fecha) dia, hora, nombre, apellido, tlf_cel, nombreEspecialista, apellidoEspecialista, nombreEspecialidad 
       from v_total where dayname(fecha)='Thursday' 
		     AND hora in('12:00', '12:30','13:00', '13:30', '14:00', '14:30', '15:00','15:30', '16:00') 
                     order by dia; 

-- 3. Datos de los pacientes de odontología
select distinct nombre, apellido, tlf_cel, email 
	   from v_total where nombreEspecialidad = 'odontología';

-- 4. Datos de los especialistas en dermatología
select e.nombre, apellido, titulo, ee.nombre nombreEspecialidad, tlf_cel, email from especialistas e 
                            inner join especialidades ee on  e.IdEspecialidad = ee.id
                            where ee.nombre = 'dermatologia';

-- 5. Cantidad de turnos que hay para los viernes de este mes
select count(*) 'turnos para el viernes' from turnos 
                             where year(fecha)=year(curdate()) 
                                   and month(fecha)=month(curdate()) 
                                   and dayname(fecha)='friday' 
                                   and cancelado = false;

-- 6. Cantidad de turnos cancelados este mes
select count(*) 'turnos cancelados en este mes' from turnos 
                            where year(fecha)=year(curdate()) 
                                  and month(fecha)=month(curdate()) 
                                  and cancelado=true;

-- 7. Pacientes que cancelaron el mes de mayo por especialidad
select distinct nombre, apellido, tlf_cel, nombreEspecialidad from v_total 
                            where year(curdate())=year(fecha) 
                                  and month(fecha)=5 
                                  and cancelado=true 
                            order by nombreEspecialidad desc;

-- 8. Cantidad de turnos por día del mes en curso
select monthname(fecha) mes, dayname(fecha) "nombre del día", day(fecha) dia, count(*) "cantidad de turnos", nombreEspecialidad from v_total 
				where month(fecha)=month(curdate()) 
                                  and year(fecha)=year(curdate()) 
                                  and cancelado = false
			        group by monthname(fecha), dayname(fecha), day(fecha), nombreEspecialidad order by day(fecha);

-- 9. Cantidad de cancelaciones por paciente 
select idPaciente, tipoDocumento, numDocumento, nombre, apellido, count(*) cancelaciones, nombreEspecialidad from v_total 
                            where cancelado = true 
                            group by idPaciente, tipoDocumento, numDocumento, nombreEspecialidad;

-- 10. Pacientes que tiene el doctor 'Roberto' 'Lara' para hoy
select tipoDocumento, numDocumento, nombre, apellido, tlf_cel, hora, email from v_total 
				where nombreEspecialista = 'roberto' 
                                  and apellidoEspecialista = 'lara' 
                                  and fecha = curdate() 
                                  and cancelado=false;

-- 11 Disponibilidad que posee el doctor 'Roberto' 'Lara' para hoy
select nombre disponibilidad from horas where nombre not in 
				  (select hora from v_total 
                               where nombreEspecialista = 'roberto' 
				and apellidoEspecialista = 'lara' 
                                and fecha = curdate()
					);
                    
-- 12. Cantidad de pacientes por especialista
select tipoDocumentoEspecialista, numDocumentoEspecialista, nombreEspecialista, apellidoEspecialista, count(distinct IdPaciente) "cantidad de pacientes"
                                  from v_total where cancelado=false
                                               group by IdEspecialista
                                               order by IdEspecialista;

-- 13. Turnos que restan por atender este mes por especialidad:
select monthname(fecha) mes, dayname(fecha) "nombre del día", day(fecha) dia, count(*) "cantidad de turnos", nombreEspecialidad from v_total 
				where month(fecha)=month(curdate()) 
                                  and year(fecha)=year(curdate()) 
                                  and fecha>=curdate()
                                  and cancelado = false
			        group by monthname(fecha), dayname(fecha), day(fecha), nombreEspecialidad order by day(fecha);

-- 14. Cantidad de turnos programados por mes y especialidad durante la cuarentena:
 select monthname(fecha) mes, nombreEspecialidad, count(*) "cantidad de turnos programados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         group by  monthname(fecha), nombreEspecialidad;

-- 15. Cantidad de cancelaciones por mes y especialidad durante la cuarentena:
select monthname(fecha) mes, nombreEspecialidad, count(*) "cantidad de turnos cancelados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and cancelado=true                         
                         group by monthname(fecha), nombreEspecialidad;

-- 16. Porcentaje de cancelaciones durante la cuarentena:

select (round((select count(*) "cantidad de turnos cancelados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and cancelado=true)     
						 *100 
                         /
	   (select count(*) "cantidad de turnos programados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         ),2)
				            ) "porcentaje de cancelaciones durante la cuarentena";
                            
	-- 17. Porcentaje de cancelaciones durante la cuarentena por mes 

select       (round(
                (select count(*) "cantidad de turnos cancelados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and cancelado=true
                         and month(fecha)=3
                         )  *100 
                         /
	        (select count(*) "cantidad de turnos programados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and month(fecha)=3
                         )
               ,2)  ) "porcentaje de cancelaciones de marzo", 
                            
	     (round(
                (select count(*) "cantidad de turnos cancelados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and cancelado=true
                         and month(fecha)=4
                         )   *100 
                         /
                (select count(*) "cantidad de turnos programados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and month(fecha)=4
                ),2)  ) "porcentaje de cancelaciones de abril",
              
              (round(
                  (select count(*) "cantidad de turnos cancelados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and cancelado=true
                         and month(fecha)=5
                         )  *100 
                         /
	           (select count(*) "cantidad de turnos programados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and month(fecha)=5
                         ),2)
		) "porcentaje de cancelaciones de mayo",
                
               (round(
                    (select count(*) "cantidad de turnos cancelados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and cancelado=true
                         and month(fecha)=6
                         )  *100 
                         /
	              (select count(*) "cantidad de turnos programados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and month(fecha)=6
                         ),2)
		   ) "porcentaje de cancelaciones de junio", 
            (round(
                    (select count(*) "cantidad de turnos cancelados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and cancelado=true
                         and month(fecha)=7
                         )  *100 
                         /
	              (select count(*) "cantidad de turnos programados"  from v_total 
                         where fecha between '2020-03-20' and curdate()
                         and month(fecha)=7
                         ),2)
		   ) "porcentaje de cancelaciones de julio"  ;