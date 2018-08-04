-- procedimientos de factura

-- agregar factura


-- esta funcion es un testeo de arrays para saber como guardar los productos en una factura
drop function array_test(integer[], integer[], integer[]);

create or replace function array_test(
  prods integer[],
  provs integer[],
  cants integer[]
) returns table(
  prod int,
  prov int,
  cant int
) as $$
declare i integer := 0;
begin
  for i in 1 .. array_upper(prods, 1)
    loop
      prod := prods[i];
      prov := provs[i];
      cant := cants[i];

      return next;

    end loop;
end;
$$
  language 'plpgsql';



select * from array_test(ARRAY [1, 2, 3, 4], ARRAY [1,2,2, 1], ARRAY[1,1, 5, 1]);