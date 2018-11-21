-- create database stackmoon;



create type tipoFactura as enum ('entrada', 'salida');
create type tipoPedido as enum('cliente', 'proveedor');


create table productos(
    cod_producto varchar(10) check(cod_producto != ''),
    cantidad_inventario int not null check(cantidad_inventario >= 0),
    precio int not null check(precio > 0),
    ruta_imagen varchar(250) null,
    sn_iva bit not null,
    id_iva int not null,
    id_tipo_prod int not null,
    id_proveedor int not null,
    primary key(cod_producto)
);

create table facturas (
    id_factura serial unique,
    fecha_factura date not null default CURRENT_TIMESTAMP,
    tipo_factura tipoFactura not null, -- 0 para factura de salida (compra) y 1 para factura de entrada (venta)
    primary key(id_factura)
);

create table det_facturas_productos(
    id_factura int not null check (id_factura > 0),
    cod_producto varchar(10) not null check(length(cod_producto) > 0),
    cantidad_producto int not null check(cantidad_producto > 0)
);

/* estaba pensando que esta tabla podria se removida, ya que los productos
 ya estan asociados al proveedor */
create table det_facturas_proveedores(
    id_factura int not null check(id_factura > 0),
    id_proveedor int not null check(id_proveedor > 0)
);

create table proveedores(
    id_proveedor serial unique,
    nombre varchar(30) unique check(nombre != ''),
    correo varchar(30) unique check(correo != ''),
    telefono varchar(10) unique check(length(telefono) >= 6),
    telefono2 varchar(15) null,
    celular varchar(10) unique check(length(celular) >= 10),
    primary key(id_proveedor)
);

create table ivas(
    id_iva serial unique,
    valor int not null check(valor >= 0),
    primary key(id_iva)
);

create table tipos_producto(
    id_tipo_producto serial unique,
    nombre varchar(30) not null check(length(nombre) > 0),
    primary key(id_tipo_producto)
);

create table fechas_especiales(
    id_fecha_especial serial unique,
    nombre varchar(50),
    fecha date not null,
    nota text null,
    primary key(id_fecha_especial)
);

create table pedidos(
    id_pedido serial unique,
    fecha_creacion date default current_timestamp,
    fecha_entrega date not null,
    tipo_pedido tipoPedido not null,
    primary key(id_pedido)
);

create table det_pedidos_productos(
    id_pedido int not null,
    cod_producto varchar(10) not null,
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
    add foreign key(cod_producto) references productos(cod_producto),
    add foreign key(id_factura) references facturas(id_factura);

alter table det_facturas_proveedores
    add foreign key(id_factura) references facturas(id_factura),
    add foreign key(id_proveedor) references proveedores(id_proveedor);

alter table det_pedidos_productos
    add foreign key(id_pedido) references pedidos(id_pedido),
    add foreign key(cod_producto) references productos(cod_producto);

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
    add column activo boolean not null default true;