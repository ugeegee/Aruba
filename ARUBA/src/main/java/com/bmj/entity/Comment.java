package com.bmj.entity;

import java.util.Date;

public class Comment {
	
	private int commentNumber;
	private String userId;
	private String commentContent;
	private Date regDate;
	private int flag;

	public Comment(){}

	public int getCommentNumber() {
		return commentNumber;
	}

	public void setCommentNumber(int commentNumber) {
		this.commentNumber = commentNumber;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
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
		return "Bcomment [commentNumber=" + commentNumber + ", userId="
				+ userId + ", commentContent=" + commentContent + ", regDate="
				+ regDate + ", flag=" + flag + "]";
	}
}
