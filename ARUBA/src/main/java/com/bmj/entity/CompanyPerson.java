package com.bmj.entity;

public class CompanyPerson {
	private int memberId;
	private int companyCode;
	private String userId;
	private int salary;
	private String hireDate;
	
	public CompanyPerson() {}
	
	public CompanyPerson(int memberId, int companyCode, String userId, int salary,
			String hireDate) {
		this.companyCode = companyCode;
		this.userId = userId;
		this.salary = salary;
		this.hireDate = hireDate;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(int companyCode) {
		this.companyCode = companyCode;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	@Override
	public String toString() {
		return "CompanyPerson [memberId=" + memberId + ", companyCode="
				+ companyCode + ", userId=" + userId + ", salary=" + salary
				+ ", hireDate=" + hireDate + "]";
	}


	
	
}
