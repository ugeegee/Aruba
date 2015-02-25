package com.bmj.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

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
import com.bmj.exception.ScheduleMenuFailException;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.TimeTableService;
import com.google.gson.Gson; 
@Controller
public class TimeTableController {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(TimeTableController.class);
	}
	
	/*private String[] color = {"#000000", "#ff0000", "#00ff00", "#0000ff", "#ffff00", "#00ffff", "#ff00ff"};*/
	private String[] color = {"#980000", "#993800", "#997000", "#998A00", "#6B9900", "#2F9D27", "#008299", "#003399", "#050099", "#3F0099", "#990085", "#99004C", "#4C4C4C", "#353535"};
		
	@Autowired
	CompanyPersonService service2;
	@Autowired
	TimeTableService service;
	
	@RequestMapping(value = "/checkdeleteTime", method = RequestMethod.GET)
	public String checkdeleteTime(Model model) {
		//model.addAttribute("result", "First");
		return "/schedule/employer/checkdeleteTime";
	}
	
	@RequestMapping(value = "/deleteTimeTable", method = RequestMethod.GET)
	public String deleteTheShow(HttpSession session, Model model) {
		logger.trace("수업 인데.................?");
		
		Users loginUser = (Users) session.getAttribute("addUser");
		CompanyPerson companyperson = service2.selectCompanyPersonByUserId(loginUser.getUserId());
		int companyCode = companyperson.getCompanyCode();
		service.deleteTimeTableByCompanyCode(companyCode);
		try{
			model.addAttribute("code", companyperson.getCompanyCode());
		}catch(NullPointerException e){
			throw new ScheduleMenuFailException("!!사장이 등록한 회사가 없음!!");
		}	
		
		return "/schedule/employer/allSchedule";
	}
	
	/*스케쥴 추가하기.....!*/
	@RequestMapping(value="/addTimeTable", method = RequestMethod.GET)
	public String saveExternal(@RequestParam String list, HttpSession session) {
		logger.trace("수업 : " + list);
		Gson gson = new Gson();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		ArrayList templ = new ArrayList();
		// ArrayList에 gson으로 List 저장.
		templ = gson.fromJson(list, ArrayList.class);
		Date date = new Date();
		Date start = new Date();
		Date end = new Date();
		TimeTable timetable = new TimeTable();
		Users user = (Users)session.getAttribute("addUser");
		logger.trace("수업 : User " + user);
		
		CompanyPerson companyperson = service2.selectCompanyPersonByUserId(user.getUserId());
		int companyCode = companyperson.getCompanyCode();
		
		logger.trace("Gson : " + templ);
		for(int i = 0; i < templ.size(); i++) {
			com.google.gson.internal.LinkedTreeMap map = (com.google.gson.internal.LinkedTreeMap)templ.get(i);
			logger.trace("수업 Map : " + map);
			logger.trace("수업 확인 Id : " +map.get("title"));
			
			CompanyPerson tempPerson = new CompanyPerson();
			tempPerson.setUserId(map.get("title").toString());
			tempPerson.setCompanyCode(companyCode);
			int memberId = service2.selectMemberIdbyCompanyPerson(tempPerson);
			logger.trace("수업 멤버 ID " + memberId);
			//int memberId = service2.selectMemberIdbyUserId(map.get("title").toString());

			
			// 일한일자 저장. Date 타입으로 변환.
			try {
				date = formatter.parse(map.get("start").toString());
				start = formatter.parse(map.get("start").toString());
				end = formatter.parse(map.get("end").toString());
			} catch (java.text.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			logger.trace("수업 확인 Data : " + date);
			logger.trace("수업 확인 Start : " + map.get("start"));
			logger.trace("수업 확인 End : " + map.get("end"));
			timetable.setCompanyCode(companyCode);
			timetable.setMemberId(memberId);
			timetable.setWorkingDate(date);
			timetable.setWorkingStart(start);
			timetable.setWorkingEnd(end);
			logger.trace("수업 111111111 : " + timetable);
		
			int result = service.insertTimeTable(timetable);
		}
		return "redirect:/allSchedule";
		//return "schedule/employer/allSchedule";
	}
	
	/*모든 스케쥴 조회하기*/
	@RequestMapping(value="/viewCalendar")
	public String viewCalendar() {
		return "calendar/viewCalendar";
	}
	
	private String settingTime(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		StringBuilder builder = new StringBuilder();
		
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH)+1;
		int day = c.get(Calendar.DATE);
		int hour = c.get(Calendar.HOUR_OF_DAY);
		int minute = c.get(Calendar.MINUTE);
		int second = c.get(Calendar.SECOND);
		logger.trace("수업 시간 : " + hour);
		
		builder.append(year);
		builder.append("-");
		if(month < 10) {
			builder.append("0" + month);			
		} else if (month > 9) {
			builder.append(month);			
		}
		builder.append("-");
		if(day < 10) {
			builder.append("0" + day);
		} else {
			builder.append(day);
		}
		builder.append("T");
		if(hour < 10) {
			builder.append("0" + hour + ":");
		} else {
			builder.append(hour + ":");
		}
		if(minute < 10) {
			builder.append("0" + minute + ":");
		} else {
			builder.append(minute + ":");
		}
		if(second < 10) {
			builder.append("0" + second);
		} else {
			builder.append(second);
		}
		return builder.toString();
	}

	
	// ajax.....
	@RequestMapping(value = "/display")
	public @ResponseBody String ajaxReceive(Model model, @RequestParam String companyCode, HttpSession session) {
		Users user = (Users)session.getAttribute("addUser");
		// 
		CompanyPerson person = new CompanyPerson();
		List<CompanyPerson> tempPerson = service2.selectByCompanyCode(Integer.parseInt(companyCode));
		logger.trace("수업 tempPerson" + tempPerson);
		CompanyPerson companyperson = new CompanyPerson();
		for(int i = 0; i < tempPerson.size(); i++) {
			if(user.getUserId().equals(tempPerson.get(i).getUserId())){
				companyperson.setCompanyCode(Integer.parseInt(companyCode));
				companyperson.setHireDate(tempPerson.get(i).getHireDate());
				companyperson.setMemberId(tempPerson.get(i).getMemberId());
				companyperson.setSalary(tempPerson.get(i).getSalary());
				companyperson.setUserId(tempPerson.get(i).getUserId());
			}
		}
		/*person.setUserId(user.getUserId());
		person.setCompanyCode(Integer.parseInt(companyCode));
		CompanyPerson companyperson = service2.selectCompanyPersonByPerson(person);*/
		
		//
		//CompanyPerson companyperson = service2.selectCompanyPersonByUserId(user.getUserId());
		logger.trace("수업 : " + companyperson + ", " + companyCode);
		TimeTable timetable = new TimeTable();
		List<TimeTable> lists = null;	// DB에서 Get.!
		List<SaveTime> list2 = new ArrayList<SaveTime>();	// Server에 보내기!
		SaveTime savetime = null;
		// 그리고 우리 회사 코드로 작성된 달력 정보 갖고 오기...!
		if (user.getGrade().equals("사장")) {
			// companyCode로 조회해서 직원 모두 시간 가져오기.
			lists = service.selectByCompanyCode(Integer.parseInt(companyCode));
		} else if(user.getGrade().equals("직원")) {
			// memberId로 조회해서 자신의 모든 시간 가져오기.
			lists = service.selectByMemberId(companyperson.getMemberId());
		}
		logger.trace("수업 lists 확인하기 : " + lists);
		for (int idx = 0; idx < lists.size(); idx++) {
			//logger.trace("수업 idx : " + idx);
			savetime = new SaveTime();
			savetime.setTitle(String.valueOf(lists.get(idx).getMemberId()));
			logger.trace("수업 Date 확인하기 : " + lists.get(idx).getWorkingDate());
			savetime.setStart(settingTime(lists.get(idx).getWorkingStart()));
			savetime.setEnd(settingTime(lists.get(idx).getWorkingEnd()));
			// 나중에 색 때문에라도 직원수로 나눠라 그냥.
			savetime.setColor(color[lists.get(idx).getMemberId()%13]);
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
		return objJson.toString();
	}
	
	/*----------------------여기부터 수정부분.----------------------*/
	/*@RequestMapping(value="/updateCalendar")
	public String viewsCalendar() {
		// 여기 수정 준비...
		return "calendar/viewCalendar";
	}*/
	
	// ajax..... 수정할때 쓰는 ajax! 
	@RequestMapping(value = "/updateAjax")
	public @ResponseBody String ajaxReceive2(Model model, HttpSession session) {
		Users user = (Users)session.getAttribute("addUser");
		String userId = user.getUserId();
		CompanyPerson companyperson = service2.selectCompanyPersonByUserId(userId);
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
			savetime.setStart(settingTime(lists.get(idx).getWorkingStart()));
			savetime.setEnd(settingTime(lists.get(idx).getWorkingEnd()));
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
		return objJson.toString();
	}
	
	@RequestMapping(value="/updateTimeTable")
	public String updateCalendar(@RequestParam String updateStart, @RequestParam String updateEnd, @RequestParam String deleteItem, Model model, HttpSession session) {
		Users loginUser = (Users)session.getAttribute("addUser");
		CompanyPerson companyperson = service2.selectCompanyPersonByUserId(loginUser.getUserId());
		model.addAttribute("code", companyperson.getCompanyCode());
		
		Calendar operationTime = Calendar.getInstance();
		Calendar deletesTime = Calendar.getInstance();
		// 수정 시작 시간.
		logger.trace("수업 Start : " + updateStart);
		// 수정 끝난 시간.
		logger.trace("수업 End : " + updateEnd);
		// 삭제할 데이터
		logger.trace("수업 delete : " + deleteItem);
		Gson gson = new Gson();
		ArrayList start = new ArrayList();
		ArrayList end = new ArrayList();
		ArrayList deletes = new ArrayList();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		Date compareStart = new Date();
		Date workingStart = new Date();
		Date workingEnd = new Date();
		start = gson.fromJson(updateStart, ArrayList.class);
		end = gson.fromJson(updateEnd, ArrayList.class);
		deletes = gson.fromJson(deleteItem, ArrayList.class);
		logger.trace("수업 Gson Start : " + start);
		logger.trace("수업 Gson End : " + end);
		logger.trace("수업 Gson Delete : " + deletes);
		// update할 timeKey를 추출.
		for(int i = 0; i < start.size(); i ++) {
		TimeTable timetable = new TimeTable();
		com.google.gson.internal.LinkedTreeMap map = (com.google.gson.internal.LinkedTreeMap)start.get(i);
		com.google.gson.internal.LinkedTreeMap map2 = (com.google.gson.internal.LinkedTreeMap)end.get(i);
		logger.trace("수업 MAP" + map);
		logger.trace("수업 MAP2" + map2);
		int memberId = Integer.parseInt(map.get("title").toString());
		try {
			compareStart = formatter.parse(map.get("start").toString());
			logger.trace("수업 :::::::::: compareStart" + compareStart);
		} catch (java.text.ParseException e1) {
		// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		// 비교 시간 저장....
		operationTime.setTime(compareStart);
		int year = operationTime.get(Calendar.YEAR);
		int month = operationTime.get(Calendar.MONTH)+1;
		int day = operationTime.get(Calendar.DATE);
		int hour = operationTime.get(Calendar.HOUR_OF_DAY);
		timetable.setMemberId(memberId);
		timetable.setWorkingStart(compareStart);
		logger.trace("수업 TimeTable : " + timetable);
		// Key를 찾아라....! MemberId로 조회한 모든 컬럼 다 갖고오기.
		List<TimeTable> time = service.selectByMemberId(memberId);
		logger.trace("수업 Time : " + time);
		int timekey = 0;
		// TimeKey 추출. 
		for(int k = 0; k < time.size(); k++) {
			operationTime.setTime(time.get(k).getWorkingStart());
			//if(time.get(k).getWorkingStart().compareTo(compareStart) == 1) {
			if(operationTime.get(Calendar.YEAR) == year && operationTime.get(Calendar.MONTH)+1 == month 
					&& operationTime.get(Calendar.DATE) == day && operationTime.get(Calendar.HOUR_OF_DAY) == hour){
				timekey = time.get(k).getTimeKey();
			}
		}
		logger.trace("수업 ㅠㅠ : " + timekey);
		// update할 내용 셋팅.
		TimeTable updateTable = new TimeTable();
		//updateTable.setWorkingDate(workingDate);
		try {
			date = formatter.parse(map2.get("start").toString());
			workingStart = formatter.parse(map2.get("start").toString());
			workingEnd = formatter.parse(map2.get("end").toString());
		} catch (java.text.ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		updateTable.setTimeKey(timekey);
		updateTable.setMemberId(memberId);
		updateTable.setWorkingDate(date);
		updateTable.setWorkingStart(workingStart);
		updateTable.setWorkingEnd(workingEnd);
		logger.trace("수업 Update : " + updateTable);
		service.updateTimeTable(updateTable);
		}
		
		int dmemberId = 0;
		Date deleteT = new Date();
		for(int k = 0; k < deletes.size(); k++) {
			com.google.gson.internal.LinkedTreeMap map = (com.google.gson.internal.LinkedTreeMap)deletes.get(k);
			dmemberId = Integer.parseInt(map.get("title").toString());
			try {
				deleteT = formatter.parse(map.get("start").toString());
			} catch (java.text.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		deletesTime.setTime(deleteT);
		int dyear = deletesTime.get(Calendar.YEAR);
		int dmonth = deletesTime.get(Calendar.MONTH)+1;
		int dday = deletesTime.get(Calendar.DATE);
		int dhour = deletesTime.get(Calendar.HOUR_OF_DAY);
		List<TimeTable> deleteTime = service.selectByMemberId(dmemberId);
		int dTimekey = 0;
		for(int q = 0; q < deleteTime.size(); q++) {
			deletesTime.setTime(deleteTime.get(q).getWorkingDate());
			if(deletesTime.get(Calendar.YEAR) == dyear && deletesTime.get(Calendar.MONTH)+1 == dmonth 
					&& deletesTime.get(Calendar.DATE) == dday && deletesTime.get(Calendar.HOUR_OF_DAY) == dhour){
				dTimekey = deleteTime.get(q).getTimeKey();
			}
		}
		service.deleteTimeTableByTimekey(dTimekey);
		
		return "/schedule/employer/allSchedule";
	}
}
