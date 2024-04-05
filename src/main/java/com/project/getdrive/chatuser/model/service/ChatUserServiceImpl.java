package com.project.getdrive.chatuser.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.getdrive.chatuser.model.dao.ChatUserDao;
import com.project.getdrive.chatuser.model.vo.ChatUser;

@Service("chatUserService")
public class ChatUserServiceImpl implements ChatUserService{
	
	@Autowired
	ChatUserDao chatUserDao;
	
	@Override
	public ArrayList<ChatUser> selectArrayList(String username) {
		return chatUserDao.selectUserList(username);
	}
}
