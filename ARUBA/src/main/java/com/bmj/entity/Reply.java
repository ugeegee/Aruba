package com.bmj.entity;

import java.util.Date;

public class Reply {

	private int replyNumber;
	private String userId;
	private int commentNumber;
	private String replyContent;
	private Date regDate;	
	
	public Reply(){}

	public int getReplyNumber() {
		return replyNumber;
	}

	public void setReplyNumber(int replyNumber) {
		this.replyNumber = replyNumber;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getCommentNumber() {
		return commentNumber;
	}

	public void setCommentNumber(int commentNumber) {
		this.commentNumber = commentNumber;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Reply [replyNumber=" + replyNumber + ", userId=" + userId
				+ ", commentNumber=" + commentNumber + ", replyContent="
				+ replyContent + ", regDate=" + regDate + "]";
	}
}
