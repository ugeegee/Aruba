package com.bmj.entity;

import java.util.ArrayList;
import java.util.StringTokenizer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SaveTime {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(SaveTime.class);
	}
	private String id;
	private String title;		// userId
	private String start;
	private String end;
	private String color;
	
	public SaveTime() {}

	public SaveTime(Object obj) {
		logger.trace("수업 obj : " + obj);
		ArrayList<String> tmplist = new ArrayList<String>();
		
		StringTokenizer st1 = new StringTokenizer(obj.toString(), "\",{}");
		int i = 0;
		String context = "";

		while(st1.hasMoreTokens()) {
			context = st1.nextToken();
			logger.trace("수업 " + i + ", " + context);

			if ( i == 2 || i == 5 || i == 8 || i == 11) {
				tmplist.add(context);
			}
			i++;
		}
		logger.trace("list : " + tmplist);
		this.id = tmplist.get(0);
		this.title = tmplist.get(1);
		this.start = tmplist.get(2);
		this.end = tmplist.get(3);
		
	}
	
	
	public SaveTime(String id, String title, String start, String end) {
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}
	
	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	@Override
	public String toString() {
		return "SaveTime [id=" + id + ", title=" + title + ", start=" + start
				+ ", end=" + end + ", color=" + color + "]";
	}	
}
