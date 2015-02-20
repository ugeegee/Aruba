package com.bmj.controller;

import java.util.List;

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
import com.bmj.exception.LoginFailException;
import com.bmj.exception.RegisterJobException;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.CompanyService;
import com.bmj.service.MessageService;

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

	// 알바생 회사코드 등록하면
	// 사장에게 메세지보내고 자신에게도 메세지 남고
	@RequestMapping(value = "/sendMsgToOwner", method = RequestMethod.POST)
	public String registerJobSuccess(@RequestParam int companyCode,
			@RequestParam String companyTel, HttpSession session) {
		
		// 입력받은 code,tel 회사존재여부 확인
		Company searchCom = new Company();
		searchCom.setCompanyCode(companyCode);
		searchCom.setCompanyTel(companyTel);
		searchCom = cService.selectCompanyByCodeAndTel(searchCom);

		
		Message message = new Message();
		Users loginUser = (Users) session.getAttribute("addUser"); // 현재로그인한  사람=메세지 보내는사람

		message.setCompanyCode(companyCode);
		message.setUserId(loginUser.getUserId());
		message.setMessageContent("아르바이트 등록");
		message.setFlag(0); // 보지 않은 메세지=0, 본 메세지=1

		mService.insertMessage(message);
		
		return "redirect:/alerts_employee";
	}

	@RequestMapping(value = "/alert_employer")
	// 사장 mypage 메뉴에서 Alerts(쪽지관리)
	public String mypagAlertsEmployerGo(HttpSession session, Model model) {
		Users loginUser = (Users) session.getAttribute("addUser"); // 로그인한 사장정보
		List<Integer> codeList = cpService.selectComCodeByUserId(loginUser.getUserId());
		
		int ComCode = codeList.get(0).intValue(); 

		List<Message> myComMessages = mService.selectMessageByComCode(ComCode);
		logger.trace("가져온 나의 회사 메세지들!! " + myComMessages);
		model.addAttribute("myComMessages", myComMessages);

		return "/myStore/alert";
	}

	@RequestMapping(value = "/alert_employee")
	// 알바 mypage 메뉴에서 Alerts(쪽지관리)
	public String mypagAlertsEmployeeGo(HttpSession session, Model model) {
		Users loginUser = (Users) session.getAttribute("addUser");
		List<Message> myMessages = mService.selectMessageByUserId(loginUser
				.getUserId());

		logger.trace("!!가져온 나의 메세지들!! " + myMessages);
		model.addAttribute("myMessages", myMessages);
		return "/myJob/alert";
	}

	@ExceptionHandler
	public String RegisterJobFail(RegisterJobException e) {
		logger.trace("직원이 직장등록하려했으나 없는회사임!!!!!");
		return "redirect:/myJob";
	}
}
