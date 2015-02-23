package com.bmj.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bmj.entity.CompanyPerson;
import com.bmj.entity.SaveTime;
import com.bmj.entity.TimeTable;
import com.bmj.entity.Users;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.TimeTableService;
import com.google.gson.Gson;

@Controller
public class hello {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(hello.class);
	}
	
	@Autowired
	CompanyPersonService service2;
	@Autowired
	TimeTableService service;
	
	@RequestMapping(value="/hello", method=RequestMethod.GET)
	public String sayHello(Model model) {
		model.addAttribute("message", "hello MVC ");
		return "showMessage";
	}
	
	@RequestMapping(value="/External")
	public String goExternal() {
		return "calendar/registerTest";
	}
	
	
	private String settingTime(String time) {
		StringBuilder builder = new StringBuilder();
		builder.append(time.substring(0, 10));
		builder.append("T");
		builder.append(time.substring(11, 19));
		return builder.toString();
	}
	
	//@RequestMapping(value="/updateCalendar")
	public String viewCalendar() {
		return "calendar/viewCalendar";
	}
	
	// ajax..... 수정할때 쓰는 ajax! 
	//@RequestMapping(value = "/ajaxs")
	public @ResponseBody String ajaxReceive(Model model) {
		// @ModelAttribute("editDept") Department dept
		// 작성하기 위한 CompanyCode..
		// 작성하기 위한 Id들...회사원들....
		// 날짜와 시작 시간 및 종료 시간....
		// session에 있는 나의 Id....와 회사의 Code를 가져온다!
		// Users user = (Users)session.get... ("addUser");
		// User_id....! get하고, userId로 컴패니 코드를 조회..!
		// 일단 기본 아이디 사장이라 생각하고! Park, 123....!
		//CompanyPerson companyperson = service2.selectCompanyCodeByUserId(UserId);
		CompanyPerson companyperson = service2.selectCompanyPersonByUserId("park");
		logger.trace("수업 : " + companyperson);
		TimeTable timetable = new TimeTable();
		List<TimeTable> lists = null;	// DB에서 Get.!
		List<SaveTime> list2 = new ArrayList<SaveTime>();	// Server에 보내기!
		SaveTime savetime = null;
		// 그리고 우리 회사 코드로 작성된 달력 정보 갖고 오기...!
		lists = service.selectByCompanyCode(companyperson.getCompanyCode());
		
		for (int idx = 0; idx < lists.size(); idx++) {
			logger.trace("수업 idx : " + idx);
			savetime = new SaveTime();
			savetime.setTitle(String.valueOf(lists.get(idx).getMemberId()));
			//savetime.setStart(settingTime(lists.get(idx).getWorkingStart()));
			//savetime.setEnd(settingTime(lists.get(idx).getWorkingEnd()));
			/*if(idx > 6) {
				int length = idx;
				savetime.setColor(color[length%6]);
				
			}else {
				savetime.setColor(color[idx]);
			}*/
			logger.trace("수업 savetime : " + savetime);
			list2.add(idx, savetime);
		}
		logger.trace("수업 lists : " + lists);
		logger.trace("수업 SaveList : " + list2);
		model.addAttribute("Calendar", list2);
		logger.trace("수업 : " + list2);
		JSONObject objJson = new JSONObject();
		JSONArray arrayJson = new JSONArray();
		
		for (int i = 0; i < list2.size(); i++) {
			JSONObject obj = new JSONObject();
			obj.put("title", list2.get(i).getTitle());
			obj.put("start", list2.get(i).getStart());
			obj.put("end", list2.get(i).getEnd());
			obj.put("color", list2.get(i).getColor());
			
			arrayJson.add(obj);
		}
		objJson.put("event", arrayJson);
		
		logger.trace("수업 55 : " + objJson.get("event"));
		/*
		logger.trace(" 수업 555 : " + abj + ", type : " + abj);
		logger.trace(" 수업 555 : " + abj.toJSONString());
		*/
		
		//obj.
		/*for (int i = 0; i < list2.size(); i++) {
			obj.put("title", list2.get(i).getTitle());
			obj.put("start", list2.get(i).getTimeStart());
			obj.put("end", list2.get(i).getTimeEnd());
		}
		logger.trace("수업 " + obj);
		*/
		
		return objJson.toString();
	}
	//@RequestMapping(value="/updateTimeTable")
	public String updateCalendar(@RequestParam String updateStart, @RequestParam String updateEnd) {
		// 수정 시작 시간.
		logger.trace("수업 Start : " + updateStart);
		// 수정 끝난 시간.
		logger.trace("수업 End : " + updateEnd);
		Gson gson = new Gson();
		ArrayList start = new ArrayList();
		ArrayList end = new ArrayList();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		start = gson.fromJson(updateStart, ArrayList.class);
		end = gson.fromJson(updateEnd, ArrayList.class);
		logger.trace("수업 Gson Start : " + start);
		logger.trace("수업 Gson Start : " + end);
		// update할 timeKey를 추출.
		for(int i = 0; i < start.size(); i ++) {
			TimeTable timetable = new TimeTable();
			com.google.gson.internal.LinkedTreeMap map = (com.google.gson.internal.LinkedTreeMap)start.get(i);
			com.google.gson.internal.LinkedTreeMap map2 = (com.google.gson.internal.LinkedTreeMap)end.get(i);
			int memberId = Integer.parseInt(map.get("title").toString());
			String workingStart = map.get("start").toString();
			timetable.setMemberId(memberId);
			//timetable.setWorkingStart(workingStart);
			logger.trace("수업 TimeTable : " + timetable);
			int timeKey = service.selectKeybyTime(timetable);
			logger.trace("수업 ㅠㅠ : " + timeKey);
			// update할 내용 셋팅.
			TimeTable updateTable = new TimeTable();
			//updateTable.setWorkingDate(workingDate);
			try {
				date = formatter.parse(map2.get("start").toString());
			} catch (java.text.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			updateTable.setTimeKey(timeKey);
			updateTable.setMemberId(memberId);
			updateTable.setWorkingDate(date);
			//updateTable.setWorkingStart(map2.get("start").toString());
			//updateTable.setWorkingEnd(map2.get("end").toString());
			logger.trace("수업 Update : " + updateTable);
			service.updateTimeTable(updateTable);
		}
		return "";
	}
	
	//@RequestMapping(value="/addTimeTable", method = RequestMethod.GET)
	public String saveExternal(@RequestParam String list, HttpSession session) {
		logger.trace("수업 : " + list);
		
		JSONParser parser = new JSONParser();
		Object obj = null;
		TimeTable timetable = new TimeTable();
		try {
			obj = parser.parse(list);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.trace("수업 Object : " + obj);
		logger.trace("수업 확인 1 : " + obj.getClass());
		JSONArray arraylist = (JSONArray) obj;
		// arraylist.get(0);
		Date date = new Date();
		Users user = (Users)session.getAttribute("addUser");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//int CompanyCode = service2.selectCompanyPersonCodeByUserId(user.getUserId());

		for (int i = 0; i < arraylist.size(); i++) {

			logger.trace("수업 확인 : " + arraylist.get(i));
			SaveTime st1 = new SaveTime(arraylist.get(i));
			logger.trace("수업 마지막 확인 : " + st1);
			st1.getTitle();			// 직원 아이디...
			st1.getStart();		// 시작 날짜 + 시간
			st1.getEnd();		// 끝난 날짜 + 시간
			try {
				date = formatter.parse(st1.getStart());
			} catch (java.text.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// TimeTable timetb = new TimeTable();
/*			worktable.setMemberId(Integer.parseInt(st1.getTitle()));
			
*/			//st1 0 : eventId, 1 : memberId, 2 : timestart, 3 : timeEnd
			//날짜 분해하는 클래스 호출....!
			//service에서 한번에 해봐....
//			timetable.setCompanyCode(companyCode);
			timetable.setCompanyCode(1);
//			timetable.setMemberId(memberId);
			timetable.setMemberId(1);
			timetable.setWorkingDate(date);
			//timetable.setWorkingStart(st1.getStart());
			//timetable.setWorkingEnd(st1.getEnd());
			logger.trace("수업 111111111 : " + timetable);
			int result = service.insertTimeTable(timetable);
		}
		
		/*while(arraylist.iterator().hasNext()) {
			logger.trace("수업 1 " + arraylist.iterator());
		}*/
		
		return "calendar/register";
	}
	
}
