create database study;
use study;

/*무결성 위반*/
create table tbl_animal(
   animal_name varchar(255),
   animal_age tinyint
);

drop table tbl_animal;

create table tbl_animal(
   id bigint unsigned auto_increment primary key,
   animal_name varchar(255) not null,
   animal_age tinyint unsigned check(animal_age > 3)
);

/*   TBL_MEMBER
   -------------------------
   id: bigint(pk)      
   -------------------------
   member_id(uk): varchar   
   member_password: varchar   
   member_address: varchar   
   member_email(uk): varchar
   member_birth: date
*/
create table tbl_member(
   id bigint unsigned auto_increment primary key,
   member_id varchar(255) not null unique,
   member_password varchar(255) not null,
   member_email varchar(255) not null unique,
   member_birth date
);

/*alter table [테이블명] add [컬럼명] [자료형] [제약조건];*/
alter table tbl_member add member_address varchar(255);

/*
   tbl_product
   -------------------------
   id: bigint(pk)
   -------------------------
   product_name: varchar
   product_price: int
   product_stock: int
*/
create table tbl_product(
   id bigint unsigned auto_increment primary key,
   product_name varchar(255) not null,
   product_price int default 0,
   product_stock int default 0
);

/*
   tbl_order
   -------------------------
   id: bigint(pk)
   -------------------------
   order_date: datetime
   member_id: bigint(fk)
   product_id: bigint(fk)
*/
create table tbl_order(
   id bigint unsigned auto_increment primary key,
   order_date datetime default current_timestamp(),
   member_id bigint unsigned,
   product_id bigint unsigned,
   constraint fk_order_member foreign key(member_id)
   references tbl_member(id),
   constraint fk_order_product foreign key(product_id)
   references tbl_product(id)
);

alter table tbl_order add product_count int;

/*
 * 요구 사항
 * 
 * 커뮤니티 게시판을 만들고 싶어요.
 * 게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
 * 게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요
 * 작성자는 회원(TBL_MEMBER)정보를 그대로 사용해요.
 * 댓글에도 작성자가 필요해요.
 * 
 * 
 * */
create table tbl_post(
   id bigint unsigned auto_increment primary key,
   post_title varchar(255) not null,
   post_content varchar(255) not null,
   member_id bigint unsigned,
   constraint fk_post_member foreign key(member_id)
   references tbl_member(id)
);

create table tbl_reply(
   id bigint unsigned auto_increment primary key,
   reply_content varchar(255) not null,
   post_id bigint unsigned,
   member_id bigint unsigned,
   constraint fk_reply_post foreign key(post_id)
   references tbl_post(id)
   constraint fk_reply_member foreign key(member_id)
   references tbl_member(id)
);



/*
 * 요구사항
 * 
 * 마이페이지에서 회원 프로필을 구현하고 싶습니다.
 * 회원당 프로필을 여러 개 설정할 수 있고 
 * 대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.
 * 
 * */

create table tbl_file(
   id bigint unsigned auto_increment primary key,
   file_name varchar(255),
   file_uuid varchar(255),
   file_path varchar(255),
   file_represent varchar(255),
   member_id bigint unsigned,
   constraint fk_file_member foreign key(member_id)
   references tbl_member(id)
);


/*

1.학사 관리 시스템에서 학생과 교수가 존재
2.학생은 학번, 이름, 전공, 학년 등
3.교수는 교수 번호, 이름, 전공, 직위 등
4.과목은 고유한 과목 번호, 과목명, 학점 등
6.학생은 여러 개의 과목을 수강가능
7.교수는 여러 개의 과목을 강의가능
8.학생이 수강한 과목은 성적이 기록됩니다. 
*/

create table tbl_student(
   id bigint unsigned auto_increment primary key,
   student_name varchar(255) not null,
   student_major varchar(255) not null,
   student_level int default 1
);

create table tbl_professor(
   id bigint unsigned auto_increment primary key,
   professor_name varchar(255) not null,
   professor_major varchar(255) not null,
   professor_position varchar(255) not null
);


