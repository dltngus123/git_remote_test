DROP DATABASE IF EXISTS sbs_proj_2023;
CREATE DATABASE sbs_proj_2023;
USE sbs_proj_2023;

CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
  );
  
  INSERT INTO article
  SET regDate = NOW(),
  updateDate = NOW(),
  title ='제목입니다',
  `body` = '내용입니다';
  
  
  
  INSERT INTO article
  SET regDate = NOW(),
  updateDate = NOW(),
  title ='제목1',
  `body` = '내용1';
  INSERT INTO article
  SET regDate = NOW(),
  updateDate = NOW(),
  title ='제목2',
  `body` = '내용2';
  
  #게시물 테이블에 회원정보 추가
  ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER `updateDate`;
  
  #기존 게시물의 작성자를 2번으로 지정
  UPDATE article
  SET memberId = 2;
  WHERE memberid = 0;

  SELECT * FROM article;

  CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(20) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '(3=일반, 7=관리자)',
    loginPw CHAR(60) NOT NULL,
    `name` CHAR(20) NOT NULL,
    `nickname` CHAR(20) NOT NULL,
    cellphoneNo CHAR(20) NOT NULL,
    email CHAR(50) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '(탈퇴여부)',
    delDate DATETIME COMMENT '탈퇴날짜'
  );
  
#테스트 데이터 생성
  INSERT INTO `member`
  SET regDate = NOW(),
  updateDate = NOW(),
  loginId ='admin',
  loginPw = 'admin',
  authLevel = 7,
  `name` = '관리자',
  nickname = '관리자',
  cellphoneNo ='01011111111',
  email = 'admin@gmail.com';
  
   INSERT INTO `member`
  SET regDate = NOW(),
  updateDate = NOW(),
  loginId ='mimi',
  loginPw = 'mimi',
  `name` = '회원',
  nickname = '회원',
  cellphoneNo ='01011111111',
  email = 'admin@gmail.com';
  
  INSERT INTO `member`
  SET regDate = NOW(),
  updateDate = NOW(),
  loginId ='mama',
  loginPw = 'mama',
  `name` = '회원1',
  nickname = '회원1',
  cellphoneNo ='01011111111',
  email = 'admin@gmail.com';
  
  SELECT * FROM MEMBER;
  
  SELECT A.*,
		M.nickname AS extra_writerName
		FROM article AS A
		LEFT JOIN MEMBER AS M
		ON A.memberId = M.id
		ORDER BY A.id DESC
  
  #게시판 테이블 생성
  CREATE TABLE board(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(50) NOT NULL COMMENT 'notice(공지사항), free(자유게시판1), free2(자유게시판2,...',
    `name` CHAR(50) NOT NULL COMMENT '게시판 이름',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부(0=탈퇴전, 1=탈퇴)',
    delDate DATETIME COMMENT '삭제날짜'
  );
  
#테스트 데이터 생성
  INSERT INTO board
  SET regDate = NOW(),
  updateDate = NOW(),
  `code` = 'notice',
  `name` = '공지사항';
  
  INSERT INTO board
  SET regDate = NOW(),
  updateDate = NOW(),
  `code` = 'free1',
  `name` = '자유';
  
  
  SELECT * FROM board;
  
  #게시판 테이블에 boardId 컬럼 추가
  ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER `memberId`;
  
  SELECT * FROM article;
  
  #1,2번 게시물을 공지사항 게시물로 지정
  UPDATE article
  SET boardId = 1
  WHERE id IN(1,2);

