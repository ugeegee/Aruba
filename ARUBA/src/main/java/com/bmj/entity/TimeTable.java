package com.bmj.entity;

import java.util.Date;

public class TimeTable {
	private int timeKey;
	private int companyCode;
	private int memberId;
	private Date workingDate;
	private String workingStart;
	private String workingEnd;
	
	public TimeTable() {}
	
	public TimeTable(int timeKey, int companyCode, int memberId,
			Date workingDate, String workingStart, String workingEnd) {
		this.timeKey = timeKey;
		this.companyCode = companyCode;
		this.memberId = memberId;
		this.workingDate = workingDate;
		this.workingStart = workingStart;
		this.workingEnd = workingEnd;
	}
	public int getTimeKey() {
		return timeKey;
	}
	public void setTimeKey(int timeKey) {
		this.timeKey = timeKey;
	}
	public int getCompanyCode() {
		return companyCode;
	}
	public void setCompanyCode(int companyCode) {
		this.companyCode = companyCode;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public Date getWorkingDate() {
		return workingDate;
	}
	public void setWorkingDate(Date workingDate) {
		this.workingDate = workingDate;
	}
	public String getWorkingStart() {
		return workingStart;
	}
	public void setWorkingStart(String workingStart) {
		this.workingStart = workingStart;
	}
	public String getWorkingEnd() {
		return workingEnd;
	}
	public void setWorkingEnd(String workingEnd) {
		this.workingEnd = workingEnd;
	}

	@Override
	public String toString() {
		return "TimeTable [timeKey=" + timeKey + ", companyCode=" + companyCode
				+ ", memberId=" + memberId + ", workingDate=" + workingDate
				+ ", workingStart=" + workingStart + ", workingEnd="
				+ workingEnd + "]";
	}	
}
