package com.bmj.exception;

public class RegisterJobException extends NullPointerException {
	public RegisterJobException(String msg){
		super("RegisterJobException입니다!!"+msg);
	}
}
