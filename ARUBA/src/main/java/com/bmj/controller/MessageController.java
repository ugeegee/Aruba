package com.bmj.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bmj.entity.Company;
import com.bmj.entity.CompanyPerson;
import com.bmj.entity.Message;
import com.bmj.entity.Users;
import com.bmj.exception.RegisterJobException;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.CompanyService;
import com.bmj.service.MessageService;
import com.bmj.service.UsersService;

@Controller
public class MessageController {

	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(MessageController.class);
	}

	@Autowired
	CompanyService cService;
	@Autowired
	CompanyPersonService cpService;
	@Autowired
	MessageService mService;
	@Autowired
	UsersService uService;

	// 알바생 회사코드 등록하면
	// 사장에게 메세지보내고 자신에게도 메세지 남고
	@RequestMapping(value = "/sendMsgToOwner", method = RequestMethod.POST)
	public String registerJobSuccess(@RequestParam int companyCode,
			@RequestParam String companyTel, HttpSession session, Model model) {

		boolean alreadyRegister = false;
		String viewPath = "";
		// 입력받은 code,tel 회사존재여부 확인
		Company searchCom = new Company();
		searchCom.setCompanyCode(companyCode);
		searchCom.setCompanyTel(companyTel);
		searchCom = cService.selectCompanyByCodeAndTel(searchCom);

		Users loginUser = (Users) session.getAttribute("addUser"); // 메세지보내는알바생
		int uncheckedMessageCount;
		// 존재하는 회사일 때, 이미 등록한 회사인지아닌지 확인
		List<Integer> codeList = cpService.selectComCodeByUserId(loginUser.getUserId());
		for (int i = 0; i < codeList.size(); i++) {
			if (codeList.get(i).intValue() == companyCode) {	//이미등록한회사다.
				alreadyRegister = true;
				model.addAttribute("PopUp", 2);
				
				//현재 가입된 회사 수
				List<Company> comList = new ArrayList<Company>();
				for(int j = 0; j < codeList.size(); j++){
					comList.add(j, cService.selectCompanyByCompanyCode( codeList.get(j).intValue() ) );
				}
				//현재 가입대기중인 회사 수
				uncheckedMessageCount = mService.countUncheckedFlagByUserId(loginUser.getUserId());
				
				if(codeList.size()+uncheckedMessageCount > 2){
					model.addAttribute("emptyCompany", "NO");
				}else{
					model.addAttribute("emptyCompany", "YES");
				}
				logger.trace("가져온 나의 회사 정보!! " + comList);
				model.addAttribute("myCompanies", comList);
				
				viewPath = "myJob/myJob";
			}
		}
		// 존재하는 회사일 때, 현재 대기중인 회사인지아닌지 확인(컴패니코드로 조회한 메세지중 flag0이고 보낸사람 로그인한 알바생
		Message temp = new Message();
		temp.setCompanyCode(companyCode);
		temp.setUserId(loginUser.getUserId());
		temp.setFlag(0);
		Message uncheckedMessage = mService.selectUncheckedMessageByMessage(temp);
		logger.trace("대기중인회사인지 메세지확인!!!!"+uncheckedMessage);
		if(uncheckedMessage != null){	//현재 대기중인 회사임
			alreadyRegister = true;
			model.addAttribute("PopUp", 3);
			
			//현재 가입된 회사 수
			List<Company> comList = new ArrayList<Company>();
			for(int j = 0; j < codeList.size(); j++){
				comList.add(j, cService.selectCompanyByCompanyCode( codeList.get(j).intValue() ) );
			}
			//현재 가입대기중인 회사 수
			uncheckedMessageCount = mService.countUncheckedFlagByUserId(loginUser.getUserId());
			
			if(codeList.size()+uncheckedMessageCount > 2){
				model.addAttribute("emptyCompany", "NO");
			}else{
				model.addAttribute("emptyCompany", "YES");
			}
			logger.trace("가져온 나의 회사 정보!! " + comList);
			model.addAttribute("myCompanies", comList);
			
			viewPath = "myJob/myJob";
		}
		if (alreadyRegister == false) {
			Message message = new Message();

			message.setCompanyCode(companyCode);
			message.setUserId(loginUser.getUserId());
			List<CompanyPerson> cpList = cpService
					.selectByCompanyCode(companyCode);
			String ownerId = "";
			for (int i = 0; i < cpList.size(); i++) {
				Users tempUser = uService.selectUserByUserId(cpList.get(i).getUserId());
				if ((tempUser.getGrade().equals("사장"))) {
					ownerId = tempUser.getUserId();
					break;
				}
			}
			message.setReceiverId(ownerId);
			message.setMessageContent(loginUser.getUserId()+"님이 아르바이트 등록");
			message.setFlag(0); // 보지 않은 메세지=0, 본 메세지=1

			mService.insertMessage(message);
			viewPath = "redirect:/alert_employee";
		}
		return viewPath;
	}

	@RequestMapping(value = "/alert_employer")
	// 사장 mypage 메뉴에서 Alerts(쪽지관리)
	public String mypagAlertsEmployerGo(HttpSession session, Model model) {
		Users loginUser = (Users) session.getAttribute("addUser"); // 로그인한 사장정보
		/*
		 * List<Integer> codeList = cpService.selectComCodeByUserId(loginUser
		 * .getUserId());
		 * 
		 * int ComCode = codeList.get(0).intValue();
		 * 
		 * List<Message> myComMessages =
		 * mService.selectMessageByComCode(ComCode);
		 */
		List<Message> myComMessages = mService.selectMessageByUserId(loginUser
				.getUserId());

		logger.trace("가져온 사장 메세지들!! " + myComMessages);
		model.addAttribute("myComMessages", myComMessages);

		return "/myStore/alert";
	}

	@RequestMapping(value = "/alert_employee")
	// 알바 mypage 메뉴에서 Alerts(쪽지관리)
	public String mypagAlertsEmployeeGo(HttpSession session, Model model) {
		Users loginUser = (Users) session.getAttribute("addUser");
		List<Message> myMessages = mService.selectMessageByUserId(loginUser
				.getUserId());

		logger.trace("!!가져온 직원 메세지들!! " + myMessages);
		model.addAttribute("myMessages", myMessages);
		return "/myJob/alert";
	}

	// ///////////////////////////////////////////////////////////////////////////////////////////////////

	@ExceptionHandler
	public String RegisterJobFail(RegisterJobException e,
			HttpServletRequest request, HttpSession session) {
		logger.trace("직원이 직장등록하려했으나 없는회사임!!!!!");
		request.setAttribute("PopUp", 1);

		Users loginUser = (Users) session.getAttribute("addUser");

		List<Integer> codeList = cpService.selectComCodeByUserId(loginUser
				.getUserId());
		List<Company> comList = new ArrayList<Company>();
		for (int i = 0; i < codeList.size(); i++) {
			comList.add(i, cService.selectCompanyByCompanyCode(codeList.get(i)
					.intValue()));
		}

		if (codeList.size() > 2) {
			request.setAttribute("emptyCompany", "NO");
		} else {
			request.setAttribute("emptyCompany", "YES");
		}
		logger.trace("가져온 나의 회사 정보!! " + comList);
		request.setAttribute("myCompanies", comList);

		return "myJob/myJob";
	}

	// ///////////////////////////////////////////////////////////////////////////////////////////////////

}
