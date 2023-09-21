/**********************************************************************/
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

insert into tbl_member(member_id, member_password)
values('hds', '1234');

insert into tbl_member(member_id, member_password)
values('hgd', '1234');

insert into tbl_member(member_id, member_password)
values('lss', '1234');

select * from tbl_member;

create table tbl_office(
   id bigint unsigned auto_increment primary key,
   office_name varchar(255),
   office_location varchar(255)
);

insert into tbl_office(office_name, office_location)
values('강남점', '강남구');

insert into tbl_office(office_name, office_location)
values('노원점', '노원구');

insert into tbl_office(office_name, office_location)
values('분당점', '분당');

insert into tbl_office(office_name, office_location)
values('인천점', '인천');

select * from tbl_office;

create table tbl_conference_room(
   id bigint unsigned auto_increment primary key,
   office_id bigint unsigned,
   constraint conference_room_office_office foreign key(office_id)
   references tbl_office(id)
);

insert into tbl_conference_room
(office_id)
values (4);

select * from tbl_conference_room;

create table tbl_part_time(
   id bigint unsigned auto_increment primary key,
   start_time datetime,
   end_time datetime,
   conference_room_id bigint unsigned,
   constraint part_time_conference_room foreign key(conference_room_id)
   references tbl_conference_room(id)
);

alter table tbl_part_time change start_time start_time time;
alter table tbl_part_time change end_time end_time time;

insert into tbl_part_time
(start_time, end_time, conference_room_id)
values('11:00:00', '12:00:00', 11);
insert into tbl_part_time
(start_time, end_time, conference_room_id)
values('11:00:00', '12:00:00', 1);
insert into tbl_part_time
(start_time, end_time, conference_room_id)
values('11:00:00', '12:00:00', 9);
insert into tbl_part_time
(start_time, end_time, conference_room_id)
values('16:00:00', '18:00:00', 7);

select * from tbl_part_time;

/*시작 시간별 회의실 개수*/
select start_time, end_time, count(conference_room_id) from tbl_part_time
group by start_time, end_time;

select current_time  from dual;

create table tbl_reservation(
   id bigint unsigned auto_increment primary key,
   member_id bigint unsigned,
   conference_room_id bigint unsigned,
   constraint reservation_member foreign key(member_id)
   references tbl_member(id),
   constraint reservation_conference_room foreign key(conference_room_id)
   references tbl_conference_room(id)
);

/*SUB QUERY*/
/*
 * FROM절: IN LINE VIEW
 * SELECT절: SCALAR
 * WHERE절: SUB QUERY
 * 
 * */
INSERT INTO tbl_field_trip
(field_trip_title, field_trip_content, field_trip_number)
VALUES('테스트 제목1', '테스트 내용1', 10);
INSERT INTO tbl_field_trip
(field_trip_title, field_trip_content, field_trip_number)
VALUES('테스트 제목2', '테스트 내용2', 20);
INSERT INTO tbl_field_trip
(field_trip_title, field_trip_content, field_trip_number)
VALUES('테스트 제목3', '테스트 내용3', 25);
INSERT INTO tbl_field_trip
(field_trip_title, field_trip_content, field_trip_number)
VALUES('테스트 제목3', '테스트 내용4', 5);
INSERT INTO tbl_field_trip
(field_trip_title, field_trip_content, field_trip_number)
VALUES('테스트 제목2', '테스트 내용5', 40);

/*제목이 '테스트 제목3'인 체험학습 중에 지원 가능 수가 5보다 큰 체험학습 조회*/
select * from
(
   select * from tbl_field_trip
   where field_trip_title = '테스트 제목3'
) ft
where ft.field_trip_number > 5;


/*체험학습 평균 지원수 보다 큰 체험학습 전체 정보 조회*/
/*select ft.*, (select avg(field_trip_number) from tbl_field_trip) 
from tbl_field_trip ft
where field_trip_number > 
(select avg(field_trip_number) from tbl_field_trip);*/
select * 
from tbl_field_trip
where field_trip_number > 
(select avg(field_trip_number) from tbl_field_trip);

