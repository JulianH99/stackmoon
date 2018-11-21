/**
Procedimientos correspondientes a los tipos de producto
 */

/*
Guardar tipo de producto
*/
create or replace function guardar_producto(
  _nombre varchar(30)
)
  returns boolean
as $$
declare   uid  uuid;
  declare exts integer;
begin

  insert into tipos_producto (nombre) values (_nombre);
  get diagnostics exts = row_count;
  raise notice 'added % rows in tipos_producto', exts;

  return exts > 0;

end;
$$
language 'plpgsql';


/**
Editar tipo de producto
 */
create or replace function editar_producto(
  _id     integer,
  _nombre varchar(30)
)
  returns boolean
as $$
declare update_count integer;
begin

  update tipos_producto set nombre = _nombre where id_tipo_producto = _id;
  get diagnostics update_count = row_count;
  raise notice 'updated % rows in tipos_producto', update_count;

  return update_count > 0;

end;
$$
language 'plpgsql';

/**
Eliminar tipo producto
 */
create or replace function eliminar_producto(
  _id integer
)
  returns boolean
as $$
declare delete_count integer;
begin
  update tipos_producto set activo = false where id_tipo_producto = _id;
  get diagnostics delete_count = row_count;
  raise notice 'Deleted % rows from tipos_producto', delete_count;

  return delete_count == 1;
end;
$$
language 'plpgsql';
