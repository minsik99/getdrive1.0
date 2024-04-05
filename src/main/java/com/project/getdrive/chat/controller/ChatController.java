package com.project.getdrive.chat.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.project.getdrive.chat.model.service.ChatService;
import com.project.getdrive.chat.model.vo.Chat;

@SessionAttributes({"loginMember"})
@Controller
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	@RequestMapping("chatcreate.do")
	public String forwardChatCreate() {
		return "chat/chatCreate";
	}
	
	@RequestMapping("chatcreateinfo.do")
	public String forwardChatCreateInfo() {
		return "chat/chatCreateInfo";
	}
	
	@RequestMapping("chatmain.do")
	public String forwardChatMain() {
		return "chat/chatMain";
	}
	
	@RequestMapping("chatuser.do")
	public String forwardChatUser() {
		return "chat/chatUser";
	}
	
	@RequestMapping("chatreply.do")
	public String forwardChatReply() {
		return "chat/chatReply";
	}
	
	//채팅 전체 목록보기 요청 처리용
	@RequestMapping("chatlist.do")
    public String chatListMethod(
    		@RequestParam(name="page", required=false) String page, 
			@RequestParam(name="limit", required=false) String slimit, 
			Model model) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}
		
		//페이지에 출력할 목록 조회해 옴
		ArrayList<Chat> list = chatService.selectChatList(page);
		
		if(list != null && list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("currentPage", currentPage);
			
			return "chat/chatMain";
		}else {
			model.addAttribute("message", currentPage + "페이지 목록 조회 실패!");
			return "common/error";
		}
	}
  /*  		
    		@SessionAttribute("loginMember") ChatUser loginMember, Model model) {
        
        // 현재 개설되어 있는 채팅방 목록 불러오기
        List<Chat> roomList = ChatService.selectRoomList(loginMember.getMemberNo());
        model.addAttribute("roomList", roomList);
        
        return "chat/chat";
    }*/
		
	
	
	
	
}