/*체험학습 제목 별 개수가 2이상인 체험학습의 전체 정보 조회*/
/*컬럼명 in(A, B, ...)*/
/*컬럼명 = A OR 컬럼명 = B OR, ...*/
/*where field_trip_title = '테스트 제목2' OR field_trip_title = '테스트 제목3';*/
/*where field_trip_title in ('테스트 제목2', '테스트 제목3');*/

select * from tbl_field_trip
where field_trip_title in
(
   select field_trip_title 
   from tbl_field_trip
   group by field_trip_title
   having count(id) >= 2
);

/*order by*/
/*asc: 오름차순, 생략 가능*/
/*desc: 내림차순*/
/*order by [컬럼명] [asc/desc]*/

select * from tbl_field_trip
where field_trip_title in
(
   select field_trip_title 
   from tbl_field_trip
   group by field_trip_title
   having count(id) >= 2
)
order by field_trip_number desc;

/*
 * SQL 실행 순서
 * from > on > join > where > group by > having > select > order by
 * 
 * */

INSERT INTO tbl_member
(member_id, member_password, member_email, member_birth, member_address)
VALUES('hds1234', '1234', 'hds1234@gmail.com', '2023-12-04', '경기도 남양주시');

INSERT INTO tbl_member
(member_id, member_password, member_email, member_birth, member_address)
VALUES('lub7890', '1234', 'lub7890@gmail.com', '2023-12-04', '경기도 남양주시');

INSERT INTO tbl_product
(product_name, product_price, product_stock)
VALUES('옷', 30000, 50);

INSERT INTO tbl_order
(member_id, product_id, product_count)
VALUES(1, 1, 5);

select * from tbl_member;
select * from tbl_product;

select * 
from tbl_order o 
inner join tbl_member m
on o.member_id = m.id
inner join tbl_product p
on o.product_id = p.id;



/*회원 정보 추가*/
INSERT INTO tbl_member
(member_id, member_password, member_email, member_birth, member_address)
VALUES('lsh', '1234', 'lsh1234@gmail.com', '2021-04-01', '경기도 평택시');

INSERT INTO tbl_member
(member_id, member_password, member_email, member_birth, member_address)
VALUES('hited7890', '1234', 'hited7890@gmail.com', '2020-11-30', '경기도 안성시');

INSERT INTO tbl_member
(member_id, member_password, member_email, member_birth, member_address)
VALUES('ceoi01234', '1234', 'ceoi1234@gmail.com', '2020-01-30', '경기도 안성시');

select * from tbl_member;

/*게시글 추가*/

INSERT INTO tbl_post
(post_title, post_content, member_id)
VALUES('점심메뉴 추천', '배고픈데 점메추 해주세요', 1);

INSERT INTO tbl_post
(post_title, post_content, member_id)
VALUES('야식추천', '야식으로 뭐 먹을까요?', 2);

select * from tbl_post;

/*댓글 추가*/

INSERT INTO tbl_reply
(reply_content, post_id, member_id)
VALUES('점심으로 제육볶음 추천합니다', 1,2);
 

INSERT INTO tbl_reply
(reply_content, post_id, member_id)
VALUES('점심엔 김밥 추천합니다', 1,1);

INSERT INTO tbl_reply
(reply_content, post_id, member_id)
VALUES('안녕', 2);

select * from tbl_reply;



/*게시글 정보와 그 게시글을 작성한 회원 정보 모두 조회*/
select * 
from tbl_post post
join tbl_member mb
on post.member_id = mb.id;


/*댓글 조회와 작성자 정보 모두 조회*/
select *
from tbl_reply rp
join tbl_member mb
on rp.post_id = mb.id;


/*댓글 내용 중 "안녕"이 포함된 댓글의 게시글 정보 중 게시글 제목과 내용 조회*/
select post.post_title, post.post_content
from tbl_reply rp
join tbl_post post
on rp.post_id = post.id
where rp.reply_content = '안녕';

/*웅빈님 코드*/
select tr.*, tp.post_title , tp.post_content 
from tbl_reply tr 
inner join tbl_post tp 
on tr.post_id = tp.id 
where reply_content like "%안녕%"


/*게시글 별 댓글 수가 가장 많은 게시글 정보와 작성자 정보 조회 */

create table tbl_reply(
   id bigint unsigned auto_increment primary key,
   reply_content varchar(255) not null,
   post_id bigint unsigned,
   member_id bigint unsigned,
   constraint fk_reply_post foreign key(post_id)
   references tbl_post(id),
   constraint fk_reply_member foreign key(member_id)
   references tbl_member(id)
);


