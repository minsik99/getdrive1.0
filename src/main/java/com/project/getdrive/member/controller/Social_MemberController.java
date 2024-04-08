package com.project.getdrive.member.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.project.getdrive.member.model.service.MemberService;
import com.project.getdrive.member.model.service.Social_MemberService;
import com.project.getdrive.member.model.vo.Member;
import com.project.getdrive.member.model.vo.Social_Member;

@Controller
public class Social_MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(Social_MemberController.class);
	
	@Autowired
	private Social_MemberService social_MemberService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("kakao_register.do")
    public String kakaoRegister(
            @RequestParam("id") String id,
            @RequestParam("nickname") String nickname,
            @RequestParam("email") String email,
            HttpSession session,
            SessionStatus status,
            Model model) {
		System.out.println("실행확인");
		
		Social_Member socialMember = new Social_Member();
        socialMember.setSocial_Id(id);
        socialMember.setSocial_Name(nickname);
        socialMember.setSocial_Email(email);
        socialMember.setSocial_Type("kakao");
        
        Member loginMember = new Member();
        
        loginMember.setName(nickname);
        loginMember.setEmail(email);
        
			
		//1. 회원정보조회 > tb member에 email중복 있는지 확인
        if(social_MemberService.seletEmail(email) > 0) { // 기존 일반 계정이 있을경우
        	
        	social_MemberService.kakaoRegister(socialMember); //소셜 계정 DB로 입력
        	session.setAttribute("loginMember", loginMember); //세션생성
        	status.setComplete();
        }else { // 기존 계정이 없을경우
        	social_MemberService.kakaoNomalRegister(loginMember); //소셜 계정 DB로 입력
        	social_MemberService.kakaoRegister(socialMember); // 일반 계정 DB로 입력
        	session.setAttribute("loginMember", loginMember); //세션생성
        	status.setComplete();
        }
        
    	return "common/main";
    }
	
	
	
	
	/*
	 * @RequestMapping("kakao_login.do") public String
	 * kakaoLoginMethod(HttpServletRequest request, HttpServletResponse response,
	 * Model model) { logger.info("request에 담아서 온 파라메타 이름들:" +
	 * request.getParameterNames()); System.out.println("request에 담아서 온 파라메타 이름들:" +
	 * request.getParameterNames()); logger.info("response에 담아서 온 파라메타 이름들:"
	 * +response.getContentType());
	 * 
	 * return "team/teamMain"; }
	 */
}
