package com.project.getdrive;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.project.getdrive.member.model.vo.Member;
import com.project.getdrive.search.model.service.SearchService;
import com.project.getdrive.search.model.vo.Search;
import com.project.getdrive.team.model.service.TeamService;
import com.project.getdrive.team.model.vo.Team;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

	@Autowired
	private TeamService teamService;
	
	@Autowired
	private SearchService searchService;
	
	// index.jsp 에서 main.do 호출
	@RequestMapping("main.do")
	public String forwardMainView(
		HttpServletRequest request) {

		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
    
	// 3. 로그아웃 처리용 메소드
	@RequestMapping(value = "logout.do") 
	public String logoutMethod(
				HttpServletRequest request, 
				Model model) {
	    
		HttpSession session = request.getSession(false);

		// 세션 객체가 있으면 리턴받고, 없으면 null 리턴
		if(session != null) {
			session.invalidate();	

			return "redirect:main.do";		    
		} else {
			model.addAttribute("message", "일정시간 접속을 하지 않아 자동로그아웃 되었습니다.");
			
		    return "common/error";			
		}    

	}		
	
	// 팀 메인으로 이동
	@RequestMapping(value="teammain.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView templateView(
		@RequestParam(name = "tNo", required = true) int teamcode,	
		HttpServletRequest request,
		HttpServletResponse Response,
		HttpSession session,
		ModelAndView mv) {
		
		logger.info("### teammain.do "+ teamcode);
		
		session.setAttribute("tNo", teamcode);
		
		// 2024.04.07 kimyh - 각테이블별 갯수 구하기
		
		mv.addObject("tNo", teamcode);
		mv.setViewName("common/teammain");		
		return mv;		

	}	
	
	// 2024.04.07 kimyh - 팀상단 알람 갯수 및 목록 출력 기능
	@SuppressWarnings("unchecked")	
	@RequestMapping(value="alarmCountList.do", method=RequestMethod.POST)
	@ResponseBody	
	public String alarmCount(
		HttpServletRequest request) throws UnsupportedEncodingException {
				
		// 세션
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		// 신규게시물
		ArrayList<Search> list = searchService.selectAlarmList(loginMember.getAccountNo());
		
		JSONArray jarr = new JSONArray();		
		
		for(Search search : list) {
			JSONObject job = new JSONObject();
			
			job.put("sno", search.getS_id());
			
			//한글 데이터는 반드시 인코딩 처리함			
			job.put("stitle", URLEncoder.encode(search.getS_title(), "utf-8"));
			
			jarr.add(job);
		}		
		
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}
		

	// 2024.04.05 kimyh - 팀공통 왼쪽 메뉴 팀이동 기능
	@SuppressWarnings("unchecked")	
	@RequestMapping(value="teamSelect.do", method=RequestMethod.POST)
	@ResponseBody	
	public String teamSelect(
		HttpServletRequest request) throws UnsupportedEncodingException {
				
		// 2024.04.06 kimyh 팀 목록 쿼리 수정
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		ArrayList<Team> list = teamService.myTeamList(loginMember.getAccountNo());
		
		JSONArray jarr = new JSONArray();		
		
		for(Team team : list) {
			JSONObject job = new JSONObject();
			
			job.put("teamno", team.gettNo());
			
			//한글 데이터는 반드시 인코딩 처리함			
			job.put("teamname", URLEncoder.encode(team.gettName(), "utf-8"));
			
			jarr.add(job);
		}		
		
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}	
	

	// 팀공통 - 왼쪽 메뉴 팀이동 기능 - 객체변경할 것.
	@SuppressWarnings("unchecked")	
	@RequestMapping(value="boardList.do", method=RequestMethod.POST)
	@ResponseBody	
	public String boardList(
			HttpServletRequest request) throws UnsupportedEncodingException {
		// 2024.04.06 kimyh 팀 목록 쿼리 수정
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		ArrayList<Team> list = teamService.myTeamList(loginMember.getAccountNo());
		
		JSONArray jarr = new JSONArray();		
		
		for(Team team : list) {
			JSONObject job = new JSONObject();
			
			job.put("tno", team.gettNo());
			
			//한글 데이터는 반드시 인코딩 처리함			
			job.put("teamname", URLEncoder.encode(team.gettName(), "utf-8"));
			
			jarr.add(job);
		}		
		
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}		

	
	// 팀공통 - 왼쪽 메뉴 팀이동 기능 - 객체변경할 것.
	@SuppressWarnings("unchecked")	
	@RequestMapping(value="chatList.do", method=RequestMethod.POST)
	@ResponseBody	
	public String chatList(
			HttpServletRequest request) throws UnsupportedEncodingException {
		// 2024.04.06 kimyh 팀 목록 쿼리 수정
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		ArrayList<Team> list = teamService.myTeamList(loginMember.getAccountNo());
		
		JSONArray jarr = new JSONArray();		
		
		for(Team team : list) {
			JSONObject job = new JSONObject();
			
			job.put("tno", team.gettNo());
			
			//한글 데이터는 반드시 인코딩 처리함			
			job.put("teamname", URLEncoder.encode(team.gettName(), "utf-8"));
			
			jarr.add(job);
		}		
		
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}		
	
	// 팀공통 - 왼쪽 메뉴 팀이동 기능 - 객체변경할 것.
	@SuppressWarnings("unchecked")	
	@RequestMapping(value="driveList.do", method=RequestMethod.POST)
	@ResponseBody	
	public String driveList(
			HttpServletRequest request) throws UnsupportedEncodingException {
		// 2024.04.06 kimyh 팀 목록 쿼리 수정
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		ArrayList<Team> list = teamService.myTeamList(loginMember.getAccountNo());
		
		JSONArray jarr = new JSONArray();		
		
		for(Team team : list) {
			JSONObject job = new JSONObject();
			
			job.put("tno", team.gettNo());
			
			//한글 데이터는 반드시 인코딩 처리함			
			job.put("teamname", URLEncoder.encode(team.gettName(), "utf-8"));
			
			jarr.add(job);
		}		
		
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}	
}
