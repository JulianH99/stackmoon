--create database stackmoon;

create type tipoFactura as enum ('entrada', 'salida');
create type tipoPedido as enum('cliente', 'proveedor');


create table productos(
    id_producto serial unique,
    uid_producto uuid unique,
    cod_producto varchar(10),
    cantidad_inventario int not null check(cantidad_inventario >= 0),
    precio int not null check(precio > 0),
    ruta_imagen varchar(250) null,
    sn_iva bit not null,
    id_iva int not null,
    id_tipo_prod int not null,
    id_proveedor int not null,
    primary key(id_producto, uid_producto, cod_producto)
);

create table facturas (
    id_factura serial unique,
    uid_factura uuid unique,
    fecha_factura date not null default CURRENT_TIMESTAMP,
    tipo_factura tipoFactura not null, -- 0 para factura de salida (compra) y 1 para factura de entrada (venta)
    primary key(id_factura, uid_factura)
);

create table det_facturas_productos(
    id_factura int not null,
    id_producto int not null,
    cantidad_producto int not null check(cantidad_producto > 0)
);

/* estaba pensando que esta tabla podria se removida, ya que los productos
 ya estan asociados al proveedor */
create table det_facturas_proveedores(
    id_factura int not null,
    id_proveedor int not null
);

create table proveedores(
    id_proveedor serial unique,
    uid_proveedor uuid unique,
    nombre varchar(30) unique,
    correo varchar(30) unique,
    telefono varchar(15) unique,
    telefono2 varchar(15) unique,
    celular varchar(15) unique,
    primary key(id_proveedor, uid_proveedor)
);

create table ivas(
    id_iva serial unique,
    uid_iva uuid unique,
    valor int not null,
    primary key(id_iva, uid_iva)
);

create table tipos_producto(
    id_tipo_producto serial unique,
    uid_tipo_producto uuid unique,
    nombre varchar(30),
    primary key(id_tipo_producto, uid_tipo_producto)
);

create table fechas_especiales(
    id_fecha_especial serial unique,
    uid_fecha_especial uuid unique,
    nombre varchar(50),
    fecha date not null,
    nota text null,
    primary key(id_fecha_especial, uid_fecha_especial)
);

create table pedidos(
    id_pedido serial unique,
    uid_pedido uuid unique,
    fecha_creacion date default current_timestamp,
    fecha_entrega date not null,
    tipo_pedido tipoPedido not null,
    primary key(id_pedido, uid_pedido)
);

create table det_pedidos_productos(
    id_pedido int not null,
    id_producto int not null,
    cantidad int not null check(cantidad > 0)
);

create table det_pedidos_proveedores(
    id_pedido int not null,
    id_proveedor int not null
);


alter table productos
    add foreign key (id_iva) references ivas(id_iva),
   add  foreign key(id_tipo_prod) references tipos_producto(id_tipo_producto),
    add foreign key(id_proveedor) references proveedores(id_proveedor);

alter table det_facturas_productos
    add foreign key(id_producto) references productos(id_producto),
    add foreign key(id_factura) references facturas(id_factura);

alter table det_facturas_proveedores
    add foreign key(id_factura) references facturas(id_factura),
    add foreign key(id_proveedor) references proveedores(id_proveedor);

alter table det_pedidos_productos
    add foreign key(id_pedido) references pedidos(id_pedido),
    add foreign key(id_producto) references productos(id_producto);

alter table det_pedidos_proveedores
    add foreign key(id_pedido) references pedidos(id_pedido),
    add foreign key(id_proveedor) references proveedores(id_proveedor);

-- agregar campos de activo/inactivo

alter table productos
    add column activo boolean not null default true;

alter table facturas
    add column activo boolean not null default true;

alter table proveedores
    add column activo boolean not null default true;

alter table tipos_producto
    add column activo boolean not null default true;

alter table fechas_especiales
    add column activo boolean not null default true;

alter table pedidos
    add column pedidos boolean not null default true;