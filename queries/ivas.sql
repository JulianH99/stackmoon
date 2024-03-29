/**
Procedimientos correspondientes a crear y editar ivas registrados
 */

/*
Agregar un iva
*/
create or replace function guardar_iva(
  valor int
)
  returns boolean
as $$
declare   exts integer;
begin


  insert into ivas (valor) values (valor);
  get diagnostics exts = row_count;
  raise notice 'added % rows in ivas', exts;

  return exts > 0;

end;
$$
language 'plpgsql';

/*
Editar el iva existente
*/
create or replace function editar_iva(
  _id_iva int,
  _valor  int
)
  returns boolean
as $$
declare update_count int;
begin

  update ivas set valor = _valor, actualizado = current_date where id_iva = _id_iva;
  get diagnostics update_count = row_count;

  raise notice 'updated % rows in ivas', update_count;

  return update_count > 0;

end;
$$
  language 'plpgsql';