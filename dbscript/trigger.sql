-- 2024.03.29 김영활 트리거 파일 생성

 CREATE  or replace TRIGGER TRI_INSERT_MT_Search
AFTER INSERT ON MEETING
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select nvl(max(s_no),0)+1 from tb_search) , 'MT', :NEW.MEETING_TITLE,  :NEW.MEETING_CONTENT,  :NEW.MEETING_DATE,  1, 1, 1, :NEW.M_TID);
END;


create or replace TRIGGER TRI_INSERT_BD_Search
AFTER INSERT ON TB_Board
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select nvl(max(s_no),0)+1 from tb_search) , 'BD', :NEW.B_Title,  :NEW.B_CONTENT,  :NEW.B_CDATE,  :NEW.B_CRUID,  :NEW.B_NO,  :NEW.B_CTID, :NEW.B_TID);
END;


--  게시판테이블 수정시 검색테이블에 등록
create or replace TRIGGER TRI_update_BD_Search
AFTER update ON TB_Board
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select max(s_no)+1 from tb_search), 'BD', :NEW.B_Title,  :NEW.B_CONTENT,  :NEW.B_UDATE,  :NEW.B_CRUID,  :NEW.B_NO,  :NEW.B_CTID, :NEW.B_TID);
END;


--   미팅테이블 등록시 검색테이블에 등록
create or replace TRIGGER TRI_INSERT_MT_Search
AFTER INSERT ON MEETING
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select NVL(max(s_no), 0) + 1 from tb_search ) , 'MT', :NEW.FL_NAME,  :NEW.FL_NAME,  :NEW.FL_CDATE,  :NEW.FL_CRUID,  :NEW.FL_NO, :NEW.FL_DID,  :NEW.FL_TID);
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
AFTER update ON TB_Drive_file
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_CTID, S_TID )
  VALUES ( (select max(s_no)+1 from tb_search) , 'DV', :NEW.FL_NAME,  :NEW.FL_NAME,  :NEW.FL_UDATE,  :NEW.FL_CRUID,  :NEW.FL_NO, :NEW.FL_DID,  :NEW.FL_TID);
END;
