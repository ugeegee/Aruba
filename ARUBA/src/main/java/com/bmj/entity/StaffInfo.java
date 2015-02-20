package com.bmj.entity;


public class StaffInfo {
	
	private String userName;
	private String userId;
	private String tel;
	private String email;
	private int salary;
	private String hireDate;
	private int companyCode;
	
	public StaffInfo(){}

	public StaffInfo(String userName, String userId, String tel, String email,
			int salary, String hireDate, int companyCode) {
		super();
		this.userName = userName;
		this.userId = userId;
		this.tel = tel;
		this.email = email;
		this.salary = salary;
		this.hireDate = hireDate;
		this.companyCode = companyCode;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public String getHireDate() {
		return hireDate;
	}

	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}

	public int getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(int companyCode) {
		this.companyCode = companyCode;
	}

	
}
