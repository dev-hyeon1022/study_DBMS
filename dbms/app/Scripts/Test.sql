create database app;
use app;

create table tbl_member(
   id bigint unsigned auto_increment primary key,
   member_id varchar(255) not null,
   member_password varchar(255) not null,
   member_name varchar(255) not null,
   member_phone varchar(255) not null,
   member_email varchar(255) not null
);

alter table tbl_member add constraint uk_member unique(member_email);

select * from tbl_member;

create table tbl_product(
   id bigint unsigned auto_increment primary key,
   product_name varchar(255) not null,
   product_price int unsigned default 0,
   created_date date default (current_date)
);

select * from tbl_product;

create table tbl_student(
   id bigint unsigned auto_increment primary key,
   student_name varchar(255),
   student_birth datetime default current_timestamp
);

select * from tbl_student;

create table tbl_translate(
   id bigint unsigned auto_increment primary key,
   korean_message varchar(1000),
   english_message varchar(1000)
);

select * from tbl_translate;

create table tbl_image_text(
   id bigint unsigned auto_increment primary key,
   image_url varchar(1000),
   image_text varchar(1000)
);

select * from tbl_image_text;
/********************************************************************/
create table tbl_parent(
   id bigint unsigned auto_increment primary key,
   parent_name varchar(255) not null,
   parent_age tinyint unsigned,
   parent_address varchar(255) not null,
   parent_phone varchar(255) not null,
   parent_gender varchar(10) not null
);

create table tbl_child(
   id bigint unsigned auto_increment primary key,
   child_name varchar(255) not null,
   child_age tinyint unsigned default 6,
   child_gender varchar(10) not null,
   parent_id bigint unsigned,
   constraint fk_child_parent foreign key(parent_id)
   references tbl_parent(id)
);

create table tbl_field_trip(
   id bigint unsigned auto_increment primary key,
   field_trip_title varchar(255) not null,
   field_trip_content varchar(255) not null,
   field_trip_number int unsigned
);

create table tbl_field_trip_file(
   id bigint unsigned auto_increment primary key,
   file_name varchar(255),
   file_uuid varchar(255),
   file_path varchar(255),
   file_position varchar(255),
   field_trip_id bigint unsigned,
   constraint fk_field_trip_file_field_trip foreign key(field_trip_id)
   references tbl_field_trip(id)
);

create table tbl_apply(
   id bigint unsigned auto_increment primary key,
   child_id bigint unsigned not null,
   field_trip_id bigint unsigned not null,
   constraint fk_apply_child foreign key(child_id)
   references tbl_child(id),
   constraint fk_apply_field_trip foreign key(field_trip_id)
   references tbl_field_trip(id)
);




/**************************************************************/

create table tbl_member(
   id bigint unsigned auto_increment primary key,
   member_address varchar(255) not null
);


create table tbl_soft_drink(
   id bigint unsigned auto_increment primary key,
   soft_drink_name varchar(255) not null,
   soft_drink_price int default 0
);

create table tbl_product(
   id bigint unsigned auto_increment primary key,
   product_name varchar(255) not null
);

create table tbl_lottery(
   id bigint unsigned auto_increment primary key,
   product_id bigint unsigned,
   constraint fk_lottery_product foreign key(product_id)
   references tbl_product(id)
);

create table tbl_circulation(
   id bigint unsigned auto_increment primary key,
   lottery_id bigint unsigned,
   soft_drink_id bigint unsigned,
   constraint fk_circulation_lottery foreign key(lottery_id)
   references tbl_lottery(id),
   constraint fk_circulation_soft_drink foreign key(soft_drink_id)
   references tbl_soft_drink(id)
);

create table tbl_delivery(
   id bigint unsigned auto_increment primary key,
   delivery_status varchar(30) default 'READY',
   member_id bigint unsigned not null,
   product_id bigint unsigned not null,
   constraint fk_delivery_member foreign key(member_id)
   references tbl_member(id),
   constraint fk_delivery_product foreign key(product_id)
   references tbl_product(id)
);







