CREATE TABLE MoviesTable(
Id integer,
Name varchar(255),
Rating varchar(255),
Genre varchar(255),
Year smallint,
Released varchar(255),
Score real,
Votes integer,
Director varchar(255),
Writer varchar(255), 
Star varchar(255),
Country varchar(255),
Budget varchar(255),
Gross bigint,
Company varchar(255),
Runtime integer
);

SELECT * FROM MoviesTable
WHERE gross > 2000000000
ORDER BY gross
;
