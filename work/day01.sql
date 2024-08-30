/*
 * CREATR TABLE 테이블명(
 * 컬럼명 타입(길이),
 * 컬럼명 타입(길이),
 * 컬럼명 타입(길이),
 * 컬럼명 타입(길이)
 * );
 * 
 * */

CREATE TABLE TBL_MEMBER(
	NAME VARCHAR2(100) PRIMARY KEY,
	AGE NUMBER
);
--주의점
--컬럼이 여러개일때 콤마(,)잘 써야 함
--사이에 공백 두지 않기
--같은 이름으로는 안만들어짐
CREATE TABLE TBL_CAR(
	ID NUMBER, --차량 식별번호
	BRAND VARCHAR2(100), --브랜드
	COLOR VARCHAR2(100), --색깔
	PRICE NUMBER, --가격
	CONSTRAINT CAR_PK PRIMARY KEY(ID) -- 테이블을 생성하면서 제약조건을 지정
);


--영구삭제이기 때문에 조심해야한다.
DROP TABLE TBL_CAR;
DROP TABLE TBL_MEMBER;

-- 테이블명 : ex2_10

CREATE TABLE ex2_10(
	Col1 VARCHAR2(10) NOT NULL,
	Col2 VARCHAR2(10) NOT NULL,
	Create_date DATE DEFAULT SYSDATE
);

--컬럼명 변경 
ALTER TABLE EX2_10 RENAME COLUMN col1 TO col11;

--컬럼타입 변경
ALTER TABLE ex2_10 MODIFY col2 NUMBER(5);

--컬럼삭제
-- alter table 테이블명 drop column 컬럼명;
ALTER TABLE EX2_10 DROP COLUMN Create_date;

--컬럼추가
--alter table 테이블명 add 컬럼명 컬럼타입;
ALTER TABLE ex2_10 ADD col3 NUMBER;

--제약조건 추가
--테이블이 생성된 후 제약조건을 추가 or 삭제
--alter table 테이블명 add constraint 제약조건명 제약조건종류(컬럼명);
ALTER TABLE EX2_10 ADD CONSTRAINT pk_ex2_10 PRIMARY key(col11);

--제약조건 삭제
--alter table 테이블명 drop constraint 제약조건명;
ALTER TABLE EX2_10 DROP CONSTRAINT pk_ex2_10;

CREATE TABLE TBL_ANIMAL (
	ID NUMBER PRIMARY KEY,
	"TYPE" varchar2(100),
	age number(3),
	feed varchar2(100)
);
--제약조건 삭제
ALTER TABLE TBL_ANIMAL DROP CONSTRAINT SYS_C007007;
--제약조건 추가하기
ALTER TABLE TBL_ANIMAL ADD CONSTRAINT ANIMAL_PK PRIMARY key(id);
--테이블 삭제
DROP TABLE TBL_ANIMAL;

--DEFAULT 과 CHECK제약조건
CREATE TABLE TBL_STUDENT(
	ID NUMBER, --학번
	name varchar2(100), --이름
	major varchar2(100), --전공
	gender char(1) DEFAULT 'W' NOT NULL CONSTRAINT BAN_CHAR CHECK(gender = 'M' OR gender = 'W'),
	birth DATE CONSTRAINT BAN_DATE CHECK(birth >= TO_DATE('1980-01-01','yyyy-mm-dd')),
	CONSTRAINT STD_PK PRIMARY KEY(ID));

DROP TABLE TBL_STUDENT;








