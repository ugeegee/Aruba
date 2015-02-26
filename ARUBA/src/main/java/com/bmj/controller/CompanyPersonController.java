package com.bmj.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bmj.entity.CompanyPerson;
import com.bmj.entity.Message;
import com.bmj.entity.StaffInfo;
import com.bmj.entity.Users;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.CompanyService;
import com.bmj.service.MessageService;
import com.bmj.service.TimeTableService;
import com.bmj.service.UsersService;

@Controller
public class CompanyPersonController {

	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(CompanyPersonController.class);
	}
	@Autowired
	CompanyService cService;
	@Autowired
	CompanyPersonService cpService;
	@Autowired
	MessageService mService;
	@Autowired
	UsersService uService;
	@Autowired
	TimeTableService tService;

	@RequestMapping(value = "/webProject/...?")
	public String addPerson(Model model) {
		model.addAttribute("addPerson", new CompanyPerson());
		return "";
	}

	// /////////////////////////////////////////////////////////////////////////////////////////////////

	@RequestMapping(value = "/addNewEmployee", method = RequestMethod.GET)
	public String addNewEmployeeSuccessGo(@RequestParam int companyCode,
			@RequestParam String userId, @RequestParam int messageNumber) {
		logger.trace("승낙버튼누름!! 회사" + companyCode + " 아이디 " + userId);

		mService.updateMesageAcceptFlagByMsgNum(messageNumber); // 승낙했으니까 1로바꿈

		CompanyPerson companyperson = new CompanyPerson();
		companyperson.setCompanyCode(companyCode);
		companyperson.setUserId(userId);
		Date today = new Date();
		companyperson.setHireDate(today.toString());
		cpService.insertCompanyEmployee(companyperson); // 알바생추가
		return "redirect:/alert_employer";
	}
	@RequestMapping(value = "/rejectNewEmployee", method = RequestMethod.GET)
	public String rejectNewEmployeeSuccessGo(@RequestParam int companyCode,
			@RequestParam String userId, @RequestParam int messageNumber) {
		logger.trace("거절버튼누름!! 회사" + companyCode + " 아이디 " + userId);

		mService.updateMesageRejectFlagByMsgNum(messageNumber); // 거절했으니까 2로바꿈

		return "redirect:/alert_employer";
	}

	@RequestMapping(value = "/staff")
	// 사장 mypage 메뉴에서 Staff(알바생관리)
	public String mypageStaffGo(Model model, HttpSession session) {

		String viewPath = "";
		Users loginUser = (Users) session.getAttribute("addUser");
		List<Integer> code = cpService.selectComCodeByUserId(loginUser
				.getUserId());
		logger.trace("수업 code " + code);

		// 찾은companycode로 등록된 사람다찾기(사장도포함되있음)
		List<CompanyPerson> comPersonList = null;
		for (int i = 0; i < code.size(); i++) {
			comPersonList = cpService.selectByCompanyCode(code.get(i).intValue());
		}
		logger.trace("수업 com personList : " + comPersonList);
		// 사장 삭제.
		if(comPersonList == null){
			model.addAttribute("staffList", -1);
			viewPath = "/Exception/showException";
		} else if (comPersonList.size() == 1){
			model.addAttribute("staffList", 0);
			viewPath = "/Exception/showException";
		} else if (comPersonList.size() > 1){
			for (int i = 0; i < comPersonList.size(); i++) {
				if (loginUser.getUserId().equals(comPersonList.get(i).getUserId())) {
					comPersonList.remove(i);
				}
			}
		
			logger.trace("수업 사장 삭제 , compersonList : " + comPersonList);

			List<Users> usersList = new ArrayList<Users>(); // 회사에 등록된 사람들의
															// 정보가져오기

			for (int i = 0; i < comPersonList.size(); i++) { // 0번째는 사장이니
																// 사장제외하고넣기
				usersList.add(i, uService.selectUserByUserId(comPersonList.get(
						i).getUserId()));
			}
			logger.trace("수업 usersList" + usersList);
			List<StaffInfo> staffList = new ArrayList<StaffInfo>();
			for (int i = 0; i < usersList.size(); i++) {
				StaffInfo sf = new StaffInfo(usersList.get(i).getUserName(),
						usersList.get(i).getUserId(),
						usersList.get(i).getTel(), usersList.get(i).getEmail(),
						comPersonList.get(i).getSalary(), comPersonList.get(i)
								.getHireDate(), comPersonList.get(i)
								.getCompanyCode());
				staffList.add(i, sf);
			}
			logger.trace("수업 : " + staffList.toString());
			model.addAttribute("staffList", staffList);
			viewPath = "/myStore/staff";
		}
		return viewPath;
	}

	@RequestMapping(value = "/modifySalary", method = RequestMethod.GET)
	public String modifySalarySuccess(@RequestParam int companyCode,
			@RequestParam String userId, @RequestParam int salary) {

		CompanyPerson companyperson = new CompanyPerson();
		companyperson.setCompanyCode(companyCode);
		companyperson.setUserId(userId);
		companyperson.setSalary(salary);

		cpService.updateSalary(companyperson);

		return "redirect:/staff";
	}

	@RequestMapping(value = "/deleteStaff", method = RequestMethod.GET)
	public String deleteStaffSuccess(@RequestParam int companyCode,
			@RequestParam String userId, HttpSession session) {

		// 사장이 직원삭제시 시간표>companyPerson 삭제, 메세지남기기
		CompanyPerson companyperson = new CompanyPerson();
		companyperson.setCompanyCode(companyCode);
		companyperson.setUserId(userId);

		// 시간표삭제
		int memberId = cpService.selectMemberIdbyCompanyPerson(companyperson);
		tService.deleteTimeTableByMemberId(memberId);
		// CP삭제
		cpService.deleteCompanyPersonByComCodeAndUserId(companyperson);
		// 메세지
		Message message = new Message();
		Users loginUser = (Users) session.getAttribute("addUser");

		message.setCompanyCode(companyCode);
		message.setUserId(loginUser.getUserId());
		message.setReceiverId(userId);
		message.setMessageContent("사장 "+loginUser.getUserId()+"님이 아르바이트 삭제");
		message.setFlag(-1);

		mService.insertMessage(message);
		return "redirect:/staff";
	}

	@RequestMapping(value = "/deleteJob", method = RequestMethod.GET)
	//알바생 직장삭제
	public String deleteJobSuccess(@RequestParam int companyCode, HttpSession session) {
		
		Users loginUser = (Users) session.getAttribute("addUser");
		CompanyPerson companyperson = new CompanyPerson();
		companyperson.setCompanyCode(companyCode);
		companyperson.setUserId(loginUser.getUserId());
		
		// 시간표삭제
		int memberId = cpService.selectMemberIdbyCompanyPerson(companyperson);
		tService.deleteTimeTableByMemberId(memberId);
		// 직장삭제 메세지 보내기
		Message message = new Message();
		message.setCompanyCode(companyCode);
		message.setUserId(loginUser.getUserId());
		
		List<CompanyPerson> cpList = cpService.selectByCompanyCode(companyCode);
		String ownerId = "";
		for (int i = 0; i < cpList.size(); i++) {
			Users temp = uService.selectUserByUserId(cpList.get(i).getUserId());
			if ((temp.getGrade().equals("사장"))) {
				ownerId = temp.getUserId();
				break;
			}
		}
		message.setReceiverId(ownerId);
		message.setMessageContent("아르바이트 "+loginUser.getUserId()+"님이 직장 삭제");
		message.setFlag(-1);

		mService.insertMessage(message);
		
		// CP삭제
		cpService.deleteCompanyPersonByComCodeAndUserId(companyperson);
		
		return "redirect:/myJob";
	}

}
