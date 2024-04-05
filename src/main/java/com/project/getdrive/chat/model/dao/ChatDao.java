package com.project.getdrive.chat.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.getdrive.chat.model.vo.Chat;
import com.project.getdrive.chatuser.model.vo.ChatUser;

@Repository("chatDao")
public class ChatDao {
	//마이바티스 매퍼파일에 쿼리문 별도로 작성
	//root-context.xml 에 저장된 마이바티스 연결 객체를 사용해서, 매퍼의 쿼리문을 사용 실행 처리
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//이름으로 유저 검색
	public ArrayList<ChatUser> selectUserList(String username){
		List<ChatUser> list = sqlSessionTemplate.selectList("chatMapper.selectUserList", username);
		return (ArrayList<ChatUser>)list;
	}

	public ArrayList<Chat> selectChatList(String page) {
		List<Chat> list = sqlSessionTemplate.selectList("chatMapper.selectChatList", page);
		return (ArrayList<Chat>)list;
	}
	
}
