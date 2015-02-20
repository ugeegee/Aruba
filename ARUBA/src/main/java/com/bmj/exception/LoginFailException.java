package com.bmj.exception;

public class LoginFailException extends NullPointerException {
	public LoginFailException(String msg){
		super("LoginFailException입니다!!"+msg);
	}
}
