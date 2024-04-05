package com.project.getdrive.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import com.project.getdrive.chat.model.vo.Chat;

public interface ChatService {

	static List<Chat> selectRoomList(int memberNo) {
		return null;
	}

	ArrayList<Chat> selectChatList(String page);
	
}
