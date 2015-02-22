
/* Drop Triggers */

DROP TRIGGER TRI_bComment_comment_number;
DROP TRIGGER TRI_company_company_code;
DROP TRIGGER TRI_company_person_member_id;
DROP TRIGGER TRI_Reply_reply_number;
DROP TRIGGER TRI_time_table_time_key;



/* Drop Tables */

DROP TABLE Reply CASCADE CONSTRAINTS;
DROP TABLE bComment CASCADE CONSTRAINTS;
DROP TABLE time_table CASCADE CONSTRAINTS;
DROP TABLE company_person CASCADE CONSTRAINTS;
DROP TABLE company CASCADE CONSTRAINTS;
DROP TABLE Users CASCADE CONSTRAINTS;


/* Drop Sequences */

DROP SEQUENCE SEQ_bComment_comment_number;
DROP SEQUENCE SEQ_company_company_code;
DROP SEQUENCE SEQ_company_person_member_id;
DROP SEQUENCE SEQ_Reply_reply_number;
DROP SEQUENCE SEQ_time_table_time_key;




/* Create Sequences */

CREATE SEQUENCE SEQ_bComment_comment_number INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_company_company_code INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_company_person_member_id INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Reply_reply_number INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_time_table_time_key INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE bComment
(
	comment_number number NOT NULL,
	user_id varchar2(20) NOT NULL,
	comment_content varchar2(300) NOT NULL,
	reg_date date DEFAULT sysdate,
	flag number NOT NULL,
	PRIMARY KEY (comment_number)
);


CREATE TABLE company
(
	company_code number NOT NULL,
	company_name varchar2(100) NOT NULL,
	company_tel varchar2(20) NOT NULL,
	holiday_comm number,
	night_comm number,
	PRIMARY KEY (company_code)
);

CREATE TABLE company_person
(
	member_id number NOT NULL,
	company_code number NOT NULL,
	user_id varchar2(20) NOT NULL,
	salary number,
	hire_date varchar2(20) NOT NULL,
	PRIMARY KEY (member_id)
);

CREATE TABLE Reply
(
	reply_number number NOT NULL,
	user_id varchar2(20) NOT NULL,
	comment_number number NOT NULL,
	reply_content varchar2(100) NOT NULL,
	reg_date date DEFAULT sysdate,
	PRIMARY KEY (reply_number)
);


CREATE TABLE time_table
(
	time_key number NOT NULL,
	company_code number NOT NULL,
	member_id number NOT NULL,
	working_date date NOT NULL,
	working_start date NOT NULL,
	working_end date NOT NULL,
	PRIMARY KEY (time_key)
);



CREATE TABLE Users
(
	user_id varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	password2 varchar2(20) NOT NULL,
	user_name varchar2(10) NOT NULL,
	tel varchar2(20),
	email varchar2(30) NOT NULL,
	birth varchar2(10) NOT NULL,
	grade varchar2(10) NOT NULL,
	join_date date DEFAULT sysdate NOT NULL,
	question varchar2(50) NOT NULL,
	answer varchar2(20) NOT NULL,
	PRIMARY KEY (user_id)
);


/* Create Foreign Keys */

ALTER TABLE Reply
	ADD FOREIGN KEY (comment_number)
	REFERENCES bComment (comment_number)
;


ALTER TABLE company_person
	ADD FOREIGN KEY (company_code)
	REFERENCES company (company_code)
;


ALTER TABLE time_table
	ADD FOREIGN KEY (company_code)
	REFERENCES company (company_code)
;


ALTER TABLE time_table
	ADD FOREIGN KEY (member_id)
	REFERENCES company_person (member_id)
;


ALTER TABLE Reply
	ADD FOREIGN KEY (user_id)
	REFERENCES Users (user_id)
;


ALTER TABLE company_person
	ADD FOREIGN KEY (user_id)
	REFERENCES Users (user_id)
;


ALTER TABLE bComment
	ADD FOREIGN KEY (user_id)
	REFERENCES Users (user_id)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_bComment_comment_number BEFORE INSERT ON bComment