select *
from tbl_reply rp
join tbl_post post
on rp.post_id = post.id


select * from tbl_reply;
select * from tbl_post;









/*===========================================================================*/
/*회원 정보 추가*/
select * from tbl_member;

/*게시글 추가*/
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1' , 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목2', '테스트 내용2' , 3);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목3', '테스트 내용3' , 3);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목4', '테스트 내용4' , 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목5', '테스트 내용5' , 1);

select * from tbl_post;

/*댓글 추가*/
insert into tbl_reply(reply_content, member_id, post_id)
values('테스트 댓글1', 3, 1);
insert into tbl_reply(reply_content, member_id, post_id)
values('테스트 댓글2', 3, 1);
insert into tbl_reply(reply_content, member_id, post_id)
values('테스트 댓글3', 3, 3);
insert into tbl_reply(reply_content, member_id, post_id)
values('테스트 댓글1', 1, 4);
insert into tbl_reply(reply_content, member_id, post_id)
values('테스트 댓글1', 1, 5);

select * from tbl_reply;

/*게시글 정보와 그 게시글을 작성한 회원 정보 모두 조회*/
select * 
from tbl_member m
inner join tbl_post p
on m.id = p.member_id;

/*댓글 조회와 작성자 정보 모두 조회*/
select *
from tbl_member m
inner join tbl_reply r
on m.id = r.member_id;

/*댓글 내용 중 "안녕"이 포함된 댓글의 게시글 정보 중 게시글 제목과 내용 조회*/
update tbl_reply
set reply_content = '테스트 안녕!'
where id = 4;

select post_title, post_content 
from tbl_post p
inner join tbl_reply r
on reply_content like '%안녕%' and p.id = r.post_id;

select post_title, post_content
from tbl_post p
inner join
(
   select * from tbl_reply
   where reply_content like '%안녕%'
) r
on p.id = r.post_id;

/*게시글 별 댓글 수가 가장 많은 게시글 정보와 작성자 정보 조회*/
select * 
from tbl_member m
inner join
tbl_post p
on p.id =
(
   select post_id
   from
   (
      select p1.post_id, max(p1.reply_count) 
      from
      (
         select post_id, count(post_id) reply_count from tbl_reply
         group by post_id
      ) p1
   ) p2
)
and
m.id = p.member_id;

/*
 * limit 행번호(0부터), 개수
 * 
 * */
select * from tbl_member m
inner join tbl_post p
on p.id =
(
   select post_id from tbl_reply
   group by post_id
   order by count(post_id) desc
   limit 0, 1
)
and
m.id = p.member_id;

/*게시글 별 댓글 수가 가장 많은 게시글 정보와 작성자 정보 조회*/
select * 
from tbl_member m
inner join
tbl_post p
on p.id =
(
   select post_id
   from
   (
      select p1.post_id, max(p1.reply_count) 
      from
      (
         select post_id, count(post_id) reply_count from tbl_reply
         group by post_id
      ) p1
   ) p2
)
and
m.id = p.member_id;

/*
 * limit 행번호(0부터), 개수
 * 
 * */

select post_id, count(post_id) reply_count from tbl_reply
group by post_id
order by reply_count desc
limit 0, 1;

/*부모 테이블*/
insert into tbl_parent(parent_name, parent_age, parent_address, parent_phone, parent_gender)
values('한동석', 20, '경기도 남양주', '01012341234', '남자');
insert into tbl_parent(parent_name, parent_age, parent_address, parent_phone, parent_gender)
values('임희수', 21, '잠실 시그니엘', '01078977897', '여자');
insert into tbl_parent(parent_name, parent_age, parent_address, parent_phone, parent_gender)
values('임수현', 21, '경기도 안성', '01088889999', '남자');

select * from tbl_parent;

/*아이 테이블*/
insert into tbl_child(child_name, child_age, child_gender, parent_id)
values('장동혁', 5, '남자', 1);
insert into tbl_child(child_name, child_age, child_gender, parent_id)
values('임웅빈', 4, '남자', 2);
insert into tbl_child(child_name, child_age, child_gender, parent_id)
values('오주연', 3, '여자', 3);
insert into tbl_child(child_name, child_age, child_gender, parent_id)
values('허은상', 11, '남자', 1);
insert into tbl_child(child_name, child_age, child_gender, parent_id)
values('김혜빈', 20, '여자', 2);

