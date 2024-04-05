package com.project.getdrive.chatuser.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.getdrive.chatuser.model.service.ChatUserService;
import com.project.getdrive.chatuser.model.vo.ChatUser;

@Controller
public class ChatUserController {
	
	@Autowired
	ChatUserService chatUserService;

	//이름으로 유저 검색
		@RequestMapping(value="userlist.do", method=RequestMethod.POST)
		@ResponseBody
		public String chatselectUser(@RequestParam("username") String username, HttpServletResponse response ) throws UnsupportedEncodingException {
			
			//전달받은 키워드로 유저 이름 검색 메소드를 실행하고 결과받기
			ArrayList<ChatUser> list = chatUserService.selectArrayList(username);
			
			//response에 내보낼 값에 대한 mimiTypq 설정
			response.setContentType("application/json; charset=utf-8");
			
			//list를 json 배열로 옮기기
			JSONArray jarr = new JSONArray();
			
			for(ChatUser chatuser : list) {
				//ChatUser 객체 저장용 json 객체 생성
				JSONObject job = new JSONObject();
				
				//한글에 대해서는 인코딩해서 json 에 담음 (한글 깨짐 방지)
				job.put("cu_no", chatuser.getCu_no());
				job.put("cu_name", URLEncoder.encode(chatuser.getCu_name(), "utf-8"));
				
				//job 를 jarr 에 추가
				jarr.add(job);
			}
			
			//전송용 json 객체 준비
			JSONObject sendJson = new JSONObject();
			//전송용 객체에 jarr 을 담음
			sendJson.put("list", jarr);
			
			//전송용 json 을 json string 으로 바꿔서 전송되게 함
			return sendJson.toJSONString();
		}
	
}
