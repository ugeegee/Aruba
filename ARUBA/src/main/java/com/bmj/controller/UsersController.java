package com.bmj.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.bmj.entity.Company;
import com.bmj.entity.CompanyPerson;
import com.bmj.entity.Users;
import com.bmj.exception.LoginFailException;
import com.bmj.service.CompanyPersonService;
import com.bmj.service.MessageService;
import com.bmj.service.TimeTableService;
import com.bmj.service.UsersService;

@Controller
/* @RequestMapping("/webProject") */
@SessionAttributes("addUser")
public class UsersController {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(UsersController.class);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				dateFormat, true));
	}

	@Autowired
	UsersService service;
	@Autowired
	CompanyPersonService cpService;
	@Autowired
	MessageService mService;
	@Autowired
	TimeTableService tService;

	@RequestMapping(value = "/count", method = RequestMethod.GET)
	public String getAllDeptList(Model model) {
		Integer result = service.getUsersCount();
		model.addAttribute("message", result);
		return "showMessage";
	}

	@RequestMapping(value = "/webProject/main")
	public String connectionSite() {
		return "/webProject/intro";
	}

	@RequestMapping(value = "/webProject/join")
	public String joinGo(Model model) {
		model.addAttribute("addUser", new Users());
		return "/webProject/joinForm";
	}

	@RequestMapping(value = "/webProject/login")
	public String loginGo() {
		return "/webProject/login";
	}

	@RequestMapping(value = "/webProject/join", method = RequestMethod.POST)
	public String joinSite(@ModelAttribute("addUser") Users user,
			BindingResult result) {
		logger.trace("수업2 : aaaaaaaaaaaaaaaaaaaaaaa" + user);
		service.insertUser(user);
		return "/webProject/login";
	}

	// ===============================================================
	// header(상위메뉴)부분 메뉴

	@RequestMapping(value = "/index")
	public String indexGo() {
		return "/main/index";
	}

	@RequestMapping(value = "/join")
	public String joinGGo() {
		return "/join/join";
	}

	@RequestMapping(value = "/checkIdPopUp", method = RequestMethod.GET)
	public String checkIdPopUpGo(Model model) {
		model.addAttribute("result", "First");
		return "/join/checkId";
	}

	@RequestMapping(value = "/checkDeleteComPopUp", method = RequestMethod.GET)
	public String checkDeleteComPopUpGo(Model model) {
		return "/myStore/checkDeleteCom";
	}

	@RequestMapping(value = "/checkId", method = RequestMethod.GET)
	public String checkIdGo(@RequestParam String userId, Model model) {
		int result = -1;

		result = service.countByUserId(userId);
		model.addAttribute("availableId", userId);

		if (result == 0) {
			model.addAttribute("result", "OK");
			logger.trace("DB조회결과 없는아이디임!!!!");
		} else if (result != 0) {
			model.addAttribute("result", "NO");
			logger.trace("DB조회결과 존재하는 아이디임!!!!");
		}
		// result < 0 사용가능 //result > 0 사용불가능

		return "/join/checkId";
	}

	@RequestMapping(value = "/join", method = RequestMethod.POST)
	// join페이지에서 가입 성공했을 때
	public String joinSuccess(@RequestParam String userId,
			@RequestParam String password, @RequestParam String password2,
			@RequestParam String userName, @RequestParam String tel,
			@RequestParam String email, @RequestParam String birth,
			@RequestParam String grade, @RequestParam String question,
			@RequestParam String answer, Model model) {

		Users loginUser = new Users();
		loginUser.setUserId(userId);
		loginUser.setPassword(password);
		loginUser.setPassword2(password2);
		loginUser.setUserName(userName);
		loginUser.setTel(tel);
		loginUser.setEmail(email);
		loginUser.setBirth(birth);
		loginUser.setGrade(grade);
		loginUser.setQuestion(question);
		loginUser.setAnswer(answer);

		service.insertUser(loginUser);
		model.addAttribute("addUser", loginUser);

		return "/join/welcome";
	}

	@RequestMapping(value = "/login")
	public String loginGGo(Model model) {
		return "/login/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginSuccess(@RequestParam String userId,
			@RequestParam String password, Model model) {
		String viewPath = "";
		Users loginUser = new Users();
		loginUser.setUserId(userId);
		loginUser.setPassword(password);

		loginUser = service.loginUser(loginUser);
		if (loginUser != null) {
			model.addAttribute("addUser", loginUser);
			viewPath = "redirect:/index";
		} else {
			viewPath = "redirect:/login";
		}

		return viewPath;
	}

	// 로그아웃 수정..중
	@RequestMapping(value = "/logout")
	// header logout메뉴 눌렀을 때
	public String logoutGo(SessionStatus sessionStatus) {

		sessionStatus.setComplete();

		return "logout/logout";
	}

	@RequestMapping(value = "/contact")
	public String contactGo() {
		return "/contact/contact";
	}

	// =============================================================== 사장&알바 공통

	@RequestMapping(value = "/modifyInfo", method = RequestMethod.POST)
	// 개인정보 수정 - 사장,알바 공통
	public String mypageModifyInfoSuccessGo(@RequestParam String nowPassword,
			@RequestParam String userName, @RequestParam String tel,
			@RequestParam String email, @RequestParam String birth,
			@RequestParam String question, @RequestParam String answer,
			Model model, HttpSession session) {
		String viewPath = "";
		Users modifyUser = new Users();
		Users loginUser = (Users) session.getAttribute("addUser");

		modifyUser.setUserId(loginUser.getUserId()); // 아이디만 현재 로그인한 회원으로 가져오기
		modifyUser.setUserName(userName);
		modifyUser.setPassword(nowPassword);
		modifyUser.setTel(tel);
		modifyUser.setEmail(email);
		modifyUser.setBirth(birth);
		modifyUser.setQuestion(question);
		modifyUser.setAnswer(answer);

		logger.trace("수정하기로한 정보!!!" + modifyUser);

		service.updateUser(modifyUser); // 디비 수정!!

		modifyUser = service.loginUser(modifyUser); // 수정한 애로 로그인시켜서
		model.addAttribute("addUser", modifyUser); // addUser도 수정된 애로 바꾸고

		model.addAttribute("PopUp", 1);

		return "mypage/myInfo";
	}

	@RequestMapping(value = "/modifyPass", method = RequestMethod.POST)
	// 비밀번호 수정 - 사장,알바 공통
	public String mypageModifyPassSuccessGo(@RequestParam String userId,
			@RequestParam String modifyPass1, @RequestParam String modifyPass2,
			Model model) {
		String viewPath = "";
		Users modifyPassUser = new Users();
		modifyPassUser.setUserId(userId);
		modifyPassUser.setPassword(modifyPass1);
		modifyPassUser.setPassword2(modifyPass2);

		service.updatePassUser(modifyPassUser); // 비번 업데이트 하고
		modifyPassUser = service.loginUser(modifyPassUser); // 업데이트한 거로 새로 가져와서
		model.addAttribute("addUser", modifyPassUser);

		/*
		 * if ((modifyPassUser.getGrade()).equals("사장")) { viewPath =
		 * "redirect:/modifyEmployerPass"; } else { viewPath =
		 * "redirect:/modifyEmployeePass"; }
		 */

		model.addAttribute("PopUp", 1);

		return "/mypage/modifyPass";
	}

	@RequestMapping(value = "/leaveAruba", method = RequestMethod.POST)
	// 회원탈퇴 - 사장,알바 공통
	public String mypageLeaveArubaSuccessGo(@RequestParam String nowPassword,
			Model model, HttpSession session, SessionStatus sessionStatus) {
		Users leaveUser = new Users();
		Users loginUser = (Users) session.getAttribute("addUser");

		leaveUser.setUserId(loginUser.getUserId()); // 아이디만 현재 로그인한 회원으로 가져오기
		leaveUser.setPassword(nowPassword);

		// ////직원탈퇴시-삭제 (댓글>게시글)>시간표>companyPerson>메세지>users
		List<Integer> memberId = cpService.selectMemberIdListbyUserId(leaveUser
				.getUserId());
		logger.trace("가져온 멤버아이디!!!!! " + memberId);
		// 시간표지우고(최대 3개인 직장 시간표 다지우기)
		for (int i = 0; i < memberId.size(); i++) {
			tService.deleteTimeTableByMemberId(memberId.get(i).intValue());
			logger.trace("시간표지움~~~!!!!");
		}
		// CP지우고
		cpService.deleteCompanyPersonByUserId(leaveUser.getUserId());
		logger.trace("CP지움~~~!!!!");
		// 메세지지우고
		mService.deleteMessageByUserId(leaveUser.getUserId());
		logger.trace("메세지지움~~~!!!!");
		// USER지우고
		service.deleteUser(leaveUser);

		sessionStatus.setComplete();

		return "/mypage/goodBye";
	}

	// =============================================================== 공통 마이페이지

	@RequestMapping(value = "/myInfo")
	// mypage 메뉴 눌렀을 때 - 개인정보 수정페이지로
	public String mypageGo(Model model) {
		model.addAttribute("PopUp", 0);
		return "/mypage/myInfo";
	}

	@RequestMapping(value = "/modifyPass")
	// mypage 비밀번호변경 메뉴 눌렀을 때
	public String mypageModifyEmployerPassGo(Model model) {
		model.addAttribute("PopUp", 0);
		return "/mypage/modifyPass";
	}

	@RequestMapping(value = "/leaveAruba")
	// 사장 mypage 회원탈퇴 메뉴 눌렀을 때
	public String mypageLeaveEmployerArubaGo() {
		return "/mypage/leaveAruba";
	}

	// =============================================================== 사장 마이페이지

	@RequestMapping(value = "/wage")
	// 사장 mypage 메뉴에서 Wage(알바생들 줄 급여관리)
	public String mypageWageGo() {
		return "/myStore/wage";
	}

	// =============================================================== 알바 마이페이지

	@RequestMapping(value = "/salary")
	// 알바 mypage 메뉴에서 Salary(월급관리)
	public String mypageSalaryGo(Model model, HttpSession session) {
		Users loginUser = (Users) session.getAttribute("addUser");
		logger.trace("수업ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" + loginUser);
		List<Integer> codeList = cpService.selectComCodeByUserId(loginUser
				.getUserId());
		int first = -1;
		logger.trace("수업 CodeList : " + codeList);
		for (int i = 0; i < codeList.size(); i++) {
			model.addAttribute("code" + i, codeList.get(i).intValue());
			first = codeList.get(0).intValue();
		}

		// myJob들어갈때는 무조건 첫번째회사로 셋팅(없다면 -1들어갈것)
		model.addAttribute("nowCode", first);
		model.addAttribute("oneTime", true);

		return "/myJob/salary";
	}

	@RequestMapping(value = "/selectChart", method = RequestMethod.GET)
	public String selectChartGo(@RequestParam int companyCode,
			HttpSession session, Model model) {

		logger.trace("최대3개회사중 어떤거!!!!" + companyCode);

		Users loginUser = (Users) session.getAttribute("addUser");
		List<Integer> codeList = cpService.selectComCodeByUserId(loginUser
				.getUserId());
		for (int i = 0; i < codeList.size(); i++) {
			model.addAttribute("code" + i, codeList.get(i).intValue());
		}

		model.addAttribute("nowCode", companyCode);
		return "/myJob/salary";
	}

	// =============================================================== 시간표

	// ////////////사장 시간표 메뉴
	@RequestMapping(value = "/registerSchedule")
	public String registerScheduleGo(Model model, HttpSession session) { // 시간표
																			// -
																			// 시간표
																			// 등록
		Users user = (Users) session.getAttribute("addUser");
		String userId = user.getUserId();
		logger.trace("수업 UserId : " + user);
		// 나의 회사 코드 가져오기...!
		CompanyPerson companyperson = cpService
				.selectCompanyPersonByUserId(userId);
		int companyCode = companyperson.getCompanyCode();
		logger.trace("수업 CompanyCode : " + companyperson.getCompanyCode());
		// company_person에 가서 직원 아이디 갖고오기!!
		List<CompanyPerson> result = cpService.selectByCompanyCode(companyCode);
		logger.trace("수업 List : " + result);
		// memberId -> userId 찾기
		/*
		 * List<String> userIds = new ArrayList<String>(); for(int i = 0; i <
		 * result.size(); i++) { userIds.add(); }
		 */
		// logger.trace("수업 userIds : " + userIds);
		// userIds.add();
		for (int i = 0; i < result.size(); i++) {
			// logger.trace("수업....??" + result.get(i).getUserId());
			if (result.get(i).getUserId().equals(userId)) {
				// logger.trace("수업 : 안들어감...?");
				result.remove(i);
			}
		}

		logger.trace("수업 List : " + result);
		model.addAttribute("employees", result);

		return "/schedule/employer/registerSchedule";
	}

	@RequestMapping(value = "/modifySchedule")
	public String modifyScheduleGo(Model model, HttpSession session) { // 시간표 -
																		// 시간표
																		// 수정
		Users user = (Users) session.getAttribute("addUser");
		String userId = user.getUserId();
		logger.trace("수업 UserId : " + user);
		// 나의 회사 코드 가져오기...!
		CompanyPerson companyperson = cpService
				.selectCompanyPersonByUserId(userId);
		int companyCode = companyperson.getCompanyCode();
		logger.trace("수업 CompanyCode : " + companyperson.getCompanyCode());
		// company_person에 가서 직원 아이디 갖고오기!!
		List<CompanyPerson> result = cpService.selectByCompanyCode(companyCode);
		logger.trace("수업 List : " + result);
		// memberId -> userId 찾기
		/*
		 * List<String> userIds = new ArrayList<String>(); for(int i = 0; i <
		 * result.size(); i++) { userIds.add(); }
		 */
		// logger.trace("수업 userIds : " + userIds);
		// userIds.add();
		for (int i = 0; i < result.size(); i++) {
			// logger.trace("수업....??" + result.get(i).getUserId());
			if (result.get(i).getUserId().equals(userId)) {
				// logger.trace("수업 : 안들어감...?");
				result.remove(i);
			}
		}

		logger.trace("수업 List : " + result);
		model.addAttribute("employees", result);
		return "/schedule/employer/modifySchedule";
	}

	@RequestMapping(value = "/allSchedule")
	public String allScheduleGo(Model model, HttpSession session) { // 시간표 -
																	// 전체시간표 조회로
																	// 이동
		Users loginUser = (Users) session.getAttribute("addUser");
		CompanyPerson companyperson = cpService
				.selectCompanyPersonByUserId(loginUser.getUserId());
		model.addAttribute("code", companyperson.getCompanyCode());
		return "/schedule/employer/allSchedule";
	}

	// ////////////알바 시간표 메뉴
	@RequestMapping(value = "/mySchedule")
	public String myScheduleGo(HttpSession session, Model model) { // 시간표 - 내시간표
																	// 조회(직장별)
																	// --- > 일단
																	// 직장 1개...!
		Users loginUser = (Users) session.getAttribute("addUser");
		logger.trace("수업ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" + loginUser);
		List<Integer> codeList = cpService.selectComCodeByUserId(loginUser
				.getUserId());
		int first = -1;
		logger.trace("수업 CodeList : " + codeList);
		for (int i = 0; i < codeList.size(); i++) {
			model.addAttribute("code" + i, codeList.get(i).intValue());
			first = codeList.get(0).intValue();
		}

		// myJob들어갈때는 무조건 첫번째회사로 셋팅(없다면 -1들어갈것)
		model.addAttribute("nowCode", first);
		model.addAttribute("oneTime", true);

		return "/schedule/employee/mySchedule";
	}

	@RequestMapping(value = "/selectSchedule", method = RequestMethod.GET)
	public String selectScheduleGo(@RequestParam int companyCode,
			HttpSession session, Model model) {

		logger.trace("최대3개회사중 어떤거!!!!" + companyCode);

		Users loginUser = (Users) session.getAttribute("addUser");
		List<Integer> codeList = cpService.selectComCodeByUserId(loginUser
				.getUserId());
		for (int i = 0; i < codeList.size(); i++) {
			model.addAttribute("code" + i, codeList.get(i).intValue());
		}

		model.addAttribute("nowCode", companyCode);
		return "/schedule/employee/mySchedule";
	}

	// ///////////////////////////////////////////////////////////////////////////////////////////////////

	@ExceptionHandler
	public String LoginFail(LoginFailException e, HttpServletRequest request) {
		logger.trace("로그인실패했으니 로그인페이지 못벗어남!!!!");
		request.setAttribute("PopUp", 1);

		return "/login/login";
	}

	// /////////////////////////////////////////////////////////////////////////////////////////////////

}
