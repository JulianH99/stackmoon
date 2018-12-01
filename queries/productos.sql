create or replace function guardar_producto(
  _cod_producto varchar(10),
  _cantidad_inventario int,
  _precio int,
  _ruta_imagen varchar(250),
  _sn_iva smallint,
  _id_iva int,
  _id_tipo_prod int,
  _id_proveedor int
) returns boolean as
$$
declare
  exts integer;
begin

  insert into productos(
    cod_producto,
    cantidad_inventario,
    precio,
    ruta_imagen,
    sn_iva,
    id_tipo_prod,
    id_proveedor,
    id_iva,
    activo
  ) values (
    _cod_producto,
    _cantidad_inventario,
    _precio,
    _ruta_imagen,
    _sn_iva,
    _id_tipo_prod,
    _id_proveedor,
    _id_iva,
    default
  );


  get diagnostics exts = row_count;

  return exts > 0;

end;
$$
language 'plpgsql';


create or replace function editar_producto(
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
    id_proveedor = _id_proveedor,
    actualizado = current_date
  where cod_producto = _cod_producto;

  get diagnostics updated = row_count;

  return updated > 0;
end;
$$
language 'plpgsql';


-- eliminar producto

create or replace function eliminar_producto(_cod_producto varchar(10))
returns boolean as $$
declare deleted integer;
begin

  update productos set activo = false where cod_producto = _cod_producto;

  get diagnostics deleted = row_count ;

  return deleted == 1;

end; $$
language 'plpgsql';




