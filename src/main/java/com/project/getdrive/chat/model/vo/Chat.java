package com.project.getdrive.chat.model.vo;

import java.sql.Date;

public class Chat {
	int c_no; //채팅방 고유번호
	String c_name; //채팅방명
	String c_desc; //채팅방 설명
	Date c_cdate; //채팅방 개설일
	int c_cruid; //채팅방 개설자 고유번호
	int c_tid; //팀 고유번호
	
	public Chat() {
		super();
	}
	public Chat(int c_no, String c_name, String c_desc, Date c_cdate, int c_cruid, int c_tid) {
		super();
		this.c_no = c_no;
		this.c_name = c_name;
		this.c_desc = c_desc;
		this.c_cdate = c_cdate;
		this.c_cruid = c_cruid;
		this.c_tid = c_tid;
	}
	
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_desc() {
		return c_desc;
	}
	public void setC_desc(String c_desc) {
		this.c_desc = c_desc;
	}
	public Date getC_cdate() {
		return c_cdate;
	}
	public void setC_cdate(Date c_cdate) {
		this.c_cdate = c_cdate;
	}
	public int getC_cruid() {
		return c_cruid;
	}
	public void setC_cruid(int c_cruid) {
		this.c_cruid = c_cruid;
	}
	public int getC_tid() {
		return c_tid;
	}
	public void setC_tid(int c_tid) {
		this.c_tid = c_tid;
	}
	
	@Override
	public String toString() {
		return "Chat [c_no=" + c_no + ", c_name=" + c_name + ", c_desc=" + c_desc + ", c_cdate=" + c_cdate
				+ ", c_cruid=" + c_cruid + ", c_tid=" + c_tid + "]";
	}
}
