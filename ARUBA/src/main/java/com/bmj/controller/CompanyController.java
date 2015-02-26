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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bmj.entity.Company;
import com.bmj.entity.CompanyPerson;
import com.bmj.entity.Message;
import com.bmj.entity.Users;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.CompanyService;
import com.bmj.service.MessageService;
import com.bmj.service.TimeTableService;

@Controller
// 컴패니는 session 남길 필요없음....
//@SessionAttributes("addCmp")
public class CompanyController {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(CompanyController.class);
	}
	
	@Autowired
	CompanyService service;
	@Autowired
	CompanyPersonService cpService;
	@Autowired
	TimeTableService tService;
	@Autowired
	MessageService mService;

	@RequestMapping(value= "/webProject/addCompany")
	public String addCompany(Model model) {
		model.addAttribute("addCmp", new Company());
		return "webProject/addCompany";
	}
	
	@RequestMapping(value= "/webProject/addCompanys")
	public String addCompanys(@ModelAttribute("addCmp") Company company) {
		logger.trace("수업 33333333333333333333 : " + company);
		service.insertCompany(company);
		return "webProject/login";
	}
	
	
///////////////////////////////////////////////////////////////////////////////////////////////////

	@RequestMapping(value="/registerCompany", method = RequestMethod.GET)
	public String registerCompany(Model model) {					//가입완료 후, 사장-회사 등록 버튼 - 회사등록페이지
		model.addAttribute("addCmp", new Company());
		return "myStore/registerCompany";
	}
	
	@RequestMapping(value = "/myCompany")
	// 사장 mypage 메뉴에서 Store(매장관리)
	public String mypageMyCompanyGo(Model model, HttpSession session) {
		Users owner = (Users) session.getAttribute("addUser");
		CompanyPerson companyPerson = null;
		String viewPath = "";

		 companyPerson = cpService.selectCompanyPersonByUserId(owner.getUserId());

		if (companyPerson == null) {
			// 등록된 회사 코드가 없음-등록하는페이지로
			viewPath = "/myStore/registerCompany";
		} else {
			// 등록한 회사가 있는 것-불러오기
			Company myCompany = new Company();
			myCompany = service.selectCompanyByCompanyCode(companyPerson.getCompanyCode());
			model.addAttribute("myCom", myCompany);
			model.addAttribute("ownerPass", owner.getPassword());
			viewPath = "/myStore/myCompany";
		}

		return viewPath;
	}
	@RequestMapping(value = "/modifyMyCom", params="modify", method = RequestMethod.POST)
	// 사장 - 회사정보수정
	public String mypageModifyMyComSuccessGo(@ModelAttribute("myCom") Company myCom,
			HttpSession session, Model model) {
		
		int result = service.updateCompany(myCom);
		Users owner = (Users) session.getAttribute("addUser");
		
		logger.trace("회사정보 업데이트 결과!!  "+result);
		model.addAttribute("PopUp", 1);
		model.addAttribute("ownerPass", owner.getPassword());
		return "/myStore/myCompany"; 			//업데이트끝나고 회사보는 페이지로
	}
	
	@RequestMapping(value = "/modifyMyCom", params="delete", method = RequestMethod.POST)
	// 사장 - 회사정보삭제
	public String mypageDeleteMyComSuccessGo(@ModelAttribute("myCom") Company myCom,
			Model model, HttpSession session) {
		logger.trace("삭제버튼눌럿어!!!!!!");
		//시간표>companyPerson 삭제> 메세지남기기>회사삭제
		//회사지울꺼니깐 회사코드에걸린 시간표 다지우고
		tService.deleteTimeTableByCompanyCode(myCom.getCompanyCode());
		logger.trace("시간표지움!!!!!!!!!!!!!");
		//회사코드에걸린 회사원가져오고
		List<CompanyPerson> cpList = cpService.selectByCompanyCode(myCom.getCompanyCode());
		logger.trace("회사원들은????!!!!"+cpList);
		Message message = new Message();
		Users loginUser = (Users) session.getAttribute("addUser");
		message.setCompanyCode(1);					//messageControl회사 넣어야함!!
		message.setUserId(loginUser.getUserId());
		message.setMessageContent(loginUser.getUserId()+"님 회사 삭제알림");
		message.setFlag(-1); 
		//회사삭제 메세지날리고 회사원지우고
		for(int i = 0; i<cpList.size(); i++){
			message.setReceiverId(cpList.get(i).getUserId());
			mService.insertMessage(message); 
			
			cpService.deleteCompanyPersonByUserId(cpList.get(i).getUserId());
		}
		//회사코드에걸린 메세지도지우고
		mService.deleteMessageByCompanyCode(myCom.getCompanyCode());
		//회사지우기
		int result = service.deleteCompanyByCompanyCode(myCom.getCompanyCode());
		
		logger.trace("회사지우기끝~~~!!!!"+result);
		
		return "/myStore/deleteCompany"; 		
	}
	
	/* 회사 등록과 동시에 자신 등록(사장입장) */
	@RequestMapping(value="/registerCompany", method = RequestMethod.POST)
	public String registerCompanySuccess(@RequestParam String companyName, @RequestParam String companyTel,
										@RequestParam int holidayComm, @RequestParam int nightComm,
										HttpSession session) {
		logger.trace("입력받은 회사정보!!!"+companyName+" "+companyTel+" "+holidayComm+" "+nightComm);
		Company newCompany = new Company();
		newCompany.setCompanyName(companyName);
		newCompany.setCompanyTel(companyTel);
		newCompany.setHolidayComm(holidayComm);
		newCompany.setNightComm(nightComm);
		
		service.insertCompany(newCompany);							//company테이블에 회사추가
		
		Users user = (Users)session.getAttribute("addUser");		//로그인한 사장정보
		logger.trace("수업 5555555555555555555" + user);
		// 시퀀스로 저장된 CompanyCode를 찾아오기~!
		Company company2 = service.seelctCompany(newCompany);		//방금 추가한 회사가져오기(회사코드얻기위해)
		logger.trace("수업 666666666666666666666 : " + company2);
		
		CompanyPerson companyperson = new CompanyPerson();
		// select ~~
		companyperson.setCompanyCode(company2.getCompanyCode());
		companyperson.setUserId(user.getUserId());
		companyperson.setSalary(0);                 //DB입력할때 필요하니깐 사장은 0으로
		Date today = new Date();
		companyperson.setHireDate(today.toString());
		// service.company_person.insert();
		cpService.insertCompanyOwner(companyperson);

		/*return "mypage/employer/myCompany";*/
		return "redirect:/myCompany"; 
	}
	
	
	@RequestMapping(value = "/myJob")
	// 알바 mypage 메뉴에서 직업관리
	public String mypageMyJobGo(Model model, HttpSession session) {
		Users loginUser = (Users) session.getAttribute("addUser"); // 로그인하고 있는 알바생 정보 가져오고
		
		//현재 가입된 회사 수
		List<Integer> codeList = cpService.selectComCodeByUserId(loginUser.getUserId());
		List<Company> comList = new ArrayList<Company>();
		for(int i = 0; i < codeList.size(); i++){
			comList.add(i, service.selectCompanyByCompanyCode( codeList.get(i).intValue() ) );
		}
		//현재 가입대기중인 회사 수
		int uncheckedMessage = mService.countUncheckedFlagByUserId(loginUser.getUserId());
		
		if(codeList.size()+uncheckedMessage > 2){
			model.addAttribute("emptyCompany", "NO");
		}else{
			model.addAttribute("emptyCompany", "YES");
		}
		logger.trace("가져온 나의 회사 정보!! " + comList);
		model.addAttribute("myCompanies", comList);
		
		model.addAttribute("PopUp", 0);
		
		return "/myJob/myJob";
	}

}
