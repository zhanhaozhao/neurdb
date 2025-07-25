BEGIN;
CREATE TABLE t1 (id INT PRIMARY KEY, val INT);
INSERT INTO t1 VALUES (1, 100);
COMMIT;

-- session 1
BEGIN ISOLATION LEVEL SERIALIZABLE;
UPDATE t1 SET val = 200 WHERE id = 1;

-- session 2
BEGIN ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM t1 WHERE id = 1;
COMMIT;

-- session 1
COMMIT;