select * from tbl_child;

/*체험학습 테이블*/
insert into tbl_field_trip(field_trip_title, field_trip_content, field_trip_number)
values('매미 잡기 체험학습', '매미 잡으러 떠나자!', 5);
insert into tbl_field_trip(field_trip_title, field_trip_content, field_trip_number)
values('메뚜기 때려 잡기 체험학습', '메뚜기 다 잡자!', 50);
insert into tbl_field_trip(field_trip_title, field_trip_content, field_trip_number)
values('물놀이 체험학습', '한강 수영장으로 퐁당!', 20);
insert into tbl_field_trip(field_trip_title, field_trip_content, field_trip_number)
values('블루베리 채집 체험학습', '맛있어 블루베리 냠냠!', 25);
insert into tbl_field_trip(field_trip_title, field_trip_content, field_trip_number)
values('코딩 체험학습', '나도 빌게이츠!', 20);

select * from tbl_field_trip;
select * from tbl_child;

/*신청하기 테이블*/
insert into tbl_apply(child_id, field_trip_id)
values(1, 6);
insert into tbl_apply(child_id, field_trip_id)
values(2, 7);
insert into tbl_apply(child_id, field_trip_id)
values(3, 8);
insert into tbl_apply(child_id, field_trip_id)
values(4, 6);
insert into tbl_apply(child_id, field_trip_id)
values(4, 8);
insert into tbl_apply(child_id, field_trip_id)
values(5, 7);
insert into tbl_apply(child_id, field_trip_id)
values(5, 6);
insert into tbl_apply(child_id, field_trip_id)
values(5, 9);
insert into tbl_apply(child_id, field_trip_id)
values(5, 10);
insert into tbl_apply(child_id, field_trip_id)
values(4, 10);

select * from tbl_apply;


/*매미 체험학습에 신청한 아이의 전체 정보*/
select * from tbl_child
where id in
(
   select child_id from tbl_apply
   where field_trip_id =
   (
      select id from tbl_field_trip
      where field_trip_title = '매미 잡기 체험학습'
   )
);

select c.* from tbl_field_trip ft
inner join tbl_apply a
on ft.field_trip_title = '매미 잡기 체험학습'
and a.field_trip_id = ft.id
inner join tbl_child c
on c.id = a.child_id;

/*체험학습을 2개 이상 신청한 아이의 정보와 부모의 정보 모두 조회*/
select c.*, p.* from tbl_child c
inner join
(
   select child_id from tbl_apply
   group by child_id
   having count(field_trip_id) >= 2
) a
on c.id = a.child_id
inner join tbl_parent p
on c.parent_id = p.id;

/*나이가 21살인 부모의 아이들이 지원한 체험학습 전체 조회 */
select id from tbl_parent
where parent_age = 21;

/*distinct는 중복된 행을 제거해준다.*/
select distinct ft.*
from tbl_apply a
inner join
(
   select id from tbl_child
   where parent_id in
   (
      select id from tbl_parent
      where parent_age = 21
   )
) c
on a.child_id = c.id
inner join tbl_field_trip ft
on a.field_trip_id = ft.id;

/*평균 참가자(지원자) 수보다 적은 체험학습의 제목과 내용 조회 */
select * from tbl_field_trip
where id in
(
   select field_trip_id from tbl_apply
   group by field_trip_id
   having count(child_id) <
   (
      select avg(child_count) from
      (
         select count(child_id) child_count from tbl_apply
         group by field_trip_id
      ) a
   )
);

/*참가자(지원자) 수가 가장 적은 체험학습의 제목과 내용 조회 */
select ft.* from tbl_field_trip ft
inner join
(
   select field_trip_id, count(child_id) from tbl_apply
   group by field_trip_id
   having count(child_id) in
   (
      select min(child_count) from
      (
         select count(child_id) child_count from tbl_apply
         group by field_trip_id
         order by child_count
      ) a1
   )
) a2
on ft.id = a2.field_trip_id;


insert into tbl_category_a(category_a_name)
values('과일');

select * from tbl_category_a;

