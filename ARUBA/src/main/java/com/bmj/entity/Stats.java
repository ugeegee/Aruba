package com.bmj.entity;

public class Stats {
	private String month;
	private int memberId;
	private int count;
	
	public Stats() {}
	
	public Stats(String month, int memberId, int count) {
		super();
		this.month = month;
		this.memberId = memberId;
		this.count = count;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "Stats [month=" + month + ", memberId=" + memberId + ", count="
				+ count + "]";
	}
	
}
