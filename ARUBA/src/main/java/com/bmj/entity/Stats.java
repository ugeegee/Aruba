package com.bmj.entity;

public class Stats {
	private String month;
	private int memberId;
	private double count;
	
	public Stats() {}
	
	public Stats(String month, int memberId, double count) {
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

	public double getCount() {
		return count;
	}

	public void setCount(double count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "Stats [month=" + month + ", memberId=" + memberId + ", count="
				+ count + "]";
	}
	
}
