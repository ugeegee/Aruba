package com.bmj.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bmj.entity.Company;
import com.bmj.entity.CompanyPerson;
import com.bmj.entity.Stats;
import com.bmj.entity.Users;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.CompanyService;
import com.bmj.service.TimeTableService;

@Controller
public class ChartController {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(ChartController.class);
	}
	
	@Autowired
	TimeTableService service;
	@Autowired
	CompanyPersonService cpservice;
	@Autowired
	CompanyService companyservice;
	
	// 개인 급여 조회~~
	@RequestMapping(value = "/mychart")
	public String goChartAlba() {
		logger.trace("수업 : Chart~~~~~~~~~~~~~~!");
		return "chart/myChart";
	}
	
	// 직원 급여 조회~~
	@RequestMapping(value = "/companychart")
	public String goChartcompany() {
		logger.trace("수업 : CompanyChart~~~~~~~~~~~~~~!");
		return "chart/CompanyChart";
	}
	
	/*개인  월급 보기*/
	/*실시간 월급 조회 기능 추가*/
	@RequestMapping(value = "/ajaxChart")
	public @ResponseBody String ajaxReceive(@RequestParam String companyCode, Model model, HttpSession session) {
		//Calendar workingDate = Calendar.getInstance();
		Users user = (Users)session.getAttribute("addUser");
		logger.trace("수업 user : " + user + ", " + companyCode);
		String userId = user.getUserId();
		// 수정 이젠 나의 회사에 따라 나의 멤버 ID 찾기.
		CompanyPerson companyperson = new CompanyPerson();
		List<CompanyPerson> result = cpservice.selectByCompanyCode(Integer.parseInt(companyCode));
		
		for(int i = 0; i < result.size(); i++) {
			if(user.getUserId().equals(result.get(i).getUserId())) {
				companyperson.setCompanyCode(Integer.parseInt(companyCode));
				companyperson.setHireDate(result.get(i).getHireDate());
				companyperson.setMemberId(result.get(i).getMemberId());
				companyperson.setSalary(result.get(i).getSalary());
				companyperson.setUserId(result.get(i).getUserId());
			}
		}
		//
		//CompanyPerson companyperson= cpservice.selectCompanyPersonByUserId(userId);
		logger.trace("수업 companyperson : " + companyperson);
				
		List<Stats> myTimes = new ArrayList<Stats>();
		myTimes = service.selectStatsByMemberId(companyperson.getMemberId());
		
		logger.trace("수업 ::::::::::::::::" + myTimes);			// 모든 월단위 start_end - start_start
		if(myTimes.isEmpty()) {
			logger.trace("수업, 아무것도없다.");
		} else {
			logger.trace("수업, 아무것도 있다.");
			model.addAttribute("Times", myTimes);
		}
		int salary = companyperson.getSalary();
		for (int i = 0; i < myTimes.size(); i++) {
			int count = (int)(myTimes.get(i).getCount()* 24 * salary);
			myTimes.get(i).setCount(count);
		}
		logger.trace("수업, 기본 셋팅 완료 : " + myTimes);	// 월급 계산됨.
		
		JSONObject objJson = new JSONObject();
		JSONArray arrayJson = new JSONArray();
		
		for(int i = 0; i < myTimes.size(); i++) {
			JSONObject obj = new JSONObject();
			obj.put("month", myTimes.get(i).getMonth());
			obj.put("memberId", userId);			
			/*obj.put("memberId", myTimes.get(i).getMemberId());*/
			obj.put("count", myTimes.get(i).getCount());
			
			arrayJson.add(obj);
		}
		objJson.put("charts", arrayJson);
		
		logger.trace("수업 Json : " + objJson);
		
		return objJson.toString();
	}
	
	/*사장이 직원 월급현황 보기*/
	@RequestMapping(value = "/ajaxCompanyChart")
	public @ResponseBody String ajaxComReceive(Model model, HttpSession session) {
		// 1. session에서 내 정보를 가져오겠지...?
		Users user = (Users)session.getAttribute("addUser");
		logger.trace("수업 user : " + user);
		String userId = user.getUserId();
		CompanyPerson companyperson= cpservice.selectCompanyPersonByUserId(userId);
		logger.trace("수업 사장... companyperson : " + companyperson);
		Company company = companyservice.selectCompanyByCompanyCode(companyperson.getCompanyCode());
		logger.trace("수업 회사 : " + company);
		// 2. 내 아이디로 나의 직원 아이디를 가져오고!
		List<CompanyPerson> employee = cpservice.selectByCompanyCode(companyperson.getCompanyCode());
		
		for(int i = 0; i < employee.size(); i++) {
			if(employee.get(i).getUserId().equals(userId)) {
				employee.remove(i);
			}
		}
		logger.trace("수업 직원들 : " + employee);
		// String memberId = service.select~~(userId);
		// 일단여기에선 UserId : Kim , memberId = 6
		// 3. 직원 아이디로 근무표를 조회한다.
		Stats stats = new Stats();
		
		List<Stats> myTimes = new ArrayList<Stats>();		// 모든 직원 시간 저장할 List
		List<Stats> nightTimes = new ArrayList<Stats>();
		myTimes = service.selectStatsByCompanyCode(companyperson.getCompanyCode());
		nightTimes = service.selectNightStatsByCompanyCode(companyperson.getCompanyCode());
		// month, memberId, count
		logger.trace("수업 ::::::::::::::::" + myTimes);
		logger.trace("수업 nightTimes : " + nightTimes);
		if(myTimes.isEmpty()) {
			logger.trace("수업, 아무것도없다.");
		} else {
			logger.trace("수업, 아무것도 있다.");
			model.addAttribute("Times", myTimes);
		}
		int salary = companyperson.getSalary();
		for(int i = 0; i < myTimes.size(); i++) {
			//double count = 0;
			int count = 0;
			for(int j = 0; j < employee.size(); j++) {
				// 시급 찾을려고 준 조건.
				if(myTimes.get(i).getMemberId() == employee.get(j).getMemberId()) {
					count = (int) (myTimes.get(i).getCount() * 24 * employee.get(j).getSalary());
					/*for (int x = 0; x < nightTimes.size(); x++) {
						if(myTimes.get(i).getMemberId() == nightTimes.get(x).getMemberId() & myTimes.get(i).getMonth().equals(nightTimes.get(x).getMonth())) {
							myTimes.get(i).setCount((myTimes.get(i).getCount()* 24)-nightTimes.get(x).getCount()); 	
						}
						count = (int)(myTimes.get(i).getCount()* 24 * employee.get(j).getSalary() + nightTimes.get(x).getCount()*((float)company.getNightComm()/100+1)*employee.get(j).getSalary());
					}*/
				}
			}
			myTimes.get(i).setCount(count);
		}
		logger.trace("수업, 기본 셋팅 완료 : " + myTimes);
		
		JSONObject objJson = new JSONObject();
		JSONArray arrayJson = new JSONArray();
		
		for(int i = 0; i < myTimes.size(); i++) {
			JSONObject obj = new JSONObject();
			obj.put("month", myTimes.get(i).getMonth());
			String id = cpservice.selectUserIdbyMemberId(myTimes.get(i).getMemberId());
			obj.put("memberId", id);
			/*obj.put("memberId", myTimes.get(i).getMemberId());*/
			obj.put("count", myTimes.get(i).getCount());
			
			arrayJson.add(obj);
		}
		objJson.put("charts", arrayJson);
		
		logger.trace("수업 Json : " + objJson);
		return objJson.toString();
	}
}
