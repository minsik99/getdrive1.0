package com.project.getdrive.chatuser.model.service;

import java.util.ArrayList;

import com.project.getdrive.chatuser.model.vo.ChatUser;

public interface ChatUserService {

	ArrayList<ChatUser> selectArrayList(String username);
}
