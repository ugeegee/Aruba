package com.bmj.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bmj.entity.CompanyPerson;
import com.bmj.entity.StaffInfo;
import com.bmj.entity.Users;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.CompanyService;
import com.bmj.service.MessageService;
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

	@RequestMapping(value = "/webProject/...?")
	public String addPerson(Model model) {
		model.addAttribute("addPerson", new CompanyPerson());
		return "";
	}

	
	// /////////////////////////////////////////////////////////////////////////////////////////////////

	@RequestMapping(value = "/addNewEmployee", method = RequestMethod.GET)
	public String addNewEmployeeSuccessGo(@RequestParam int companyCode, @RequestParam String userId, @RequestParam int messageNumber) {
		logger.trace("승낙버튼누름!! 회사"+companyCode+" 아이디 " +userId);
		
		mService.updateMesageFlagByMsgNum(messageNumber);		//읽었으니까 1로바꿈
		
		CompanyPerson companyperson = new CompanyPerson();
		companyperson.setCompanyCode(companyCode);
		companyperson.setUserId(userId);
		companyperson.setHireDate("오늘");
		cpService.insertCompanyEmployee(companyperson);			//알바생추가
		return "redirect:/alerts_employer";
	}
	
	
	@RequestMapping(value = "/staff")
	// 사장 mypage 메뉴에서 Staff(알바생관리)
	public String mypageStaffGo(Model model,HttpSession session) {
		
		Users loginUser = (Users)session.getAttribute("addUser");
		List<Integer> code = cpService.selectComCodeByUserId(loginUser.getUserId());
		
		//찾은companycode로 등록된 사람다찾기(사장도포함되있음)
		List<CompanyPerson> comPersonList = cpService.selectByCompanyCode(code.get(0).intValue());
		List<Users> usersList = new ArrayList<Users>();
		//회사에 등록된 사람들의 정보 가져오기 
		for(int i = 0 ; i<comPersonList.size()-1 ; i++){	//0번째는 사장이니 사장제외하고 넣기
			usersList.add(i, uService.selectUserByUserId(comPersonList.get(i+1).getUserId()) );
		}

		
		List<StaffInfo> staffList = new ArrayList<StaffInfo>();
		for(int i = 0; i<usersList.size(); i++){				
			StaffInfo sf = new StaffInfo( usersList.get(i).getUserName(), usersList.get(i).getUserId(), 
										usersList.get(i).getTel(), usersList.get(i).getEmail(),
										comPersonList.get(i).getSalary(), comPersonList.get(i).getHireDate(),
										comPersonList.get(i).getCompanyCode());
			
			staffList.add(i, sf);
		}
		
		model.addAttribute("staffList", staffList);
		
		return "/myStore/staff";
	}
	
	@RequestMapping(value="/modifySalary", method = RequestMethod.GET)
	public String modifySalarySuccess(@RequestParam int companyCode, @RequestParam String userId, @RequestParam int salary){
		
		CompanyPerson companyperson = new CompanyPerson();
		companyperson.setCompanyCode(companyCode);
		companyperson.setUserId(userId);
		companyperson.setSalary(salary);
		
		cpService.updateSalary(companyperson);
		
		return "redirect:/staff";
	}

}
