package com.bmj.entity;

import java.util.Date;

public class Message {
	private int messageNumber;
	private int companyCode;
	private String userId;				//보내는사람
	private String receiverId;			//받는사람
	private String messageContent;
	private Date regDate;
	private int flag;
	//확인여부가 불필요한 메세지 -1
	//미확인 0
	//승인 1
	//거절 2
	
	public Message() {}


	public Message(int messageNumber, int companyCode, String userId,
			String receiverId, String messageContent, Date regDate, int flag) {
		super();
		this.messageNumber = messageNumber;
		this.companyCode = companyCode;
		this.userId = userId;
		this.receiverId = receiverId;
		this.messageContent = messageContent;
		this.regDate = regDate;
		this.flag = flag;
	}


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

	public String getReceiverId() {
		return receiverId;
	}


	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}


	@Override
	public String toString() {
		return "Message [messageNumber=" + messageNumber + ", companyCode="
				+ companyCode + ", userId=" + userId + ", receiverId="
				+ receiverId + ", messageContent=" + messageContent
				+ ", regDate=" + regDate + ", flag=" + flag + "]";
	}


}
