package com.project.getdrive;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.getdrive.team.model.service.TeamService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private TeamService teamService;
	
	// index.jsp 에서 main.do 호출
	@RequestMapping("main.do")
	public String forwardMainView(
		HttpServletRequest request) {
		
		// 세션객체
		HttpSession session = request.getSession(false);
		
		logger.info("### main.do : "+ session);
		
		return "common/main";		

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
		
		mv.addObject("teamcode", teamcode);
		mv.setViewName("common/teammain");		
		return mv;		

	}	
	
	/*	
	// 팀공통 - 왼쪽 메뉴 팀이동 기능 - 객체변경할 것.
	@SuppressWarnings("unchecked")	
	@RequestMapping(value="teamSelect.do", method=RequestMethod.POST)
	@ResponseBody	
	public String teamSelect(
		@RequestParam(name = "tno", required = true) int teamcode) throws UnsupportedEncodingException {
		
		
		ArrayList<Team> list = teamService.teamSelect(teamcode);
		
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
	@RequestMapping(value="boardList.do", method=RequestMethod.POST)
	@ResponseBody	
	public String boardList() throws UnsupportedEncodingException {
		ArrayList<Search> list = searchService.teamSelect();
		
		JSONArray jarr = new JSONArray();		
		
		for(Search search : list) {
			JSONObject job = new JSONObject();
			
			job.put("no", search.getS_no());
			
			//한글 데이터는 반드시 인코딩 처리함			
			job.put("title", URLEncoder.encode(search.getS_title(), "utf-8"));
			
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
	public String chatList() throws UnsupportedEncodingException {
		ArrayList<Search> list = searchService.teamSelect();
		
		JSONArray jarr = new JSONArray();		
		
		for(Search search : list) {
			JSONObject job = new JSONObject();
			
			job.put("no", search.getS_no());
			
			//한글 데이터는 반드시 인코딩 처리함			
			job.put("title", URLEncoder.encode(search.getS_title(), "utf-8"));
			
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
	public String driveList() throws UnsupportedEncodingException {
		ArrayList<Search> list = searchService.teamSelect();
		
		JSONArray jarr = new JSONArray();		
		
		for(Search search : list) {
			JSONObject job = new JSONObject();
			
			job.put("no", search.getS_no());
			
			//한글 데이터는 반드시 인코딩 처리함			
			job.put("title", URLEncoder.encode(search.getS_title(), "utf-8"));
			
			jarr.add(job);
		}		
		
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}	
	*/
}