create table tbl_subject(
   id bigint unsigned auto_increment primary key,
   subject_name varchar(255) not null,
   subject_score int default 0
);

create table tbl_student_subject(
   id bigint unsigned auto_increment primary key,
   student_id bigint unsigned,
   subject_id bigint unsigned,
   constraint fk_student_subject_student foreign key(student_id)
   references tbl_student(id),
   constraint fk_student_subject_subject foreign key(subject_id)
   references tbl_subject(id)
);

alter table tbl_student_subject add subject_grade varchar(255);
alter table tbl_student_subject add subject_status varchar(255);

create table tbl_lecture(
   id bigint unsigned auto_increment primary key,
   professor_id bigint unsigned,
   subject_id bigint unsigned,
   constraint fk_lecture_professor foreign key(professor_id)
   references tbl_professor(id),
   constraint fk_lecture_subject foreign key(subject_id)
   references tbl_subject(id)
);

/*
 * 요구사항 
 * 
 * 대 카테고리, 소 카테고리가 필요해요. 
 * 
 * */
create table tbl_category_a(
   id bigint unsigned auto_increment primary key,
   category_a_name varchar(255) not null,
   category_a_status varchar(255) default 'ENABLE'
);


create table tbl_category_b(
   id bigint unsigned auto_increment primary key,
   category_b_name varchar(255) not null,
   category_status varchar(255) default 'ENABLE',
   category_a_id bigint unsigned,
   constraint category_b_category_a foreign key(category_a_id)
   references tbl_category_a(id)
);


/*
 * 요구 사항
 * 
 * 회의실 예약 서비스를 제작하고 싶습니다.
 * 회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
 * 회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.
 * 
 * */


drop table tbl_order;
drop table tbl_reply;
drop table tbl_post;
drop table tbl_file;
drop table tbl_member;

create table tbl_member(
   id bigint unsigned auto_increment primary key,
   member_type varchar(255) default 'basic',
   member_id varchar(255) unique not null,
   member_password varchar(255) not null
);

create table tbl_office(
   id bigint unsigned auto_increment primary key,
   office_name varchar(255),
   office_location varchar(255)
);

/*파트 타임이 아닐 경우*/
/*
create table tbl_conference_room(
   id bigint unsigned auto_increment primary key,
   start_time datetime,
   end_time datetime,
   office_id bigint unsigned,
   constraint conference_room_office_office foreign key(office_id)
   references tbl_office(id)
);
*/

alter table tbl_conference_room drop start_time;
alter table tbl_conference_room drop end_time;

/*파트 타임일 경우*/
create table tbl_conference_room(
   id bigint unsigned auto_increment primary key,
   office_id bigint unsigned,
   constraint conference_room_office_office foreign key(office_id)
   references tbl_office(id)
);

/*파트 타임일 경우*/
create table tbl_part_time(
   id bigint unsigned auto_increment primary key,
   start_time datetime,
   end_time datetime,
   conference_room_id bigint unsigned,
   constraint part_time_conference_room foreign key(conference_room_id)
   references tbl_conference_room(id)
);

create table tbl_reservation(
   id bigint unsigned auto_increment primary key,
   member_id bigint unsigned,
   conference_room_id bigint unsigned,
   constraint reservation_member foreign key(member_id)
   references tbl_member(id),
   constraint reservation_conference_room foreign key(conference_room_id)
   references tbl_conference_room(id)
);

/*

   요구사항
   
   유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
   아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
   체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
   아이들은 여러 번 체험학습에 등록할 수 있어요.

*/
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

/*

   요구사항
   
   안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
   광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
   광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
   기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

*/
create table tbl_company(
   id bigint unsigned auto_increment primary key,
   company_name varchar(255) not null,
   company_address varchar(255) not null,
   company_phone varchar(255) not null,
   company_type varchar(255) not null
);

create table tbl_category_a(
   id bigint unsigned auto_increment primary key,
   category_a_name varchar(255) not null
);

