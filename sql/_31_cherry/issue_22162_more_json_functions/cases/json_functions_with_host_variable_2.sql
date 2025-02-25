--+ holdcas on;
set @jdoc      = '{"name":"Lily", "age":12, "hobbies":["Reading","Watching movies","Play tennis"]}';
set @jobj      = '{"hobbies":["drawing"], "grade":5}';
set @jarr      = '["flower arrangement","swimming"]';
set @int1      = 1;
set @int2      = 2;
set @str1      = '1';
set @str_a     = 'a';
set @b1_true   = 'true';
set @b2_false  = 'false';
set @b3_TRUE   = 'TRUE';
set @b3_False  = 'False';
set @n1_null   = 'null';
set @n1_NULL   = NULL;
set @empty_str = '';
set @path_root = '$';
set @path_0    = '$[0]'; 
set @path_1    = '$[1]';

prepare st from 'select json_object(?,?);';
execute st using @jdoc      , @jobj      ;
execute st using @jobj      , @jarr      ;
execute st using @jarr      , @int1      ;
execute st using @str1      , @str_a     ;
execute st using @b1_true   , @b2_false  ;
execute st using @n1_null   , @n1_NULL   ;
execute st using @n1_NULL   , @empty_str ;
execute st using @path_1    , @jdoc      ;
deallocate prepare st;
prepare st from 'select json_object(?,?,?,?,?,?);';
execute st using @int1, @int2, @int2, @str1, @str1, @str_a;
execute st using @int1, @int2, @int2, @str1, @str_a, @b1_true;
execute st using @b2_false, @b3_TRUE, @b3_TRUE, @b3_False, @b3_False, @n1_null;
execute st using @empty_str, @path_root, @path_root, @path_0, @path_0, @path_1;
deallocate prepare st;

prepare st from 'select json_array(?,?);';
execute st using @jdoc      , @jobj      ;
execute st using @jobj      , @jarr      ;
execute st using @jarr      , @int1      ;
execute st using @str1      , @str_a     ;
execute st using @b1_true   , @b2_false  ;
execute st using @n1_null   , @n1_NULL   ;
execute st using @n1_NULL   , @empty_str ;
execute st using @path_1    , @jdoc      ;
deallocate prepare st;
prepare st from 'select json_array(?,?,?,?,?,?);';
execute st using @int1, @int2, @int2, @str1, @str1, @str_a;
execute st using @int1, @int2, @int2, @str1, @str_a, @b1_true;
execute st using @b2_false, @b3_TRUE, @b3_TRUE, @b3_False, @b3_False, @n1_null;
execute st using @empty_str, @path_root, @path_root, @path_0, @path_0, @path_1;
deallocate prepare st;

prepare st from 'select json_objectagg(?,?);';
execute st using @jdoc      , @jobj      ;
execute st using @jobj      , @jarr      ;
execute st using @jarr      , @int1      ;
execute st using @int1      , @int2      ;
execute st using @int2      , @str1      ;
execute st using @str1      , @str_a     ;
execute st using @str_a     , @b1_true   ;
execute st using @b1_true   , @b2_false  ;
execute st using @b2_false  , @b3_TRUE   ;
execute st using @b3_TRUE   , @b3_False  ;
execute st using @b3_False  , @n1_null   ;
execute st using @n1_null   , @n1_NULL   ;
execute st using @n1_NULL   , @empty_str ;
execute st using @empty_str , @path_root ;
execute st using @path_root , @path_0    ;
execute st using @path_0    , @path_1    ;
execute st using @path_1    , @jdoc      ;
deallocate prepare st;

prepare st from 'select json_merge(?,?);';
execute st using @jdoc      , @jobj      ;
execute st using @jobj      , @jarr      ;
execute st using @b1_true   , @b2_false  ;
execute st using @n1_null   , @n1_NULL   ;
execute st using @n1_NULL   , @empty_str ;
execute st using @jarr      , @int1      ;
execute st using @int1      , @int2      ;
execute st using @int2      , @str1      ;
execute st using @str1      , @str_a     ;
execute st using @str_a     , @b1_true   ;
execute st using @b2_false  , @b3_TRUE   ;
execute st using @b3_TRUE   , @b3_False  ;
execute st using @b3_False  , @n1_null   ;
execute st using @empty_str , @path_root ;
execute st using @path_root , @path_0    ;
execute st using @path_0    , @path_1    ;
execute st using @path_1    , @jdoc      ;
deallocate prepare st;
prepare st from 'select json_merge_preserve(?,?,?,?);';
execute st using @jdoc, @jobj, @jobj, @jarr;
deallocate prepare st;
prepare st from 'select json_merge_preserve(?,?,?,?,?);';
execute st using @jdoc, @jobj, @jobj, @jarr, @n1_null;
execute st using @jdoc, @jobj, @jobj, @jarr, @n1_NULL;
deallocate prepare st;

prepare st from 'select json_merge_patch(?,?);';
execute st using @jdoc      , @jobj      ;
execute st using @jobj      , @jarr      ;
execute st using @b1_true   , @b2_false  ;
execute st using @n1_null   , @n1_NULL   ;
--CBRD-22695 following two qureies have different results with MySQL. (fixed as return null)
execute st using @n1_NULL   , @empty_str ;
execute st using @empty_str , @n1_NULL   ;

execute st using @jarr      , @int1      ;
execute st using @int1      , @int2      ;
execute st using @int2      , @str1      ;
execute st using @str1      , @str_a     ;
execute st using @str_a     , @b1_true   ;
execute st using @b2_false  , @b3_TRUE   ;
execute st using @b3_TRUE   , @b3_False  ;
execute st using @b3_False  , @n1_null   ;
execute st using @empty_str , @path_root ;
execute st using @path_root , @path_0    ;
execute st using @path_0    , @path_1    ;
execute st using @path_1    , @jdoc      ;
deallocate prepare st;
prepare st from 'select json_merge_patch(?,?,?,?);';
execute st using @jdoc, @jobj, @jobj, @jarr      ;
deallocate prepare st;
prepare st from 'select json_merge_patch(?,?,?,?,?);';
execute st using @jdoc, @jobj, @jobj, @jarr, @n1_null;
execute st using @jdoc, @jobj, @jobj, @jarr, @n1_NULL;

drop prepare st;
drop variable @jdoc, @jobj, @jarr, @int1, @int2, @str1, @b1_true, @b2_false, @b3_TRUE, @b3_False;
drop variable @str_a,@path_root,@path_0,@path_1, @n1_null, @n1_NULL, @empty_str;

--+ holdcas off;
