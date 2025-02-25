-- This scenario varifies CBRD-25147 issue.
-- Add SQL syntax to add users as members of the group.

-- 1. Check the ALTER USER SQL syntax

CREATE USER test_user1;
CREATE USER test_user2;

-- Attempt to remove a non-existent member from the group by a general user: should raise an error:-168
ALTER USER test_user1 DROP MEMBERS test_user2;

-- Verify the syntax: ALTER USER user_name PASSWORD password;
ALTER USER test_user1 PASSWORD '1234';
CALL login ('test_user1', '1234') ON CLASS db_user;

CALL login ('dba', '') ON CLASS db_user;
-- Verify the syntax: ALTER USER user_name COMMENT 'comment_string';
ALTER USER test_user1 COMMENT '1) comment';
SELECT name, comment FROM db_user WHERE name = 'TEST_USER1';

-- Verify handling of special characters in comments
ALTER USER test_user1 COMMENT '1) ''comment';
SELECT name, comment FROM db_user WHERE name = 'TEST_USER1';

-- Verify the syntax: ALTER USER user_name ADD MEMBERS user_name;
ALTER USER test_user1 ADD MEMBERS test_user2;
SELECT u.name, x.name as groups FROM db_user AS u, TABLE(u.direct_groups) AS g(x) order by 1;

-- Verify the syntax: ALTER USER user_name DROP MEMBERS user_name;
ALTER USER test_user1 DROP MEMBERS test_user2;
SELECT u.name, x.name as groups FROM db_user AS u, TABLE(u.direct_groups) AS g(x) order by 1;

-- Verify the syntax: ALTER USER user_name PASSWORD password COMMENT 'comment_string';
ALTER USER test_user1 PASSWORD '4321' COMMENT '2) password, comment';
CALL login ('test_user1', '4321') ON CLASS db_user;
SELECT name, comment FROM db_user WHERE name = 'TEST_USER1';

-- Attempt to use incorrect syntax: should raise an error:-493
CALL login ('dba', '') ON CLASS db_user;
ALTER USER test_user1 PASSWORD '1234' ADD MEMBERS test_user2;
ALTER USER test_user1 PASSWORD '1234' DROP MEMBERS test_user2;
ALTER USER test_user1 ADD MEMBERS test_user2 DROP MEMBERS test_user2;

-- Verify the syntax: ALTER USER user_name ADD MEMBERS user_name COMMENT ‘comment_string’;
ALTER USER test_user1 ADD MEMBERS test_user2 COMMENT '3) add members, comment';
SELECT u.name, x.name as groups, u.comment FROM db_user AS u, TABLE(u.direct_groups) AS g(x) order by 1;

-- Verify the syntax: ALTER USER user_name DROP MEMEBERS user_name COMMENT ‘comment_string’;
ALTER USER test_user1 DROP MEMBERS test_user2 COMMENT '4) drop members, comment';
SELECT u.name, x.name as groups, u.comment FROM db_user AS u, TABLE(u.direct_groups) AS g(x) order by 1;

-- Attempt to use incorrect syntax: should raise an error:-493
ALTER USER test_user1 PASSWORD '1234' ADD MEMBERS test_user2 COMMENT '5) password, add members, comment';
ALTER USER test_user1 PASSWORD '1234' DROP MEMBERS test_user2 COMMENT '5) password, add members, comment';

DROP USER test_user1; 
DROP USER test_user2;
