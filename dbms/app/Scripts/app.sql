CREATE database app;
use app;

create table tbl_member(
	id bigint unsigned auto_increment primary key,
	member_id varchar(255) not null,
	member_password varchar(255) not null,
	member_name varchar(255) not null
);

select * from tbl_member;

select * from tbl_member
where id = 2;

create table tbl_student(
	id bigint unsigned auto_increment primary key,
	student_name varchar(255) not null,
	student_major varchar(255) not null,
	student_level int default 1
);

# 아이디 중복검사
# 회원가입(SMS API) - 랜덤한 인증번호 6자리 발송 후 검사
# 회원 비밀번호 변경(EMAIL API) - 랜덤한 인증번호 10자리 발송 후 검사

# 사용자가 입력한 문장을 영어로 번역
# 한국어와 번역된 문장을 DBMS에 저장
# 번역 내역 조회

# 업로드한 이미지 파일의 이름과 이미지의 내용을 DBMS에 저장(OCR API)

create table tbl_user(
	id bigint unsigned auto_increment primary key,
	user_name varchar(255) not null,
	user_email_id varchar(255) not null UNIQUE KEY,
	user_password varchar(255) not null,
	user_phone varchar(255) not null
	


select * from tbl_user;
	
	

create table tbl_parent(
   id bigint unsigned auto_increment primary key,
   parent_name varchar(255) not null,
   parent_age tinyint unsigned,
   parent_address varchar(255) not null,
   parent_phone varchar(255) not null unique,
   parent_gender varchar(10) not null,
   parent_type varchar(100) default 'parent'
);

INSERT INTO tbl_parent
(parent_name, parent_age, parent_address, parent_phone, parent_gender, parent_type)
VALUES('임수현', 20, '경기도 안성', '01012341234', '남자', 'parent');


INSERT INTO tbl_parent
(parent_name, parent_age, parent_address, parent_phone, parent_gender, parent_type)
VALUES('번개맨', 20, '지구', '01077777777', '남자', 'admin');

INSERT INTO tbl_parent
(parent_name, parent_age, parent_address, parent_phone, parent_gender, parent_type)
VALUES('홍길동', 30, '경기도 파주', '01012345678', '남자', 'parent');

select * from tbl_parent;

create table tbl_child(
   id bigint unsigned auto_increment primary key,
   child_name varchar(255) not null,
   child_age tinyint unsigned default 6,
   child_gender varchar(10) not null,
   parent_id bigint unsigned,
   constraint fk_child_parent foreign key(parent_id)
   references tbl_parent(id)
);

INSERT INTO tbl_child
(child_name, child_age, child_gender, parent_id)
VALUES('철수', 5, '남자', 1);

INSERT INTO tbl_child
(child_name, child_age, child_gender, parent_id)
VALUES('짱구', 5, '남자', 1);

INSERT INTO tbl_child
(child_name, child_age, child_gender, parent_id)
VALUES('맹구', 5, '남자', 2);

INSERT INTO tbl_child
(child_name, child_age, child_gender, parent_id)
VALUES('훈이', 5, '남자', 2);

INSERT INTO tbl_child
(child_name, child_age, child_gender, parent_id)
VALUES('유리', 5, '여자', 3);

create table tbl_field_trip(
   id bigint unsigned auto_increment primary key,
   field_trip_title varchar(255) not null,
   field_trip_content varchar(255) not null,
   field_trip_number int unsigned
);

select * from tbl_field_trip;

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
	
select * from tbl_apply;

select * from tbl_soft_drink;
select * from tbl_product;
	




	
	
	
	
	
	
);