FOR EACH ROW
BEGIN
	SELECT SEQ_bComment_comment_number.nextval
	INTO :new.comment_number
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_company_company_code BEFORE INSERT ON company
FOR EACH ROW
BEGIN
	SELECT SEQ_company_company_code.nextval
	INTO :new.company_code
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_company_person_member_id BEFORE INSERT ON company_person
FOR EACH ROW
BEGIN
	SELECT SEQ_company_person_member_id.nextval
	INTO :new.member_id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_Reply_reply_number BEFORE INSERT ON Reply
FOR EACH ROW
BEGIN
	SELECT SEQ_Reply_reply_number.nextval
	INTO :new.reply_number
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_time_table_time_key BEFORE INSERT ON time_table
FOR EACH ROW
BEGIN
	SELECT SEQ_time_table_time_key.nextval
	INTO :new.time_key
	FROM dual;
END;

/

/* Drop Triggers */

DROP TRIGGER TRI_message_message_number;

/* Drop Tables */

DROP TABLE message CASCADE CONSTRAINTS;

/* Drop Sequences */

DROP SEQUENCE SEQ_message_message_number;

/* Create Sequences */

CREATE SEQUENCE SEQ_message_message_number INCREMENT BY 1 START WITH 1;

/* Create Tables */

CREATE TABLE message
(
	message_number number NOT NULL,
	company_code number NOT NULL,
	user_id varchar2(20),
	message_content varchar2(100) NOT NULL,
	reg_date date DEFAULT sysdate,
	flag number DEFAULT 1,
	PRIMARY KEY (message_number)
);
/*컬럼추가*/
ALTER TABLE message
	ADD FOREIGN KEY (user_id)
	REFERENCES Users (user_id)
;

ALTER TABLE message
	ADD FOREIGN KEY (company_code)
	REFERENCES company (company_code)
;


/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_message_message_number BEFORE INSERT ON message
FOR EACH ROW
BEGIN
	SELECT SEQ_message_message_number.nextval
	INTO :new.message_number
	FROM dual;
END;

/


insert into users(user_id, password, password2, user_name, tel, email, birth, grade, question, answer) 
values ('park', '123', '123', '박광욱', '010-', 'p@naver.com', '06/08/1987', '사장', '몇살?', '20살');
insert into users(user_id, password, password2, user_name, tel, email, birth, grade, question, answer) 
values ('Kim', '123', '123', '김연준', '010-', 'k@naver.com', '06/08/1987', '직원', '몇살?', '20살');
insert into users(user_id, password, password2, user_name, tel, email, birth, grade, question, answer) 
values ('Choi', '123', '123', '최정인', '010-', 'c@naver.com', '06/08/1987', '직원', '몇살?', '20살');
insert into users(user_id, password, password2, user_name, tel, email, birth, grade, question, answer) 
values ('Yoo', '123', '123', '유지연', '010-', 'y@naver.com', '06/08/1987', '직원', '몇살?', '20살');


insert into users(user_id, password, password2, user_name, tel, email, birth, grade, question, answer) 
values ('Jung', '123', '123', '정유은', '010-', 'y@naver.com', '06/08/1987', '직원', '몇살?', '20살');
insert into users(user_id, password, password2, user_name, tel, email, birth, grade, question, answer) 
values ('Im', '123', '123', '최서임', '010-', 'y@naver.com', '06/08/1987', '직원', '몇살?', '20살');


insert into Company(company_name, company_tel, holiday_comm, night_comm) 
values ('GS25시', '02-000-0000', 80, 80);

insert into company_person(company_code, user_id, hire_date) 
values(1, 'park', '2010-01-01');
insert into company_person(company_code, user_id, salary, hire_date) 
values (1, 'Kim', 5500, '2015-02-12');
insert into company_person(company_code, user_id, salary, hire_date) 
values (1, 'Choi', 5000, '2015-02-12');
insert into company_person(company_code, user_id, salary, hire_date) 
values (1, 'Yoo', 6000, '2015-02-12');


