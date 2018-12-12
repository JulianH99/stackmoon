-- test tipo de producto

select guardar_tipo_producto(_nombre := 'normal');

-- test de iva

select guardar_iva(valor := 0);

-- test de productos

-- agregar productos

select guardar_producto(
         _cod_producto := '110'::varchar(10),
         _cantidad_inventario := 10::integer,
         _precio := 1000::integer,
         _ruta_imagen := ''::varchar(255),
         _id_iva := 1::integer,
         _id_tipo_prod := 1::integer,
         _id_proveedor := 1::integer
           );


select * from productos