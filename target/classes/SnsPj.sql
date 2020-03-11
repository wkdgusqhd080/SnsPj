/*create user sns identified by java;
grant resource, connect to sns;
conn sns/java;
*/


delete from BOARD_LIKE;
delete from BOARD_REPLY;
delete from BOARD_FILE;
delete from BOARD;
delete from FOLLOW;
delete from MAIL_AUTH;
delete from MEMBER;

drop table BOARD_LIKE;
drop table BOARD_REPLY;
drop table BOARD_FILE;
drop table BOARD;
drop table FOLLOW;
drop table MAIL_AUTH;
drop table MEMBER;

drop sequence BOARD_FILE_SEQ;
drop sequence BOARD_SEQ;
drop sequence BOARD_REPLY_SEQ;

create table MEMBER(
MEM_EMAIL varchar2(100) constraint MEMBER_PK primary key,
MEM_PWD varchar2(100),
MEM_RDATE date,
MEM_PROFILE varchar2(1000),
MEM_STATE number
);

insert into MEMBER values('a@naver.com', '1234', SYSDATE, 'a프로필.jpg', 1);
insert into MEMBER values('b@naver.com', '1234', SYSDATE, 'b프로필.jpg', 1);
insert into MEMBER values('c@naver.com', '1234', SYSDATE, 'c프로필.jpg', 1);
insert into MEMBER values('d@naver.com', '1234', SYSDATE, 'd프로필.jpg', 1);

insert into MEMBER values('e@naver.com', '1234', SYSDATE, 'defaultProfile.jpg', 0);
insert into MEMBER values('f@naver.com', '1234', SYSDATE, 'defaultProfile.jpg', 0);
insert into MEMBER values('g@naver.com', '1234', SYSDATE, 'defaultProfile.jpg', 0);
insert into MEMBER values('h@naver.com', '1234', SYSDATE, 'defaultProfile.jpg', 0);

commit;
select * from member;

create table MAIL_AUTH(
MEM_EMAIL varchar2(100) constraint MAIL_AUTH_PK primary key,
MAIL_AUTHKEY varchar2(100)
);

create table FOLLOW(
FLR_EMAIL varchar2(100),
MEM_EMAIL varchar2(100) constraint FOLLOWER_FK references MEMBER(MEM_EMAIL) on delete cascade
);

insert into FOLLOW values('b@naver.com', 'a@naver.com');
insert into FOLLOW values('c@naver.com', 'a@naver.com');
insert into FOLLOW values('d@naver.com', 'a@naver.com');
commit;
select * from FOLLOW;

create table BOARD(
B_SEQ number constraint BOARD_PK primary key,
B_CONTENT varchar2(3000),
MEM_EMAIL varchar2(100) constraint BOARD_FK references MEMBER(MEM_EMAIL) on delete cascade,
B_RDATE date
);
create sequence BOARD_SEQ minvalue 0 start with 1 increment by 1 nocache;

insert into BOARD values(1, '오늘 하루는 어떨까?', 'b@naver.com', '2020-01-27');
insert into BOARD values(2, '날씨가 좋다.', 'b@naver.com', '2020-02-28');

insert into BOARD values(3, '배가 고프다.', 'c@naver.com', '2020-01-25');
insert into BOARD values(4, '하품이 나온다.', 'c@naver.com', '2020-02-26');
insert into BOARD values(5, '오늘은 즐거운날이에요.', 'b@naver.com', '2020-03-02');


commit;
select * from BOARD order by B_RDATE desc;


--select B_SEQ, B_CONTENT, MEM_EMAIL, B_RDATE from (select ROWNUM rnum, aa.* from (select * from BOARD where MEM_EMAIL = 'a@naver.com' order by B_RDATE desc) aa) where rnum > 0 and rnum <= 3;
--select flr_email from follow where mem_email = 'a@naver.com';
--select ROWNUM rnum, b.* from BOARD b where mem_email in (select flr_email from follow where mem_email = 'a@naver.com') order by b_rdate desc;
select * from (select ROWNUM rnum, board.* from (select * from board order by b_rdate desc) board) where rnum > 0 and rnum <= 3 and mem_email in (select flr_email from follow where mem_email = 'a@naver.com') order by b_rdate desc;


