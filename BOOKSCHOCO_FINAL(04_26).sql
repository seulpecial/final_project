-- BOOK계정 생성하기 : SYSTEM 계정에서 실행할 것들
-- CREATE USER BOOK IDENTIFIED BY BOOK;
-- GRANT RESOURCE, CONNECT TO BOOK;

--------------------------------------------------------------------
-------------------------- DROP(초기화) 관련 -------------------------
--------------------------------------------------------------------

-- 처음 DB 생성 시 F5로 테이블 생성, 이후 DB초기화 할 때는 DROP 부분 주석지우고 F5로 재생성
-- 완전 초기화시에는 테이블에 데이터 없는지 확인하고 초기화 실행하기

--DROP SEQUENCE SEQ_PAY_NO;
--DROP TABLE PAYMENT;
--
--DROP SEQUENCE SEQ_CART_NO;
--DROP TABLE CART;
--
--DROP SEQUENCE SEQ_PROPOSE_NO;
--DROP TABLE PROPOSE;
--
--DROP SEQUENCE SEQ_EXP_NO;
--DROP TABLE EXP;
--
--DROP SEQUENCE SEQ_QA_NO;
--DROP TABLE QA_BOARD;
--
--DROP SEQUENCE SEQ_COM_NO;
--DROP TABLE COMMENT_BOARD;
--
--DROP SEQUENCE SEQ_SCRAP_NO;
--DROP TABLE BOOK_SCRAP;
--
--DROP SEQUENCE SEQ_BR_NO;
--DROP TABLE BOOK_REVIEW_BOARD;
--
--DROP SEQUENCE SEQ_BC_NO;
--DROP TABLE BOOK_CLUB_BOARD;
--
--DROP SEQUENCE SEQ_BF_NO;
--DROP TABLE BOOK_FUNDING_BOARD;
--
--DROP SEQUENCE SEQ_UNO;
--DROP TABLE MEMBER;

COMMIT;
--------------------------------------------------------------------
------------------------- MEMBER 관련 테이블 -------------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_UNO;
--DROP TABLE MEMBER CASCADE CONSTRAINTS;

CREATE TABLE MEMBER (
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(100) NOT NULL,
    USER_NAME VARCHAR2(15) NOT NULL,
    USER_NNAME VARCHAR2(20) NOT NULL UNIQUE,
    USER_ROLE  VARCHAR2(30) DEFAULT 'ROLE_USER',
    USER_PHONE VARCHAR2(15) NOT NULL UNIQUE,
    USER_EMAIL VARCHAR2(40) NOT NULL UNIQUE,
    USER_ADDRESS VARCHAR2(100),
    USER_GENRE VARCHAR2(100),
    USER_AGREEMENT VARCHAR2(3), 
    USER_ENROLL_DATE DATE DEFAULT SYSDATE,
    USER_MODIFY_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N'))
);

CREATE SEQUENCE SEQ_UNO;

COMMENT ON COLUMN MEMBER.USER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.USER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.USER_NNAME IS '회원닉네임';
COMMENT ON COLUMN MEMBER.USER_ROLE IS '회원타입';
COMMENT ON COLUMN MEMBER.USER_PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.USER_EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.USER_ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.USER_GENRE IS '관심장르';
COMMENT ON COLUMN MEMBER.USER_AGREEMENT IS '약관동의';
COMMENT ON COLUMN MEMBER.USER_ENROLL_DATE IS '회원가입일';
COMMENT ON COLUMN MEMBER.USER_MODIFY_DATE IS '정보수정일';
COMMENT ON COLUMN MEMBER.STATUS IS '상태값(Y/N)';

INSERT INTO MEMBER VALUES(
    SEQ_UNO.NEXTVAL, 'admin', '$2a$10$6PmEBefFH/RwMBHD3Zz72OjPlhT/MwdCK77sQwloK5BPkHy9PDAd2', '관리자', '관리자', 'ROLE_ADMIN', '010-1234-5678', 'admin@iei.or.kr', '서울시 강남구 역삼동', NULL, 'Y', SYSDATE, SYSDATE, DEFAULT
);

-- 일반회원은 직접 회원가입 해주세요.

COMMIT;
--------------------------------------------------------------------
------------------------ BF_BOARD 관련 테이블 ------------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_BF_NO;
--DROP TABLE BOOK_FUNDING_BOARD;

