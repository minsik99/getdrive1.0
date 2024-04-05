package com.project.getdrive.chatuser.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.getdrive.chatuser.model.vo.ChatUser;

@Repository("chatUserDao")
public class ChatUserDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	//이름으로 유저 검색
	public ArrayList<ChatUser> selectUserList(String username){
		List<ChatUser> list = sqlSessionTemplate.selectList("chatUserMapper.selectUserList", username);
		return (ArrayList<ChatUser>)list;
	}

}
