---Create database and schema:
---Drop & create databases

Use master;
go

If exiists (select 1 from sys.databases where name ="data_warehouse"
begin
	alter database data_warehouse set single_user with rollback immediate;
	drop database data_warehouse;
end;
go

----create warehouse & schema
  create database data_warehouse;
  create schema bronze;
	go
	create schema silver;
	go
	create schema gold;
	go
 
 
 
