-- 2024.03.29 김영활 트리거 파일 생성

CREATE  or replace TRIGGER TRI_INSERT_MT_Search
AFTER INSERT ON TB_MEETING
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_TID )
  VALUES ( (select nvl(max(s_no),0)+1 from tb_search) , 'MT', :NEW.MT_TITLE,  :NEW.MT_CONTENT,  :NEW.MT_DATE,  :NEW.MT_MID, :NEW.MT_ID, :NEW.MT_TID);
END;



create or replace TRIGGER TRI_INSERT_BD_Search
AFTER INSERT ON TB_Board
FOR EACH ROW
BEGIN
  INSERT INTO TB_Search ( S_NO, S_MENU, S_TITLE, S_CONTENT, S_DATE, S_CRUID, S_ID, S_TID )
  VALUES ( (select nvl(max(s_no),0)+1 from tb_search) , 'BD', :NEW.B_Title,  :NEW.B_CONTENT,  :NEW.B_CDATE,  :NEW.B_CRUID,  :NEW.B_NO, :NEW.B_TID);
END;

