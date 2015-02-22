package com.bmj.entity;

import java.util.Date;

public class Message {
	private int messageNumber;
	private int companyCode;
	private String userId;
	private String messageContent;
	private Date regDate;
	private int flag;
	//확인여부가 불필요한 메세지 -1
	//미확인 0
	//확인 1
	
	public Message() {}

	public int getMessageNumber() {
		return messageNumber;
	}

	public void setMessageNumber(int messageNumber) {
		this.messageNumber = messageNumber;
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

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		return "Message [messageNumber=" + messageNumber + ", companyCode="
				+ companyCode + ", userId=" + userId + ", messageContent="
				+ messageContent + ", regDate=" + regDate + ", flag=" + flag
				+ "]";
	}
}