create table BOARD_FILE(
BF_SEQ number constraint BOARD_FILE_PK primary key,
BF_OFNAME varchar2(300),
BF_FNAME varchar2(300),
BF_SIZE number,
B_SEQ number constraint BOARD_FILE_FK references BOARD(B_SEQ) on delete cascade
);
create sequence BOARD_FILE_SEQ minvalue 0 start with 1 increment by 1 nocache;

insert into BOARD_FILE values(1, '파일1.jpg', '파일1.jpg', 1000, 5);
insert into BOARD_FILE values(2, '파일2,jpg', '파일2.jpg', 1000, 5);
insert into BOARD_FILE values(3, '파일3,jpg', '파일3.jpg', 1000, 5);

insert into BOARD_FILE values(4, '파일4.jpg', '파일4.jpg', 1000, 2);
insert into BOARD_FILE values(5, '파일5,jpg', '파일5.jpg', 1000, 2);
insert into BOARD_FILE values(6, '파일6,jpg', '파일6.jpg', 1000, 2);

insert into BOARD_FILE values(7, '파일7.jpg', '파일7.jpg', 1000, 1);
insert into BOARD_FILE values(8, '파일8,jpg', '파일8.jpg', 1000, 1);
insert into BOARD_FILE values(9, '파일9,jpg', '파일9.jpg', 1000, 1);

insert into BOARD_FILE values(10, '파일10.jpg', '파일10.jpg', 1000, 2);


commit;

select * from BOARD_FILE;

create table BOARD_LIKE(
MEM_EMAIL varchar2(100) constraint BOARD_LIKE_FK1 references MEMBER(MEM_EMAIL) on delete cascade,
B_SEQ number constraint BOARD_LIKE_FK2 references BOARD(B_SEQ) on delete cascade,
constraint BOARD_LIKE_PK primary key (MEM_EMAIL, B_SEQ)
);


insert into BOARD_LIKE values('a@naver.com', 5);
insert into BOARD_LIKE values('c@naver.com', 5);
insert into BOARD_LIKE values('d@naver.com', 5);

insert into BOARD_LIKE values('a@naver.com', 2);

select * from board_like where mem_email = 'a@naver.com' and b_seq = 5;

create table BOARD_REPLY(
BRP_SEQ number constraint REPLY_PK primary key,
BRP_CONTENT varchar2(3000),
BRP_RDATE date,
MEM_EMAIL varchar2(100) constraint REPLY_FK1 references MEMBER(MEM_EMAIL) on delete cascade,
B_SEQ number constraint REPLY_FK2 references BOARD(B_SEQ) on delete cascade
);
create sequence BOARD_REPLY_SEQ minvalue 0 start with 1 increment by 1 nocache;

insert into BOARD_REPLY values(1, '댓글1', '2020-01-25', 'c@naver.com', 1);
insert into BOARD_REPLY values(2, '댓글2', '2020-01-26', 'c@naver.com', 1);
insert into BOARD_REPLY values(3, '댓글3', '2020-01-27', 'c@naver.com', 1);

insert into BOARD_REPLY values(4, '댓글4', '2020-01-25', 'a@naver.com', 2);
insert into BOARD_REPLY values(5, '댓글5', '2020-01-26', 'a@naver.com', 2);
insert into BOARD_REPLY values(6, '댓글6', '2020-01-27', 'a@naver.com', 2);

commit;

select * from (select ROWNUM rnum, br.* from (select * from BOARD_REPLY where B_SEQ = 1) br) where rnum > 0 and rnum <= 3 order by BRP_RDATE desc;

