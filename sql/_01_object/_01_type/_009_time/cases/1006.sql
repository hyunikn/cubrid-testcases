-- [er]create class with TIME and insert a error TIME


CREATE CLASS c_d (
  c1 TIME
);

INSERT INTO c_d VALUES (TIME '6:6:61 am');
DROP c_d;