package com.bmj.entity;

import java.util.ArrayList;
import java.util.Date;

public class Users {
	private String userId;
	private String password;
	private String password2;
	private String userName;
	private String tel;
	private String email;
	private String birth;
	private String grade;
	private Date joinDate;
	private String question;
	private String answer;
	private ArrayList<CompanyPerson> cp;
	
	public Users() {}
	
	public Users(String userId, String password, String password2,
			String userName, String tel, String email, String birth,
			String grade, Date joinDate, String question, String answer) {
		this.userId = userId;
		this.password = password;
		this.password2 = password2;
		this.userName = userName;
		this.tel = tel;
		this.email = email;
		this.birth = birth;
		this.grade = grade;
		this.joinDate = joinDate;
		this.question = question;
		this.answer = answer;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirth() {
		return birth;
	}
	
	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Override
	public String toString() {
		return "users [userId=" + userId + ", password=" + password
				+ ", password2=" + password2 + ", userName=" + userName
				+ ", tel=" + tel + ", email=" + email + ", birth=" + birth
				+ ", grade=" + grade + ", joinDate=" + joinDate + ", question="
				+ question + ", answer=" + answer + "]";
	}
}