insert into tbl_category_b(category_b_name, category_a_id)
values('사과', 1);

select * from tbl_category_b;

insert into tbl_category_c(category_c_name, category_b_id)
values('햇사과', 1);
insert into tbl_category_c(category_c_name, category_b_id)
values('아오리 사과', 1);

select * from tbl_category_c;

insert into tbl_advertisement(advertisement_title, advertisement_content, category_c_id)
values('풍성한 추석보내세요 사과와 함께', '사과중에 으뜸은 햇사과!', 1);

insert into tbl_advertisement(advertisement_title, advertisement_content, category_c_id)
values('아오리 사과와 함께', '아이도 좋아하는 아오리 아오리 좋아!', 2);

create or replace view view_advertisement as
(
   select ad.id, ad.advertisement_title, ad.advertisement_content, a.category_a_name, b.category_b_name, c.category_c_name 
   from tbl_advertisement ad
   inner join tbl_category_c c
   on ad.category_c_id = c.id
   inner join tbl_category_b b
   on c.category_b_id = b.id
   inner join tbl_category_a a
   on b.category_a_id = a.id
);

select * from view_advertisement;

/*기업 정보 추가*/
insert into tbl_company(company_name, company_address, company_phone, company_type)
values('네이버', '서울', '0212341234', 'big');
insert into tbl_company(company_name, company_address, company_phone, company_type)
values('구글', '서울', '0255556666', 'big');
insert into tbl_company(company_name, company_address, company_phone, company_type)
values('동석마트', '서울', '0299998888', 'small');

/*광고 정보 추가*/
insert into tbl_category_a(category_a_name)
values('플랫폼');

select * from tbl_category_a;

insert into tbl_category_b(category_b_name, category_a_id)
values('은행', 2);

insert into tbl_category_b(category_b_name, category_a_id)
values('클라우드', 2);

select * from tbl_category_b;

insert into tbl_category_c(category_c_name, category_b_id)
values('결제', 2);

insert into tbl_category_c(category_c_name, category_b_id)
values('인터넷 뱅킹', 2);

insert into tbl_category_c(category_c_name, category_b_id)
values('개인 서버', 3);

insert into tbl_category_c(category_c_name, category_b_id)
values('이미지 갤러리', 3);

select * from tbl_category_c;


insert into tbl_advertisement(advertisement_title, advertisement_content, category_c_id)
values('결제가 내 손안에', '갑시다 결제 고고', 3);

insert into tbl_advertisement(advertisement_title, advertisement_content, category_c_id)
values('인터넷으로 자유롭게', '자산 관리 합시다.', 4);

insert into tbl_advertisement(advertisement_title, advertisement_content, category_c_id)
values('둥둥 하얀 구름', '너도 이제 대표!', 5);

insert into tbl_advertisement(advertisement_title, advertisement_content, category_c_id)
values('너 128GB 샀어?', '난 32GB사고 512GB 클라우드 샀어!', 6);

select * from view_advertisement;

/*광고 지원 정보 추가*/
insert into tbl_apply(company_id, advertisement_id)
values(3, 1);
insert into tbl_apply(company_id, advertisement_id)
values(3, 2);

insert into tbl_apply(company_id, advertisement_id)
values(1, 3);
insert into tbl_apply(company_id, advertisement_id)
values(1, 5);

insert into tbl_apply(company_id, advertisement_id)
values(2, 3);
insert into tbl_apply(company_id, advertisement_id)
values(2, 4);
insert into tbl_apply(company_id, advertisement_id)
values(2, 5);
insert into tbl_apply(company_id, advertisement_id)
values(2, 5);
insert into tbl_apply(company_id, advertisement_id)
values(2, 6);

select * from tbl_company;
select * from tbl_advertisement;
select * from tbl_apply;

/*기업 중 대기업이 등록한 광고 전체 정보 조회*/

select * from tbl_advertisement;

	select * from tbl_company
	where company_type = 'big';


/*대기업이 신청한 광고 중 대 카테고리 별 신청 개수 조회*/


/*소 카테고리 별 가장 인기 많은 광고 정보 조회*/
/*대 카테고리 중에서 중 카테고리가 2개 이상인 카테고리 이름 조회*/
/*광고를 가장 많이 신청한 기업 정보 조회*/


