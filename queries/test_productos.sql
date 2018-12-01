-- test tipo de producto

select guardar_tipo_producto(_nombre := 'normal');

-- test de iva

select guardar_iva(valor := 0);

-- test de productos

-- agregar productos

select guardar_producto(
         _cod_producto := '110'::varchar(10),
         _cantidad_inventario := 10,
         _precio := 1000,
         _ruta_imagen := ''::varchar(255),
         _sn_iva := 0,
         _id_iva := 1,
         _id_tipo_prod := 1,
         _id_proveedor := 1
           );