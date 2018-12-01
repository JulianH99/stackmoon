# Tablas

[Atras](./)

[[toc]]

::: tip
Todas las tablas tienen una columna `activo` de tipo de dato `boolean`, no nula
:::

## Tablas principales

### Proveedores

| Columna      | Tipo de dato     | PK  | FK  | UK  | AI  | NULL |
| ------------ | ---------------- | --- | --- | --- | --- | ---- |
| id_proovedor | integer          | :x: |     |     | :x: |      |
| nombre       | varchar (**30**) |     |     | :x: |     |      |
| correo       | varchar(**30**)  |     |     | :x: |     |      |
| telefono     | varchar(**10**)  |     |     | :x: |     |      |
| telefono2    | varchar(**15**)  |     |     |     |     | :x:  |
| celular      | varchar(**10**)  |     |     | :x: |     |      |

### Facturas

| Columna       | Tipo de dato | PK  | FK  | UK  | AI  | NULL |
| ------------- | ------------ | --- | --- | --- | --- | ---- |
| id_factura    | integer      | :x: |     |     | :x: |      |
| fecha_factura | date         |     |     |     |     |      |
| tipo_factura  | tipofactura  |     |     |     |     |      |

### Fechas especiales

| Columna           | Tipo de dato    | PK  | FK  | UK  | AI  | NULL |
| ----------------- | --------------- | --- | --- | --- | --- | ---- |
| id_fecha_especial | integer         | :x: |     |     | :x: |      |
| nombre            | varchar(**50**) |     |     |     |     | :x:  |
| fecha             | date            |     |     |     |     |      |
| nota              | text            |     |     |     |     | :x:  |

### Ivas

| Columna | Tipo de dato | PK  | FK  | UK  | AI  | NULL |
| ------- | ------------ | --- | --- | --- | --- | ---- |
| id_iva  | integer      | :x: |     |     | :x: |      |
| valor   | integer      |     |     |     |     |      |

### Pedidos

| Columna        | Tipo de dato | PK  | FK  | UK  | AI  | NULL |
| -------------- | ------------ | --- | --- | --- | --- | ---- |
| id_pedido      | integer      | :x: |     |     | :x: |      |
| fecha_creacion | date         |     |     |     |     |      |
| fecha_entrega  | date         |     |     |     |     |      |
| tipo_pedido    | tipopedido   |

### Productos

| Columna             | Tipo de dato     | PK  | FK                     | UK  | AI  | NULL |
| ------------------- | ---------------- | --- | ---------------------- | --- | --- | ---- |
| cod_producto        | varchar(**10**)  | :x: |                        |     |     |      |
| cantidad_inventario | integer          |
| precio              | integer          |
| ruta_imagen         | varchar(**250**) |
| sn_iva              | bit              |
| id_iva              | integer          |     | [:x:](#ivas)           |
| id_tipo_producto    | integer          |     | [:x:](#tipos-producto) |
| id_proveedor        | integer          |     | [:x:](#proveedores)    |

### Tipos Producto

| Columna          | Tipo de dato    | PK  | FK  | UK  | AI  | NULL |
| ---------------- | --------------- | --- | --- | --- | --- | ---- |
| id_tipo_producto | integer         | :x: |     |     | :x: |
| nombre           | varchar(**30**) |

## Tablas de detalle

### det_facturas_proveedores

| Columna           | Tipo de dato    | PK  | FK                | UK  | AI  | NULL |
| ----------------- | --------------- | --- | ----------------- | --- | --- | ---- |
| id_factura        | integer         |     | [:x:](#facturas)  |
| cod_producto      | varchar(**10**) |     | [:x:](#productos) |
| cantidad_producto | integer         |

### det_facturas_productos

| Columna           | Tipo de dato    | PK  | FK                | UK  | AI  | NULL |
| ----------------- | --------------- | --- | ----------------- | --- | --- | ---- |
| id_factura        | integer         |     | [:x:](#facturas)  |
| cod_producto      | varchar(**10**) |     | [:x:](#productos) |
| cantidad_producto | integer         |     |

### det_pedidos_productos

| Columna      | Tipo de dato    | PK  | FK                | UK  | AI  | NULL |
| ------------ | --------------- | --- | ----------------- | --- | --- | ---- |
| id_pedido    | integer         |     | [:x:](#pedidos)   |
| cod_producto | varchar(**10**) |     | [:x:](#productos) |
| canditad     | integer         |

### det_pedidos_proveedores

| Columna      | Tipo de dato | PK  | FK                  | UK  | AI  | NULL |
| ------------ | ------------ | --- | ------------------- | --- | --- | ---- |
| id_pedido    | integer      |     | [:x:](#pedidos)     |
| id_proveedor | integer      |     | [:x:](#proveedores) |
