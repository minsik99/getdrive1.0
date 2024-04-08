package com.project.getdrive.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.project.getdrive.mail.MailHandler;
import com.project.getdrive.member.model.service.MemberService;
import com.project.getdrive.member.model.vo.Member;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MailHandler mailHandler;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//메인 이동
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
	
	//계정설정페이지 이동
	@RequestMapping(value="accountSettingPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String moveAccountSetting() {
		return "member/accountSetting";
	}
	
	//비밀번호찾기페이지 이동
	@RequestMapping(value = "getPasswordFindPage.do", method = RequestMethod.GET)
	public String getPasswordFindPage() {
	    return "member/passwordFind";
	}
	
	
	/* 보내는사람, 받는사람, 제목, 내용 */
	public void mailSend(String from, String to, String title, String contents) {
		//mailHandler.sendEmail("classgetdrive@gmail.com", "junstin119@gmail.com", "제목테스트", "내용테스트");
		mailHandler.sendEmail(from, to, title, contents);
	}

	
	
	//비밀번호 찾기
	@RequestMapping(value="passwordFind.do", method=RequestMethod.POST)
	public void passwordFind(@RequestParam("email")String email,Member member, Model model) {
		
		mailSend("classgetdrive@gmail.com", email, "제목테스트", "내용테스트");
		
		
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
		
		Member loginMember = memberService.selectMember(member.getEmail());
		
		if(loginMember != null && this.bcryptPasswordEncoder.matches(
				member.getPwd(), loginMember.getPwd())) {
			
			session.setAttribute("loginMember", loginMember);
			status.setComplete();
			return "common/main"; 
		} else {
			model.addAttribute("message", "이메일 또는 비밀번호를 다시 확인하세요.");
			return "common/main";
		}
		
	}
	//로그아웃
	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		//세션 객체가 있으면 리턴받고, 없으면 null 리턴
		if(session != null) {
			session.invalidate();
			return "common/main";
		}else {
			model.addAttribute("message", "로그인 세션이 존재하지 않습니다.");
			return "common/error";
		}
	}
	
	//회원가입 처리
	@RequestMapping(value="register.do", method= {RequestMethod.POST})
	public String register(Member member, Model model) {
		logger.info("register.do : " + member);
		
		if(memberService.register(member) > 0) {
			return "member/registerComplete"; 
		}else {
			model.addAttribute("message","입력 정보를 다시한번 확인해주세요.");
			return "commom/error";
			
		}
		
	}
	
	//로그인시 아이디 비밀번호 일치여부 확인
	@RequestMapping(value="accountchk.do", method=RequestMethod.POST)
	public void accountCheck(@RequestParam("email") String email, @RequestParam("pwd") String password, HttpServletResponse response) throws IOException {
	    Member member = new Member();
	    member.setEmail(email);
	    member.setPwd(password);

	    boolean AccountValid = memberService.accountCheck(member);

	    String returnStr = AccountValid ? "ok" : "dup";
	    response.setContentType("text/html; charset=utf-8");
	    PrintWriter out = response.getWriter();
	    out.append(returnStr);
	    out.flush();
	    out.close();
	}
	
	//이메일 중복확인처리용
	@RequestMapping(value="idchk.do", method=RequestMethod.POST)
	public void dupCheckEmailMethod(@RequestParam("email") String email, 
			HttpServletResponse response) throws IOException {
		//메소드 매개변수 영역에서 사용하는 어노테이션 중에
		//@RequestParam("전송온이름")  자료형 값저장변수명
		//자료형 값저장변수명 = request.getParameter("전송온이름");  코드와 같음
		
		int idCount = memberService.selectCheckEmail(email);
		
		
		String returnStr = null;
		if(idCount == 0) {
			returnStr = "ok";	
		}else {
			returnStr = "dup";
		}
		
		//response 를 이용해서 클라이언트와 출력스트림을 열어서 문자열값 내보냄
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnStr);
		out.flush();
		out.close();
		
	}
	
	//비밀번호 일치확인처리용
	@RequestMapping(value="pwdchk2.do",  method= {RequestMethod.GET, RequestMethod.POST})
	public void dupCheckPwd(@RequestParam("pwd") String pwd, 
	                        HttpSession session, HttpServletResponse response) throws IOException {

	    Member loginMember = (Member) session.getAttribute("loginMember");
	    
	    // 현재 로그인된 사용자의 암호화된 비밀번호를 가져옵니다.
	    String encryptedPwd = loginMember.getPwd();
	    
	    System.out.println(encryptedPwd);

	    // 입력된 비밀번호를 bcryptPasswordEncoder를 사용하여 암호화합니다.
	    String encodedPwd = bcryptPasswordEncoder.encode(pwd);

	    // 암호화된 비밀번호와 입력된 비밀번호를 비교합니다.
	    if (loginMember != null && bcryptPasswordEncoder.matches(pwd, encryptedPwd)) {
	        // 비밀번호가 일치하는 경우
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();
	        out.append("ok");
	        out.flush();
	        out.close();
	    } else {
	        // 비밀번호가 일치하지 않는 경우
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();
	        out.append("dup");
	        out.flush();
	        out.close();
	    }
	}
	
}
