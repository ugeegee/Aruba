package com.bmj.exception;

public class ChartMenuFailException extends NullPointerException {
	public ChartMenuFailException(String msg){
		super("ChartMenuFailException입니다!!"+msg);
	}
}
