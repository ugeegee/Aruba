package com.bmj.exception;

public class ScheduleMenuFailException extends NullPointerException {
	public ScheduleMenuFailException(String msg){
		super("ScheduleMenuFailException입니다!!"+msg);
	}
}
