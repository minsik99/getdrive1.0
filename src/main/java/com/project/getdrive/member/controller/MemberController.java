package com.project.getdrive.member.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.project.getdrive.member.model.service.MemberService;
import com.project.getdrive.member.model.vo.Member;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//약관페이지
	@RequestMapping(value="mainPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String moveMainPage() {
		return "common/main";
	}
	//약관페이지 이동
	@RequestMapping(value="contractPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String moveContractPage() {
		return "member/contract";
	}
	
	//회원가입페이지 이동
	@RequestMapping(value="registerPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String moveRegisterPage() {
		return "member/register";
	}
	
	/*
	 * //회원가입완료페이지 이동
	 * 
	 * @RequestMapping(value="registerCompletePage.do", method= {RequestMethod.GET,
	 * RequestMethod.POST}) public String moveRegisterCompletePage() { return
	 * "member/registerComplete"; }
	 */
	
	//로그인
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String loginMethod(Member member, HttpSession session, SessionStatus status, Model model) {
		logger.info("login.do : " + member.toString());
		
		//Member loginMember = memberService.login(member);
		
		Member loginMember = memberService.selectMember(member.getEmail());
		
		if(loginMember != null && this.bcryptPasswordEncoder.matches(
				member.getPwd(), loginMember.getPwd())) {
			session.setAttribute("loginMember", loginMember);
			status.setComplete();
			return "redirect:tmain.do"; 
		} else {
			model.addAttribute("message", "로그인 실패! 왜 실패했을까!");
			return "common/error";
		}
	}
	//회원가입 처리
	@RequestMapping(value="register.do", method= {RequestMethod.POST})
	public String register(Member member, Model model) {
		logger.info("register.do : " + member);
		
		//패스워드 암호화
		member.setPwd(bcryptPasswordEncoder.encode(member.getPwd()));
		logger.info("after encode : " + member.getPwd());
		logger.info("pwd length : " + member.getPwd().length());
		
		if(memberService.register(member) > 0) {
			return "member/registerComplete"; 
		}else {
			model.addAttribute("message","입력 정보를 다시한번 확인해주세요.");
			return "commom/error";
			
		}
		
	}
}
