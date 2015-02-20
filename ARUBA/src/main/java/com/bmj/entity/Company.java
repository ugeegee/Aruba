package com.bmj.entity;

public class Company {
	private int companyCode;
	private String companyName;
	private String companyTel;
	private Float holidayComm;
	private Float nightComm;
	
	public Company() {}
	
	public Company(int companyCode, String companyName, String companyTel,
			Float holidayComm, Float nightComm) {
		this.companyCode = companyCode;
		this.companyName = companyName;
		this.companyTel = companyTel;
		this.holidayComm = holidayComm;
		this.nightComm = nightComm;
	}

	public int getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(int companyCode) {
		this.companyCode = companyCode;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyTel() {
		return companyTel;
	}

	public void setCompanyTel(String companyTel) {
		this.companyTel = companyTel;
	}

	public Float getHolidayComm() {
		return holidayComm;
	}

	public void setHolidayComm(Float holidayComm) {
		this.holidayComm = holidayComm;
	}

	public Float getNightComm() {
		return nightComm;
	}

	public void setNightComm(Float nightComm) {
		this.nightComm = nightComm;
	}

	@Override
	public String toString() {
		return "Company [companyCode=" + companyCode + ", companyName="
				+ companyName + ", companyTel=" + companyTel + ", holidayComm="
				+ holidayComm + ", nightComm=" + nightComm + "]";
	}
	
}
