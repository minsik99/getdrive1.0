package com.project.getdrive.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import com.project.getdrive.chat.model.vo.Chat;
import com.project.getdrive.chatcontent.model.vo.ChatContent;
import com.project.getdrive.chatuser.model.vo.ChatUser;

public interface ChatService {

	static List<Chat> selectRoomList(int memberNo) {
		return null;
	}

	ArrayList<Chat> selectChatList(String page);
	
}