create table tbl_category_b(
   id bigint unsigned auto_increment primary key,
   category_b_name varchar(255) not null,
   category_a_id bigint unsigned,
   constraint fk_category_b_category_a foreign key(category_a_id)
   references tbl_category_a(id)
);

create table tbl_category_c(
   id bigint unsigned auto_increment primary key,
   category_c_name varchar(255) not null,
   category_b_id bigint unsigned,
   constraint fk_category_c_category_b foreign key(category_b_id)
   references tbl_category_b(id)
);

create table tbl_advertisement(
   id bigint unsigned auto_increment primary key,
   advertisement_title varchar(255) not null,
   advertisement_content varchar(255) not null,
   category_c_id bigint unsigned not null,
   constraint fk_advertisement_category_c foreign key(category_c_id)
   references tbl_category_c(id)
);


create table tbl_apply(
   id bigint unsigned auto_increment primary key,
   company_id bigint unsigned,
   advertisement_id bigint unsigned,
   constraint fk_apply_company foreign key(company_id)
   references tbl_company(id),
   constraint fk_apply_advertisement foreign key(advertisement_id)
   references tbl_advertisement(id)
);

/*

   요구사항
   
   음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다. 
   음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
   당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

*/

create table tbl_soft_drink(
   id bigint unsigned auto_increment primary key,
   soft_drink_name varchar(255) not null,
   soft_drink_price int default 0
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


drop table tbl_product;

create table tbl_product(
   id bigint unsigned auto_increment primary key,
   product_name varchar(255) not null
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

/*

   요구사항
   
   이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
   기업의 정보는 기업 이름, 주소, 대표번호가 있고
   사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
   상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
   사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.
   사용자는 카드를 여러 개 등록할 수 있습니다.

*/

drop table tbl_apply;
drop table tbl_company;

create table tbl_company(
   id bigint unsigned auto_increment primary key,
   company_name varchar(255) not null,
   company_address varchar(255) not null,
   company_telecom varchar(20) not null
);

create table tbl_user(
   id bigint unsigned auto_increment primary key,
   user_name varchar(255) not null,
   user_address varchar(255) not null,
   user_phone varchar(20) not null
);


create table tbl_product(
   id bigint unsigned auto_increment primary key,
   product_name varchar(255) not null,
    product_price int default 0,
    product_stock int default 0,
    company_id bigint unsigned,
    constraint fk_product_company foreign key(company_id)
    references tbl_company(id)
);


create table tbl_card(
   id bigint unsigned auto_increment primary key,
   card_number varchar(255) not null,
   card_company varchar(255) not null,
   user_id bigint unsigned,
   constraint fk_card_user foreign key(user_id)
   references tbl_user(id)
);

create table tbl_pay(
   id bigint unsigned auto_increment primary key,
   user_id bigint unsigned,
   card_id bigint unsigned,
   order_id bigint unsigned not null,
   order_date date not null,
   constraint fk_pay_user foreign key(user_id)
   references tbl_user(id),
   constraint fk_pay_card foreign key(card_id)
   references tbl_card(id),
   constraint fk_pay_order foreign key(order_id, order_date)
   references tbl_order(id, order_date)
);

create table tbl_sequence(
   id bigint unsigned auto_increment primary key,
   sequence_name varchar(255),
   current_value bigint unsigned
);

/*주문 번호: 당일 1부터 시작, 당일 년 월 일*/
create table tbl_order(
   id bigint unsigned,
   order_date date default (current_date),
   user_id bigint unsigned,
   constraint fk_order_user foreign key(user_id)
   references tbl_user(id),
   constraint pk_order primary key(id, order_date)
);

create table tbl_order_detail(
   id bigint unsigned auto_increment primary key,
   order_id bigint unsigned not null,
   order_date date not null,
   product_id bigint unsigned not null,
   product_count int not null,
   constraint fk_order_detail_order foreign key(order_id, order_date)
   references tbl_order(id, order_date),
   constraint fk_order_detail_product foreign key(product_id)
   references tbl_product(id)
);








