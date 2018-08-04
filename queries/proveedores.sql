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
  uid  uuid;
  exts int;
begin
  uid := uuid_generate_v4();

  insert into proveedores (
    uid_proveedor, nombre, correo, telefono, telefono2, celular, activo)
  values (uid, nombre, correo, telefono, telefono2, celular, default);

  exts := (select count(*)
           from proveedores
           where uid_proveedor = uid);

  if exts > 0
  then
    return true;
  else
    return false;
  end if;
end;
$$
language 'plsql';


-- editar proveedor
create or replace function editar_proveedor(
  uid        uuid,
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
  where uid_proveedor = uid;

end;
$$
language 'plsql';


-- eliminar proveedor
create or replace function eliminar_proveedor(
  uid uuid
)
  returns boolean as $$
declare exts boolean;
begin

  update proveedores
  set activo = false
  where uid_proveedor = uid;

  exts := (select count(*)
           from proveedores
           where uid_proveedor = uid and activo = false);

  if exts > 0
  then
    return false;
  else
    return true;
  end if;

end;
$$