#3번 게시물을 자유게시판 게시물로 지정
UPDATE article
  SET boardId = 2
  WHERE id IN(3);
  
  SELECT * FROM `board` WHERE id =1;
   SELECT * FROM board WHERE id=2;
  /*
  #게시물 개수 늘리기
  insert into article
  (regDate, updateDate, memberId, boardId, title, `body`)
  select now(),now(),floor(rand()*2)+1,floor(rand()*2)+1,concat('제목_',rand()),concat('내용_',rand())
  from article;
 */
 SELECT * FROM article;
 
 ALTER TABLE article ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0;
 
 #좋아요 테이블 생성
  CREATE TABLE reactionPoint (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
    relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터번호',
    `point` SMALLINT(2) NOT NULL 
    );
	
	#test data(리액션포인트 테스트 데이터)
	#1번 회원이 1번 article에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 1,
	reltypeCode = 'article',
	relId = 1,
	`point` = -1;
	
	#1번 회원이 2번 article에 좋아요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 1,
	reltypeCode = 'article',
	relId = 2,
	`point` = 1;
	
	#2번 회원이 1번 article에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	reltypeCode = 'article',
	relId = 1,
	`point` = -1;
	
	#2번 회원이 2번 article에 싫어요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	reltypeCode = 'article',
	relId = 2,
	`point` = -1;
	
	#2번 회원이 2번 article에 좋아요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 2,
	reltypeCode = 'article',
	relId = 2,
	`point` = 1;
	
	#3번 회원이 1번 article에 좋아요
	INSERT INTO reactionPoint
	SET regDate = NOW(),
	updateDate = NOW(),
	memberId = 3,
	reltypeCode = 'article',
	relId = 1,
	`point` = 1;
	
	SELECT * FROM reactionPoint;
	
	SELECT A.*,
   IFNULL(SUM(RP.point), 0) AS extra__sumReactionPoint,
   IFNULL(SUM(IF(RP.point &gt; 0, RP.point, 0)), 0) AS extra__goodReactionPoint,
   IFNULL(SUM(IF(RP.point &lt; 0, RP.point, 0)), 0) AS extra__badReactionPoint
   FROM (
        SELECT A.*,
        M.nickname AS extra__writerName
        FROM article AS A
        LEFT JOIN MEMBER AS M
        ON A.memberId = M.id   
   ) AS A
   LEFT JOIN reactionPoint AS RP
   ON RP.relTypeCode = 'article'
   AND A.id = RP.relId
   GROUP BY A.id
	
# 게시물 테이블 goodReactionPoint컬럼추가
ALTER TABLE article
ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 게시물 테이블 badReactionPoint컬럼추가
ALTER TABLE article
ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

SELECT * FROM article;

/*
select RP.relTypeCode,
RP.relId,
sum(IF(RP.point > 0, RP.point, 0)) as goodReactionPoint,
sum(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
from reactionPoint as RP
where relTypeCode ='article'
group by RP.relTypeCode, RP.relId
*/

UPDATE article AS A
INNER JOIN(
    SELECT RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    WHERE relTypeCode ='article'
    GROUP BY RP.relTypeCode, RP.relId
)AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;

SELECT * FROM article;

#댓글테이블 추가
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
    relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터번호',
    `body` TEXT NOT NULL
);

#댓글 테스트 데이터
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`body` = '댓글1';

INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`body` = '댓글2';

INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`body` = '댓글3';

INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글4';

SELECT * FROM reply;

#explain 쿼리문 유효성 검사
EXPLAIN SELECT R.*,
M.nickname AS extra__writerName
FROM reply AS R
LEFT JOIN `member` AS M
ON R.memberId = M.id
WHERE R.relTypeCode = 'article'
AND R.relId = 1

SELECT * FROM reply;

# 댓글  테이블 goodReactionPoint컬럼추가
ALTER TABLE reply
ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 댓글  테이블 badReactionPoint컬럼추가
ALTER TABLE reply
ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

#인덱스 걸기(데이터 찾는?속도가 빨라짐)
ALTER TABLE `reply` ADD INDEX (`relTypeCode`,`relId`);

SELECT * FROM `member`;

#부가 정보 테이블 추가
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(70) NOT NULL,
    `value` TEXT NOT NULL
);

#attr 유니크 인덱스 걸기
##중복변수 생성금지
##변수 찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX(`relTypeCode`,`relId`, `typeCode`, `type2Code`);

##특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX(`relTypeCode`, `typeCode`, `type2Code`);

#attr에 만료 날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;
DESC attr;

SELECT * FROM `attr`;

SELECT * FROM MEMBER;

#로그인비밀번호 컬럼의 길이를 100로 늘림
ALTER TABLE `member` MODIFY COLUMN loginPw VARCHAR(100) NOT NULL;

# 기존 회원의 비밀번호를 암호화 해서 저장
UPDATE `member`
SET loginPw = SHA2(loginPw, 256);

SELECT * FROM `member`;