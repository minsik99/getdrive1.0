-- 2024.04.11 김영활 트리거 파일 생성


CREATE  or replace TRIGGER TRI_INSERT_MT_Search
AFTER INSERT ON TB_MEETING
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_TID )
  VALUES ( (select nvl(max(s_no),0)+1 from tb_search) , 'MT', :NEW.MT_TITLE,  :NEW.MT_CONTENT,  
  :NEW.MT_DATE,  :NEW.MT_MID, :NEW.MT_ID, :NEW.MT_TID);
END;


CREATE  or replace TRIGGER TRI_DELETE_MT_Search
AFTER DELETE ON TB_MEETING
FOR EACH ROW
BEGIN
	Delete from TB_Search
	where S_ID = :NEW.MT_ID and S_TID = :NEW.MT_TID and S_MENU = 'MT';
END;


-- 조회수 증가시 적용되어 오류남. (적용대상아님)
create or replace TRIGGER TRI_UPDATE_MT_Search
AFTER UPDATE ON TB_MEETING
FOR EACH ROW
BEGIN
  UPDATE TB_Search 
  set S_TITLE = :NEW.MT_TITLE, S_CONTENT = :NEW.MT_CONTENT, S_DATE = :NEW.MT_UPDATE
  where S_ID = :NEW.MT_ID and S_TID = :NEW.MT_TID  and S_MENU = 'MT' ; 
END;


===============


create or replace TRIGGER TRI_INSERT_BD_Search
AFTER INSERT ON TB_Board
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_TID )
  VALUES ( (select nvl(max(s_no),0)+1 from tb_search) , 'BD', :NEW.B_Title,  :NEW.B_CONTENT,  
  :NEW.B_CDATE,  :NEW.B_CRUID,  :NEW.B_NO, :NEW.B_TID);
END;

CREATE  or replace TRIGGER TRI_DELETE_BD_Search
AFTER DELETE ON TB_Board
FOR EACH ROW
BEGIN
	Delete from TB_Search
	where S_ID = :OLD.B_NO and S_TID = :OLD.B_TID and S_MENU = 'BD';
END;


===============

create or replace TRIGGER TRI_INSERT_CL_Search
AFTER INSERT ON TB_CALENDER
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_TID )
  VALUES ( (select nvl(max(s_no),0)+1 from tb_search) , 'CL', :NEW.CL_TITLE,  :NEW.CL_CONTENT,  
  :NEW.CL_CDATE,  :NEW.CL_CRUID,  :NEW.CL_NO, :NEW.CL_TID);
END;


