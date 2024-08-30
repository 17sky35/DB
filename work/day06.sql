SELECT ENAME ,DEPTNO ,
CASE WHEN DEPTNO = 10 THEN 'NEW YORK' 
WHEN DEPTNO = 20 THEN 'DALLAS' 
ELSE 'Unkown' END AS loc_name
FROM EMP
WHERE  JOB = 'MANAGER';

SELECT AVG(SALARY)
FROM EMPLOYEES 
WHERE JOB_ID ='IT_PROG'

SELECT AVG(CASE JOB_ID WHEN'IT_PROG' THEN SALARY END)
FROM EMPLOYEES ;

SELECT ENAME ,SAL,
CASE 
WHEN SAL >=3000 THEN 'HIGH'
WHEN SAL >=1000 THEN 'MID'
ELSE 'LOW' 
END AS GRADE
FROM EMP ;

SELECT STADIUM_NAME ,SEAT_COUNT ,
CASE
	WHEN SEAT_COUNT >50000 THEN 'L'
	WHEN SEAT_COUNT >30000 THEN 'M'
	ELSE 'S'
END AS 크기
FROM STADIUM; 

SELECT STADIUM_NAME ,SEAT_COUNT ,
CASE
	WHEN SEAT_COUNT BETWEEN 0 AND 30000 THEN 'S'
	ELSE CASE WHEN SEAT_COUNT BETWEEN 30001 AND 50000 THEN 'M'
	ELSE 'L'
	END	
END AS 크기
FROM STADIUM; 

SELECT PLAYER_NAME 이름, WEIGHT||'kg' 몸무게,
CASE 
	WHEN WEIGHT IS NULL THEN '미등록'
	WHEN WEIGHT >80 THEN 'H'
	WHEN WEIGHT >70 THEN 'M'
	WHEN WEIGHT >50 THEN 'L'
	ELSE 'H'
END AS 체급
FROM PLAYER;

-- 오라클에서 콘솔로 데이터를 확인하는 법

DBMS_OUTPUT.PUT_LINE('출력할 내용');

-- 변수의 선언
DECLARE
	NAME VARCHAR2(20) := '홍길동';
	AGE NUMBER(3) := 30;
BEGIN
	DBMS_OUTPUT.PUT_LINE('이름 : '||NAME||CHR(10)||'나이 : '||AGE);
END;

-- 점수에 맞는 학점 출력하기
-- 변수
-- SCORE변수에는 80점 대입
-- GRADE
-- 당신의 점수 : XX점
-- 학점 : B
DECLARE
	SCORE NUMBER := 60;
	GRADE VARCHAR2(5);
BEGIN
	IF SCORE >=90 THEN GRADE := 'A';
	ELSIF SCORE >=80 THEN GRADE := 'B';
	ELSIF SCORE >=70 THEN GRADE := 'C';
	ELSIF SCORE >=60 THEN GRADE := 'D';
	ELSE GRADE := 'F';
	END IF;
	DBMS_OUTPUT.PUT_LINE('당신의 점수 : '||SCORE||'점'||CHR(10)||'학점 : '||GRADE);
END;

BEGIN
	FOR I IN  1..4LOOP
		IF MOD(I,2) = 0 THEN
			DBMS_OUTPUT.PUT_LINE(I||'는 짝수!');
		ELSE
			DBMS_OUTPUT.PUT_LINE(I||'는 홀수!');
		END IF;
	END LOOP;
END;

DECLARE
NUM1 NUMBER := 1;
TOTAL NUMBER := 0;
BEGIN
	WHILE(NUM1 <= 10)
	LOOP
		TOTAL := TOTAL+NUM1;
		NUM1 := NUM1 +1;
	END LOOP;
DBMS_OUTPUT.PUT_LINE(TOTAL);
END;

Y = X+3;

CREATE OR REPLACE PROCEDURE F(X NUMBER)
IS
Y NUMBER;
BEGIN
	Y := 2*X+1;
	DBMS_OUTPUT.PUT_LINE('X : '||X||', Y : '|| (2*X+1));
END;

CALL F(3);

SELECT *FROM JOBS ;
-- JOB_ID 
-- JOB_TITLE 
-- MIN_SALARY 
-- MAX_SALARY

