autocommit off;
select product.product_code, quantity, expiry_date
  from joe.dated_inventory_c d
 where product.product_code = 4;
insert into joe.dated_inventory_c (product, quantity, expiry_date)
values ( (select product_c
            from joe.product_c
           where product_code = 4),
         10,
         NULL);
select product.product_code, quantity, expiry_date
  from joe.dated_inventory_c d
 where product.product_code = 4;
rollback work;
rollback;
