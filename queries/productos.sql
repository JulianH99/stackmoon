create or replace function guardar_producto(
  cod_producto varchar(10),
  cantidad_inventario int,
  precio int,
  ruta_imagen varchar(250),
  sn_iva bit,
  id_tipo_prod int,
  id_proveedor int
) returns boolean as
$$
declare
  uid uuid;
  exts integer;
begin

  uid := uuid_generate_v4();

  insert into productos(
    uid_producto,
    cod_producto,
    cantidad_inventario,
    precio,
    ruta_imagen,
    sn_iva,
    id_tipo_prod,
    id_proveedor,
    activo
  ) values (
    uid,
    cod_producto,
    cantidad_inventario,
    precio,
    ruta_imagen,
    sn_iva,
    id_tipo_prod,
    id_proveedor,
    default
  );


  get diagnostics exts = row_count;

  return exts > 0;

end;
$$
language 'plpgsql';


create or replace function editar_producto(
  _id_producto int,
  _cod_producto varchar(10),
  _cantidad_inventario int,
  _precio int,
  _ruta_imagen varchar(250),
  _sn_iva bit,
  _id_tipo_prod int,
  _id_proveedor int
) returns boolean as $$
declare updated int;
begin

  update productos set
    cod_producto = _cod_producto,
    cantidad_inventario = _cantidad_inventario,
    precio = _precio,
    ruta_imagen = _ruta_imagen,
    sn_iva = _sn_iva,
    id_tipo_prod = _id_tipo_prod,
    id_proveedor = _id_proveedor
  where id_producto = _id_producto;

  get diagnostics updated = row_count;

  return updated > 0;
end;
$$
language 'plpgsql';


-- eliminar producto

create or replace function eliminar_producto(uid uuid)
returns boolean as $$
declare deleted integer;
begin

  update productos set activo = false where uid_producto = uid;

  get diagnostics deleted = row_count ;

  return deleted == 1;

end; $$