CREATE OR REPLACE PROCEDURE MY_NEW_JOB_PROC(
P_JOB_ID IN JOBS.JOB_ID%TYPE,
P_JOB_TITLE IN JOBS.JOB_TITLE %TYPE,
P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
)
IS
CNT NUMBER := 0;
BEGIN 
	-- JOBS 테이블에 매개변수로 받은 JOB_ID가 존재하는지 개수를 세는 쿼리문 작성하기
	-- 쿼리문을 통해 나온 결과를 CNT변수에 대입하겠다.
	SELECT COUNT(JOB_ID) INTO CNT
	FROM JOBS
	WHERE JOB_ID = P_JOB_ID;
	IF CNT != 0 THEN 
		UPDATE JOBS SET 
		JOB_TITLE = P_JOB_TITLE,
		MIN_SALARY = P_MIN_SALARY,
		MAX_SALARY = P_MAX_SALARY
		WHERE JOB_ID = P_JOB_ID;
		DBMS_OUTPUT.PUT_LINE('ALL UPDATE ABOUT'||P_JOB_ID);
	ELSE
		INSERT INTO JOBS VALUES(P_JOB_ID,P_JOB_TITLE,P_MIN_SALARY,P_MAX_SALARY);
		DBMS_OUTPUT.PUT_LINE('ALL DONE ABOUT'||P_JOB_ID);
	END IF;
END;

CALL MY_NEW_JOB_PROC('IT','Developer',14000,20000);

SELECT *FROM JOBS;

CREATE OR REPLACE PROCEDURE DEL_JOB_PROC (
P_JOB_ID IN JOBS.JOB_ID%TYPE
)
IS 
CNT NUMBER := 0;
BEGIN 
	SELECT COUNT(JOB_ID) INTO CNT FROM JOBS 
	WHERE JOB_ID = P_JOB_ID;
	IF CNT != 0 THEN
		DELETE FROM JOBS
		WHERE JOB_ID = P_JOB_ID;
		DBMS_OUTPUT.PUT_LINE(P_JOB_ID||'삭제');
	ELSE 
	DBMS_OUTPUT.PUT_LINE('삭제할 데이터가 없습니다.');
	END IF;
END;

CALL DEL_JOB_PROC('IT');

SELECT * FROM JOBS;


-- 시퀀스
-- 테이블에 값을 추가할 때 자동으로 순차적인 정수값이 들어가도록 설정해주는 객체
CREATE TABLE TBL_USER(
	IDX NUMBER PRIMARY KEY,
	NAME VARCHAR2(50)
);

-- 시퀀스 생성하기
-- CREATE SEQUENCE
CREATE SEQUENCE SEQ_USER;

INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'홍길동');
INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'김길동');
INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'이길동');
INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'박길동');
INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'박길동');
INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'조길동');

SELECT * FROM TBL_USER ;

-- 시퀀스명.CURRVAL
-- 현재 시퀀스 객체에 들어있는 값을 반환
SELECT SEQ_USER.NEXTVAL FROM DUAL;
SELECT SEQ_USER.CURRVAL FROM DUAL;

-- 시퀀스 값 초기화 하는 방법
-- 가장 좋은 방법은 지웠다가 다시 만들기
-- 대부분은 권한이 없기 때문에 삭제할 수 없다.

-- 1. 현재 시퀀스의 값을 확인
-- 2. 현재 시퀀스 값 만큼 INCREMENT를 뺀다.
ALTER SEQUENCE SEQ_USER INCREMENT BY -4;

-- 3. NEXTVAL을 한법 한다.
SELECT SEQ_USER.NEXTVAL FROM DUAL;

-- 4. 증가량을 다시 1로 바꿔 놓는다.
ALTER SEQUENCE SEQ_USER INCREMENT BY 1;

SELECT SEQ_USER.NEXTVAL FROM DUAL;

-- 시퀀스 삭제하기
-- DROP SEQUENCE 시퀀스명;

CREATE TABLE DEPT2(
	DEPTNO NUMBER(3) PRIMARY KEY,
	DNAME VARCHAR2(10),
	LOC VARCHAR2(5)
);

INSERT INTO DEPT2 VALUES(10,'총무부','101');
INSERT INTO DEPT2 VALUES(20,'영업부','202');
INSERT INTO DEPT2 VALUES(30,'전산부','303');
INSERT INTO DEPT2 VALUES(40,'관리부','404');
INSERT INTO DEPT2 VALUES(50,'경리부','505');


SELECT *FROM DEPT2;



