CREATE TABLE BOOK_FUNDING_BOARD(
    BF_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    BF_TITLE VARCHAR2(300) NOT NULL,
    BF_PRICE NUMBER NOT NULL,
    BF_ENROLL_DATE DATE DEFAULT SYSDATE,
    BF_END_DATE DATE NOT NULL,
    BF_MODIFY_DATE DATE DEFAULT SYSDATE,
    BF_REMAIN_DATE NUMBER,
    BF_TARGET_PRICE NUMBER NOT NULL,
    BF_REACH_PRICE NUMBER NOT NULL,
    BF_ATTAIN_RATE NUMBER,
    BF_VIEW_COUNT NUMBER DEFAULT 0,
    BF_BUY_COUNT NUMBER DEFAULT 0,
    BF_STATUS VARCHAR2(1) DEFAULT 'N' CHECK (BF_STATUS IN('N', 'P', 'D', 'Q')),
    BF_AGREEMENT VARCHAR2(1) DEFAULT 'N' CHECK (BF_AGREEMENT IN('Y', 'N')),
    BF_LIKE NUMBER DEFAULT 0,
    BF_CONTENT VARCHAR2(4000) NOT NULL,
    BF_ORI_IMGNAME VARCHAR2(100),
    BF_RE_IMGNAME VARCHAR2(100),
    BF_ADMIN_COMMENT VARCHAR2(1000),
    CONSTRAINT FK_USER_NO FOREIGN KEY(USER_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_BF_NO;

COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_NO IS '북펀딩 번호';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.USER_NO IS '회원번호';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_TITLE IS '책 제목';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_PRICE IS '책 가격';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_ENROLL_DATE IS '시작날짜';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_END_DATE IS '종료날짜';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_MODIFY_DATE IS '정보수정날짜';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_REMAIN_DATE IS '남은날짜';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_TARGET_PRICE IS '목표금액';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_REACH_PRICE IS '현재도달금액';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_ATTAIN_RATE IS '달성률';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_VIEW_COUNT IS '조회수';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_BUY_COUNT IS '구입인원수';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_STATUS IS '북펀딩 상태(N,P,D,Q)';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_AGREEMENT IS '북펀딩약관동의상태';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_LIKE IS '좋아요 수';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_CONTENT IS '북펀딩 내용';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_ORI_IMGNAME IS '대표이미지원래이름';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_RE_IMGNAME IS '대표이미지변경이름';
COMMENT ON COLUMN BOOK_FUNDING_BOARD.BF_ADMIN_COMMENT IS '승인거절 코멘트';


--------------------------------------------------------------------
------------------------ BC_BOARD 관련 테이블 ------------------------
--------------------------------------------------------------------
-- $2a$10$EsY8X11Lt7Eeh8/m3BGOGObRoP2GK26sAvp/GAPXF7oLhJEcASzW. 관리자 암호 비밀번호
--SELECT * FROM MEMBER;
--SELECT * FROM BOOK_CLUB_BOARD;

--DROP SEQUENCE SEQ_BC_NO;
--DROP TABLE BOOK_CLUB_BOARD cascade constraints;

-- 테이블 생성
--DROP SEQUENCE SEQ_BC_NO;
--DROP TABLE BOOK_CLUB_BOARD cascade constraints;
CREATE TABLE BOOK_CLUB_BOARD(
    BC_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    BC_ORIGIN_TITLE VARCHAR2(300) NOT NULL,
    BC_SUB_TITLE VARCHAR2(300) NOT NULL,
    BC_PRICE NUMBER DEFAULT 0,
    BC_REG_DATE DATE DEFAULT SYSDATE,
    BC_DETAIL_DATE VARCHAR2(300) NOT NULL,
    BC_START_DATE DATE DEFAULT SYSDATE,
    BC_DL_DATE DATE DEFAULT SYSDATE,
    BC_REMAIN_DATE NUMBER DEFAULT 0,
    BC_VIEW_COUNT NUMBER DEFAULT 0,
    BC_CONTENT VARCHAR2(4000),
    BC_COM_COUNT NUMBER DEFAULT 0,
    BC_ORIGIN_IMAGE VARCHAR2(100),
    BC_MODIFY_IMAGE VARCHAR2(100),
    BC_STATUS VARCHAR2(1) DEFAULT 'N' CHECK (BC_STATUS IN('N', 'P', 'D', 'Q')),
    BC_AGREEMENT VARCHAR2(1) DEFAULT 'N' CHECK (BC_AGREEMENT IN('N', 'Y')),
    CONSTRAINT FK_BC_USER_NO FOREIGN KEY(USER_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_BC_NO;

COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_NO IS '북클럽 번호';
COMMENT ON COLUMN BOOK_CLUB_BOARD.USER_NO IS '회원번호';
COMMENT ON COLUMN BOOK_CLUB_BOARD.USER_ID IS '회원아이디';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_ORIGIN_TITLE IS '북클럽 제목';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_SUB_TITLE IS '북클럽 소제목';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_PRICE IS '북클럽 가격';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_REG_DATE IS '북클럽 등록일정';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_DETAIL_DATE IS '북클럽 시작일정 문자열';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_START_DATE IS '북클럽 시작일정';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_DL_DATE IS '북클럽 마감일정';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_REMAIN_DATE IS '북클럽 남은일수';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_VIEW_COUNT IS '북클럽 조회수';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_CONTENT IS '북클럽 상세내용';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_COM_COUNT IS '북클럽 댓글수';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_ORIGIN_IMAGE IS '북클럽 대표이미지 파일';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_MODIFY_IMAGE IS '북클럽 대표이미지 변경';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_STATUS IS '북클럽 상태(N,P,D,Q)';
COMMENT ON COLUMN BOOK_CLUB_BOARD.BC_AGREEMENT IS '북클럽 약관동의상태(N,Y)';


--------------------------------------------------------------------
------------------------ BR_BOARD 관련 테이블 ------------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_BR_NO;
--DROP TABLE BOOK_REVIEW_BOARD;

CREATE TABLE BOOK_REVIEW_BOARD(
    BR_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    BR_ISBN VARCHAR2(40) NOT NULL, 
    BR_PRESENT_PIC VARCHAR2(100), 
    BR_TITLE VARCHAR2(60) NOT NULL, 
    BR_CREATE_DATE DATE DEFAULT SYSDATE, 
    BR_MODIFY_DATE DATE DEFAULT SYSDATE,
    BR_BOOKTYPE VARCHAR2(2) NOT NULL,
    BR_CONTENT VARCHAR2(4000) NOT NULL,
    BR_VIEWCOUNT NUMBER DEFAULT 0,
    BR_LIKE NUMBER DEFAULT 0,
    BR_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (BR_STATUS IN('Y', 'N')),
    BR_RATING NUMBER DEFAULT 0,
    FOREIGN KEY(USER_NO)REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_BR_NO;

COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_NO IS '북리뷰 글번호';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.USER_NO IS '회원번호';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_ISBN IS '책 ISBN';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_PRESENT_PIC IS '북리뷰 대표사진';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_TITLE IS '북리뷰 제목';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_CREATE_DATE IS '북리뷰 작성날짜';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_MODIFY_DATE IS '북리뷰 수정날짜';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_BOOKTYPE IS '북리뷰 책분류';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_CONTENT IS '북리뷰 내용';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_VIEWCOUNT IS '북리뷰 조회수';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_LIKE IS '북리뷰 추천수';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_STATUS IS '북리뷰 상태(Y,N)';
COMMENT ON COLUMN BOOK_REVIEW_BOARD.BR_RATING IS '북리뷰 책평점';


--------------------------------------------------------------------
------------------- BOOK_SCRAP(스크랩) 관련 테이블 --------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_SCRAP_NO;
--DROP TABLE BOOK_SCRAP;

CREATE TABLE BOOK_SCRAP(
    SCRAP_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    BS_ISBN VARCHAR2(40) NOT NULL,
    SCRAP_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (SCRAP_STATUS IN('Y', 'N')),
    FOREIGN KEY(USER_NO)REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_SCRAP_NO;

COMMENT ON COLUMN BOOK_SCRAP.SCRAP_NO IS '스크랩 번호';
COMMENT ON COLUMN BOOK_SCRAP.USER_NO IS '회원번호';
COMMENT ON COLUMN BOOK_SCRAP.BS_ISBN IS '책 ISBN';
COMMENT ON COLUMN BOOK_SCRAP.SCRAP_STATUS IS '스크랩 상태(Y,N)';


--------------------------------------------------------------------
--------------------- QA_BOARD(Q&A) 관련 테이블 ---------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_QA_NO;
--DROP TABLE QA_BOARD;

CREATE TABLE QA_BOARD(
    QA_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    QA_WRITER VARCHAR2(100),
    QA_ITEM VARCHAR2(300),
    QA_TITLE VARCHAR2(300),
    QA_CONTENT VARCHAR2(1000),
    QA_VIEWCOUNT NUMBER DEFAULT 0,
    QA_ENROLL_DATE DATE DEFAULT SYSDATE,
    QA_MODIFY_DATE DATE,
    QA_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (QA_STATUS IN('N', 'Y')), -- default해서 관리자페이지에서 주는건 시간나면
--    BC_NO NUMBER,
--    BR_NO NUMBER,
--    BF_NO NUMBER,
    CONSTRAINT FK_QA_USER_NO FOREIGN KEY(USER_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL
--    CONSTRAINT FK_QA_BC_NO FOREIGN KEY(BC_NO) REFERENCES BOOK_CLUB_BOARD(BC_NO) ON DELETE SET NULL,
--    CONSTRAINT FK_QA_BR_NO FOREIGN KEY(BR_NO) REFERENCES BOOK_REVIEW_BOARD(BR_NO) ON DELETE SET NULL,
--    CONSTRAINT FK_QA_BF_NO FOREIGN KEY(BF_NO) REFERENCES BOOK_FUNDING_BOARD(BF_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_QA_NO;

COMMENT ON COLUMN QA_BOARD.QA_NO IS 'QA게시글번호';
COMMENT ON COLUMN QA_BOARD.USER_NO IS '회원번호';
COMMENT ON COLUMN QA_BOARD.QA_WRITER IS 'QA게시글 작성자';
COMMENT ON COLUMN QA_BOARD.QA_ITEM IS 'QA게시글 항목(C,R,F)';
COMMENT ON COLUMN QA_BOARD.QA_TITLE IS 'QA게시글 제목';
COMMENT ON COLUMN QA_BOARD.QA_CONTENT IS 'QA게시글 내용';
COMMENT ON COLUMN QA_BOARD.QA_VIEWCOUNT IS 'QA게시글 조회수';
COMMENT ON COLUMN QA_BOARD.QA_ENROLL_DATE IS 'QA게시글 작성날짜';
COMMENT ON COLUMN QA_BOARD.QA_MODIFY_DATE IS 'QA게시글 수정날짜';
COMMENT ON COLUMN QA_BOARD.QA_STATUS IS 'QA게시글 상태(N,Y)';
--COMMENT ON COLUMN QA_BOARD.BC_NO IS '북클럽 번호';
--COMMENT ON COLUMN QA_BOARD.BR_NO IS '북리뷰 글번호';
--COMMENT ON COLUMN QA_BOARD.BF_NO IS '북펀딩 번호';


--------------------------------------------------------------------
------------------- COMMENT_BOARD(댓글) 관련 테이블 ------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_COM_NO;
--DROP TABLE COMMENT_BOARD;

CREATE TABLE COMMENT_BOARD(
    COM_NO NUMBER PRIMARY KEY,
    COM_WRITER VARCHAR2(100),
    COM_CONTENT VARCHAR2(1000),
    COM_CREATE_DATE DATE DEFAULT SYSDATE,
    COM_EDIT_DATE DATE,
    COM_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (COM_STATUS IN('N', 'Y')),
    QA_NO NUMBER,
    PROPOSE_NO NUMBER,
    BR_NO NUMBER,
    BF_NO NUMBER,
    CONSTRAINT FK_COM_QA_NO FOREIGN KEY(QA_NO) REFERENCES QA_BOARD(QA_NO) ON DELETE SET NULL,
    CONSTRAINT FK_COM_PROPOSE_NO FOREIGN KEY(PROPOSE_NO) REFERENCES PROPOSE(PROPOSE_NO) ON DELETE SET NULL,
    CONSTRAINT FK_COM_BR_NO FOREIGN KEY(BR_NO) REFERENCES BOOK_REVIEW_BOARD(BR_NO) ON DELETE SET NULL,
    CONSTRAINT FK_COM_BF_NO FOREIGN KEY(BF_NO) REFERENCES BOOK_FUNDING_BOARD(BF_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_COM_NO;

COMMENT ON COLUMN COMMENT_BOARD.COM_NO IS '댓글 번호';
COMMENT ON COLUMN COMMENT_BOARD.COM_WRITER IS '댓글 작성자';
COMMENT ON COLUMN COMMENT_BOARD.COM_CONTENT IS '댓글 내용';
COMMENT ON COLUMN COMMENT_BOARD.COM_CREATE_DATE IS '댓글 작성날짜';
COMMENT ON COLUMN COMMENT_BOARD.COM_EDIT_DATE IS '댓글 수정날짜';
COMMENT ON COLUMN COMMENT_BOARD.COM_STATUS IS '댓글 삭제여부(N,Y)';
COMMENT ON COLUMN COMMENT_BOARD.QA_NO IS 'QA게시글 번호';
COMMENT ON COLUMN COMMENT_BOARD.PROPOSE_NO IS '제안글 번호';
COMMENT ON COLUMN COMMENT_BOARD.BR_NO IS '북리뷰 글번호';
COMMENT ON COLUMN COMMENT_BOARD.BF_NO IS '북펀딩 번호';


--------------------------------------------------------------------
------------------------ REVIEW 관련 테이블 -------------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_EXP_NO;
--DROP TABLE EXP CASCADE CONSTRAINTS;

CREATE TABLE EXP (
    EXP_NO NUMBER PRIMARY KEY,
    BC_NO NUMBER,
    USER_NO NUMBER NOT NULL,
    USER_NAME VARCHAR2(100),
    EXP_ORIGIN_IMAGE VARCHAR2(200),
    EXP_MODIFY_IMAGE VARCHAR2(200),
    EXP_TITLE VARCHAR2(200),
    EXP_VIEWCOUNT NUMBER DEFAULT 0,
    EXP_CONTENT VARCHAR2(4000),
    EXP_REG_DATE DATE DEFAULT SYSDATE,
    EXP_STATUS CHAR DEFAULT 'Y' CHECK (EXP_STATUS IN('Y', 'N')),
    FOREIGN KEY (BC_NO) REFERENCES BOOK_CLUB_BOARD,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_EXP_NO;

COMMENT ON COLUMN EXP.EXP_NO IS 'EXP 번호';
COMMENT ON COLUMN EXP.BC_NO IS 'BC 번호';
COMMENT ON COLUMN EXP.USER_NO IS 'USER 번호';
COMMENT ON COLUMN EXP.USER_NAME IS 'USER 이름';
COMMENT ON COLUMN EXP.EXP_ORIGIN_IMAGE IS 'EXP 원래 이미지';
COMMENT ON COLUMN EXP.EXP_MODIFY_IMAGE IS 'EXP 수정 이미지';
COMMENT ON COLUMN EXP.EXP_TITLE IS 'EXP 제목';
COMMENT ON COLUMN EXP.EXP_VIEWCOUNT IS '조회수';
COMMENT ON COLUMN EXP.EXP_CONTENT IS 'EXP 내용';
COMMENT ON COLUMN EXP.EXP_REG_DATE IS 'EXP 등록날짜';
COMMENT ON COLUMN EXP.EXP_STATUS IS 'EXP 상태';


--------------------------------------------------------------------
------------------------ BC_LIST 관련 테이블 ------------------------
--------------------------------------------------------------------
-- $2a$10$EsY8X11Lt7Eeh8/m3BGOGObRoP2GK26sAvp/GAPXF7oLhJEcASzW. 관리자 암호 비밀번호
--SELECT * FROM MEMBER;
--SELECT * FROM BOOK_CLUB_BOARD;
--SELECT * FROM PROPOSE;
--DROP SEQUENCE SEQ_PROPOSE_NO;
--DROP TABLE PROPOSE cascade constraints;

-- 테이블 생성, CLUB PROPOSE
CREATE TABLE PROPOSE(
    PROPOSE_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20) NOT NULL,
    PROPOSE_PWD VARCHAR2(20) NOT NULL,
    PROPOSE_TITLE VARCHAR2(300) NOT NULL,
    PROPOSE_REG_DATE DATE DEFAULT SYSDATE,
    PROPOSE_VIEW_COUNT NUMBER DEFAULT 0,
    PROPOSE_CONTENT VARCHAR2(4000),
    PROPOSE_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (PROPOSE_STATUS IN('Y', 'N')),
    CONSTRAINT FK_PROPOSE_USER_NO FOREIGN KEY(USER_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_PROPOSE_NO;

COMMENT ON COLUMN PROPOSE.PROPOSE_NO IS '제안게시글 번호';
COMMENT ON COLUMN PROPOSE.USER_NO IS '회원번호';
COMMENT ON COLUMN PROPOSE.USER_ID IS '회원ID';
COMMENT ON COLUMN PROPOSE.USER_NAME IS '회원 이름';
COMMENT ON COLUMN PROPOSE.PROPOSE_PWD IS '제안게시글 PWD';
COMMENT ON COLUMN PROPOSE.PROPOSE_TITLE IS '제안게시글 제목';
COMMENT ON COLUMN PROPOSE.PROPOSE_REG_DATE IS '제안게시글 등록날짜';
COMMENT ON COLUMN PROPOSE.PROPOSE_VIEW_COUNT IS '제안게시글 조회수';
COMMENT ON COLUMN PROPOSE.PROPOSE_CONTENT IS '제안게시글 상세내용';
COMMENT ON COLUMN PROPOSE.PROPOSE_STATUS IS '제안게시글 상태(Y,N)';


--------------------------------------------------------------------
---------------------- CART(장바구니) 관련 테이블 ---------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_CART_NO;
--DROP TABLE CART;

CREATE TABLE CART(
    CART_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    CART_TITLE VARCHAR2(200),
    CART_AMOUNT NUMBER,
    CART_PRICE NUMBER,
    CART_STATUS VARCHAR2(1) DEFAULT 'N' CHECK (CART_STATUS IN('N', 'Y')),
    CART_ITEM VARCHAR2(1) CHECK(CART_ITEM IN('C', 'F')),
    BC_NO NUMBER,
    BF_NO NUMBER,
    CONSTRAINT FK_CART_USER_NO FOREIGN KEY(USER_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_CART_BC_NO FOREIGN KEY(BC_NO) REFERENCES BOOK_CLUB_BOARD(BC_NO) ON DELETE SET NULL,
    CONSTRAINT FK_CART_BF_NO FOREIGN KEY(BF_NO) REFERENCES BOOK_FUNDING_BOARD(BF_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_CART_NO;

COMMENT ON COLUMN CART.CART_NO IS '장바구니 번호';
COMMENT ON COLUMN CART.USER_NO IS '회원번호';
COMMENT ON COLUMN CART.CART_TITLE IS '장바구니 품목';
COMMENT ON COLUMN CART.CART_AMOUNT IS '장바구니 수량';
COMMENT ON COLUMN CART.CART_PRICE IS '장바구니 가격';
COMMENT ON COLUMN CART.CART_STATUS IS '장바구니 상태(N,Y)';
COMMENT ON COLUMN CART.CART_ITEM IS '장바구니 항목(C,F)';
COMMENT ON COLUMN CART.BC_NO IS '북클럽 번호';
COMMENT ON COLUMN CART.BF_NO IS '북펀딩 번호';


--------------------------------------------------------------------
-------------------- PAYMENT(결제정보) 관련 테이블 --------------------
--------------------------------------------------------------------
--DROP SEQUENCE SEQ_PAY_NO;
--DROP TABLE PAYMENT;

CREATE TABLE PAYMENT(
    PAY_NO NUMBER PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    PAY_ENROLL_DATE DATE DEFAULT SYSDATE,
    PAY_PROGRESS VARCHAR2(1) DEFAULT 'N' CHECK (PAY_PROGRESS IN('N', 'Y')),
    PAY_PRICE NUMBER,
    PAY_STATUS VARCHAR2(1) DEFAULT 'N' CHECK (PAY_STATUS IN('N', 'Y')),
    PAY_ITEM VARCHAR2(1) CHECK(PAY_ITEM IN('C', 'F')),
    BC_NO NUMBER,
    BF_NO NUMBER,
    CONSTRAINT FK_PAYMENT_USER_NO FOREIGN KEY(USER_NO) REFERENCES MEMBER(USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_PAYMENT_BC_NO FOREIGN KEY(BC_NO) REFERENCES BOOK_CLUB_BOARD(BC_NO) ON DELETE SET NULL,
    CONSTRAINT FK_PAYMENT_BF_NO FOREIGN KEY(BF_NO) REFERENCES BOOK_FUNDING_BOARD(BF_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_PAY_NO;

COMMENT ON COLUMN PAYMENT.PAY_NO IS '결제번호';
COMMENT ON COLUMN PAYMENT.USER_NO IS '회원번호';
COMMENT ON COLUMN PAYMENT.PAY_ENROLL_DATE IS '결제날짜';
COMMENT ON COLUMN PAYMENT.PAY_PROGRESS IS '결제진행상태(N,Y)';
COMMENT ON COLUMN PAYMENT.PAY_PRICE IS '결제금액';
COMMENT ON COLUMN PAYMENT.PAY_STATUS IS '결제취소상태(N,Y)';
COMMENT ON COLUMN PAYMENT.PAY_ITEM IS '결제항목(C,F)';
COMMENT ON COLUMN PAYMENT.BC_NO IS '북클럽 번호';
COMMENT ON COLUMN PAYMENT.BF_NO IS '북펀딩 번호';


COMMIT;
