-- test de agregar proveedor

select guardar_proveedor(
         nombre := 'Alpina',
         correo := 'alpina@alpina.com',
         telefono := '123123123',
         telefono2 := '123123123',
         celular := '1234567890'
           );

select guardar_proveedor(
         nombre := 'Colanta',
         correo := 'colanta@colanta.com',
         telefono := '1454534',
         telefono2 := '23423423',
         celular := '4554545451'
           );

-- selecionar proveedores

select *
from proveedores
order by nombre asc;