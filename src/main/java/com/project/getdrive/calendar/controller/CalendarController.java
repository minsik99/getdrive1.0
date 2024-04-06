package com.project.getdrive.calendar.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.getdrive.calendar.service.CalendarService;
import com.project.getdrive.calendar.vo.Calendar;



//캘린더 전체 출력
@Controller
public class CalendarController {
	//이 컨트롤러 안의 메소드들이 구동되는지, 값이 잘 전달되었는지 확인을 위한 로그 객체를 생성
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	@Autowired
	private CalendarService calendarService;

	@RequestMapping(value = "calendar.do", method = RequestMethod.GET)
	public String calendarMain() {			
		return "calendar/calendar";		
	}
	
	//스케줄 표시
	@SuppressWarnings("unchecked")
	@RequestMapping(value="cllist.do", method=RequestMethod.POST)
	@ResponseBody
	public String scheduleListMethod(
			@RequestParam("year") int year,
			@RequestParam("month") int month,
			HttpServletResponse response) throws UnsupportedEncodingException {
		//ajax 요청시 리턴방법은 여러가지가 있음
		//response 객체 이용시에는 2가지 중 선택 사용하면 됨
		//1. 출력스트림으로 응답하는 방법
		//2. 뷰리졸버로 리턴하는 방법 : response body 에 내보낼 값을 저장함
		//		=> servlet-context.xml 에 설정된 JSONView 클래스가 받아서 내보냄 : 등록 설정 필요함
		
		//두개 이상의 객체를 사용하기 위해 CommonCL 클래스에 합침
	
			
		ArrayList<Calendar> list = calendarService.CalendarList();
		
		//list 를 json 배열에 옮기기
		JSONArray jarr = new JSONArray();
		
		for(Calendar calendar : list) {
	
			JSONObject job = new JSONObject();
			
			job.put("clnum", calendar.getCalendarNo());
			//한글에 대해서는 인코딩해서 json 에 담음 (한글 깨짐 방지)
			job.put("cltitle", URLEncoder.encode(calendar.getCalendarTitle(), "utf-8"));
			
			job.put("cldate", URLEncoder.encode(calendar.getCalendarDate(), "utf-8"));
			
			job.put("clday", calendar.getDay());
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
		//스케줄 등록 상세보기
	@RequestMapping("cldetail.do")
	public String scheduleDetailMethod(
			@RequestParam("clnum") int calendarNo,
			@RequestParam(name="page", required=false) String page, Model model) {

		//조회 처리용
		Calendar calendar = calendarService.scheduleView(calendarNo);
		
		if(calendar != null) {
				model.addAttribute("calendar", calendar);
				
				return "calendar/calendarDetailView";
				
		}else {
				model.addAttribute("message", calendarNo + "번 게시글 상세보기 요청 실패!");
				return "common/error";
		}
	}
		
		//스케줄 등록 페이지 내보내기용
		@RequestMapping("clinsertform.do")
		public String scheduleInsertPage() {
			return "calendar/calendarInsertForm";
		}
		
		
		//스케줄 등록 메소드
		@RequestMapping("clinsert.do")
		public String scheduleInsertMethod(Calendar calendar,
				 Model model) {
			
			if(calendarService.scheduleInsert(calendar) > 0) {
				//게시글 등록 성공시 목록 보기 페이지로 이동
				return "redirect:calendar.do";
				
		}else {
			model.addAttribute("message", "스케줄 등록 실패!");
			return "common/error";	
	    	}    	
		}
		
		//스케줄 삭제 처리용
		@RequestMapping("cldelete.do")
		public String scheduleDeleteMethod(
				@RequestParam("clnum") int calendarNo,
				Model model, 
				HttpServletRequest request) {
			
			if(calendarService.scheduleDelete(calendarNo) > 0) {
				//삭제 성공시 목록 페이지로 이동
				return "redirect:calendar.do";
				
				} else {
				 model.addAttribute("message", calendarNo + "스케줄 삭제 실패! ");
				 return "common/error";
			}	
		}	
			//스케줄 수정페이지 내보내기용
			@RequestMapping("clupview.do")
			public String scheduleUpdatePage(
					@RequestParam("clnum") int calendarNo,
					Model model) {
				
				//수정 페이지에 전달해서 출력할 스케줄 정보 조회함
				Calendar calendar = calendarService.scheduleSelect(calendarNo);
				
				if(calendar != null) {
						model.addAttribute( "calendar" ,calendar);
						
						return "calendar/calendarUpdateView";
				}else {
						model.addAttribute( "message" ,calendarNo + "수정페이지로 이동 실패!");
						return "common/error";
				}
			}
			
		
			//스케줄 수정 처리용
		@RequestMapping(value="clupdate.do", method=RequestMethod.POST)
		   public String scheduleUpdateMethod(
				  Calendar calendar, HttpServletRequest request,
		         	Model model) {
		      
			if(calendarService.scheduleUpdate(calendar) > 0) {
		         //수정 성공시 다시 상세보기가 보여지게 처리
		         model.addAttribute("clnum", calendar.getCalendarNo());
		         
					/* return "calendar/calendarDetailView"; */
		         return "redirect:cldetail.do"; //리다이렉트를 사용하면 주소창이 바뀜
		         
		      } else {
		         model.addAttribute("message", calendar.getCalendarNo() + "스케줄 수정 실패!!!");
		         return "common/error";
		      }
		
		}
		
}
