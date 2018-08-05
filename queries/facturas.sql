-- procedimientos de factura

/*
crear factura
TODO crear trigger para actualizacion de inventarios y presupuestos
*/
create or replace function guardar_factura(
  fecha_factura date,
  tipo_factura  tipofactura,
  productos     integer [],
  cantidades    integer []
)
  returns boolean
as $$
declare   exts    integer;
  declare uid     uuid;
  declare fact_id integer;
begin
  uid := uuid_generate_v4();

  insert into facturas (uid_factura, tipo_factura, fecha_factura)
  values (uid, tipo_factura, fecha_factura)
      returning id_factura
        into fact_id;

  -- get affected rows and display
  get diagnostics exts = row_count;
  raise notice 'Affected rows where %', exts;

  for i in 1 .. array_upper(productos, 1) loop
    insert into det_facturas_productos (id_factura, id_producto, cantidad_producto)
    values (fact_id, productos [ i ], cantidades [ i ]);
  end loop;

  return exts > 0;

end;
$$
language 'plpgsql';


/*
Actualizar factura
TODO: Hacer el trigger para el cambio de presupuestos e inventario
*/
create or replace function editar_factura(
  id_factura integer,
  productos  integer [],
  cantidades integer []
)
  returns boolean
as $$
declare   delete_count integer;
  declare insert_count integer;
begin

  delete from det_facturas_productos where id_factura = id_factura;
  get diagnostics delete_count = row_count;
  raise notice 'deleted % products from invoice', delete_count;

  for i in 1 .. array_upper(productos, 1) loop
    insert into det_facturas_productos (id_factura, id_producto, cantidad_producto)
    values (id_factura, productos [ i ], cantidades [ i ]);
  end loop;

  get diagnostics insert_count = row_count;
  raise notice 'inserted % rows in details', insert_count;

  return insert_count > 0;


end;
$$
language 'plpgsql';
