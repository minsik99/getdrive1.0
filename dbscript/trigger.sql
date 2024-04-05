-- 주의사항! 트리거는 한개씩 따로 실행할 것.

-- 2024.03.29 김영활 트리거 파일 생성

--  게시판테이블 등록시 검색테이블에 등록
 CREATE  or replace TRIGGER TRI_INSERT_BD_Search
AFTER INSERT ON TB_Board
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select count(s_no)+1 from tb_search) , 'BD', :NEW.B_Title,  :NEW.B_CONTENT,  :NEW.B_CDATE,  :NEW.B_CRUID,  :NEW.B_NO,  :NEW.B_CTID, :NEW.B_TID);
END;


--  게시판테이블 수정시 검색테이블에 등록
create or replace TRIGGER TRI_update_BD_Search
AFTER update ON TB_Board
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select max(s_no)+1 from tb_search), 'BD', :NEW.B_Title,  :NEW.B_CONTENT,  :NEW.B_UDATE,  :NEW.B_CRUID,  :NEW.B_NO,  :NEW.B_CTID, :NEW.B_TID);
END;

--   드라이브테이블 등록시 검색테이블에 등록
create or replace TRIGGER TRI_INSERT_DV_Search
AFTER INSERT ON TB_Drive_file
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select max(s_no)+1 from tb_search) , 'DV', :NEW.FL_NAME,  :NEW.FL_NAME,  :NEW.FL_CDATE,  :NEW.FL_CRUID,  :NEW.FL_NO, :NEW.FL_DID,  :NEW.FL_TID);
END;


--   드라이브테이블 수정시 검색테이블에 등록
create or replace TRIGGER TRI_update_DV_Search
AFTER INSERT ON TB_Drive_file
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select max(s_no)+1 from tb_search) , 'DV', :NEW.FL_NAME,  :NEW.FL_NAME,  :NEW.FL_UDATE,  :NEW.FL_CRUID,  :NEW.FL_NO, :NEW.FL_DID,  :NEW.FL_TID);
END;
