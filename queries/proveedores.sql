-- procedimientos de proveedor

-- crear proveedor

create or replace function guardar_proveedor(
  nombre    varchar(30),
  correo    varchar(30),
  telefono  varchar(15),
  telefono2 varchar(15),
  celular   varchar(15)
)
  returns boolean as $$
declare
  exts int;
  insert_count int;
begin

  insert into proveedores (
    nombre, correo, telefono, telefono2, celular, activo)
  values (nombre, correo, telefono, telefono2, celular, default);

  get diagnostics insert_count = row_count;

  return insert_count > 0;
end;
$$
language 'plpgsql';


-- editar proveedor
create or replace function editar_proveedor(
  _id_proveedor int,
  _nombre    varchar(30),
  _correo    varchar(30),
  _telefono  varchar(15),
  _telefono2 varchar(15),
  _celular   varchar(15)
)
  returns boolean as $$
begin

  update proveedores
  set nombre  = _nombre,
    correo    = _correo,
    telefono  = _telefono,
    telefono2 = _telefono2,
    celular   = _celular
  where id_proveedor = _id_proveedor;

end;
$$
language 'plpgsql';


-- eliminar proveedor
create or replace function eliminar_proveedor(
  _id_proveedor int
)
  returns boolean as $$
declare
  update_count int;
begin

  update proveedores
  set activo = false
  where id_proveedor = _id_proveedor;


  get diagnostics update_count = row_count;

  return update_count > 0;

end;
$$
  language 'plpgsql';

