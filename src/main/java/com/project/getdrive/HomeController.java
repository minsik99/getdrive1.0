package com.project.getdrive;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.getdrive.common.AlarmSch;
import com.project.getdrive.member.model.vo.Member;
import com.project.getdrive.search.model.service.SearchService;
import com.project.getdrive.search.model.vo.Search;
import com.project.getdrive.team.model.service.TeamService;
import com.project.getdrive.team.model.vo.Team;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private TeamService teamService;
	
	@Autowired
	private SearchService searchService;
	
	// index.jsp 에서 main.do 호출
	@RequestMapping("main.do")
	public String forwardMainView(
		HttpServletRequest request) {
		
		return "common/main";
	}
    
	
	// 팀 메인으로 이동
	@RequestMapping(value="teammain.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView templateView(
		@RequestParam(name = "tNo", required = true) int teamcode,	
		HttpServletRequest request,
		HttpServletResponse Response,
		HttpSession session,
		ModelAndView mv) {
				
		Team team = teamService.selectTeam(teamcode);
		
		session.setAttribute("tNo", teamcode);
		
		mv.addObject("team", team);
		mv.addObject("tNo", teamcode);
		mv.setViewName("common/teammain");		
		return mv;		

	}	
	
	// 2024.04.07 kimyh - 팀상단 알람 갯수 및 목록 출력 기능
	@SuppressWarnings("unchecked")	
	@RequestMapping(value="alarmCountList.do", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody	
	public String alarmCount(
			@RequestParam(name = "tNo", required = true) int tNo,
			HttpServletRequest request) throws UnsupportedEncodingException {
		
		logger.info("##### alarmCountList.do ############");
		
		// 세션
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		AlarmSch alarmSch = new AlarmSch();
		alarmSch.setmNo(loginMember.getAccountNo());
		alarmSch.settNo(tNo);		
		
		// 신규게시물
		ArrayList<Search> list = searchService.selectAlarmList(alarmSch);
		
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
