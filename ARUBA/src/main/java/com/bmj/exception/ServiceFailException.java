package com.bmj.exception;

public class ServiceFailException extends RuntimeException {
	public ServiceFailException(String msg){
		super(msg);
	}

}
