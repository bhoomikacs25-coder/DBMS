show databases;
create database IF NOT exists newdatabases;
show databases;
use newdatabases;
create table uno
(
name varchar(20),
age int,
gender char 
);
select * from uno;
insert into uno values ("bhoomika",18,"F");
select * from uno;


