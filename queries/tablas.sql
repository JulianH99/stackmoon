CREATE TABLE products(
    product_id serial,
    product_uid uuid,
    product_code varchar(10) not null unique,
    product varchar(30) unique,
    quantity bigint not null check (quantity >= 0),
    unit_price bigint not null check(unit_price > 0),
    primary key(id_product, uid, product_code)
 );

 create table supplier (
     supplier_id serial,
     supplier_uid uuid,
     supplier_name varchar(40) unique,
     phones varchar(10)[] null,
 )

 create table invoices (
     invoice_id serial,
     invoice_uid uuid,
     invoice_date date check(invoice_date > current_timestamp - interval '1 day'),
     invoice_type bit not null
     primary key(id_invoice, invoice_uid)
 );

 create table invoices_product(
     uid_invoice uuid,
     uid_product uuid,
     product_quantity bigint check(product_quantity > 0)
     foreign key uid_invoice references invoices(invoice_uid),
     foreign key uid_product references products(product_uid)
 );

 