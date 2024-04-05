package com.project.getdrive.chatuser.model.vo;

import java.sql.Date;

public class ChatUser {
	int cu_no; //채팅방 구성원 고유번호
	String cu_name; //구성원 이름
	char cu_cru; //개설자 여부
	Date cu_edate; //입장일자
	int cu_cid; //채팅방 고유번호
	int cu_tid; //팀 고유번호
	
	public ChatUser() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ChatUser(int cu_no, String cu_name, char cu_cru, Date cu_edate, int cu_cid, int cu_tid) {
		super();
		this.cu_no = cu_no;
		this.cu_name = cu_name;
		this.cu_cru = cu_cru;
		this.cu_edate = cu_edate;
		this.cu_cid = cu_cid;
		this.cu_tid = cu_tid;
	}
	
	public int getCu_no() {
		return cu_no;
	}
	public void setCu_no(int cu_no) {
		this.cu_no = cu_no;
	}
	public String getCu_name() {
		return cu_name;
	}
	public void setCu_name(String cu_name) {
		this.cu_name = cu_name;
	}
	public char getCu_cru() {
		return cu_cru;
	}
	public void setCu_cru(char cu_cru) {
		this.cu_cru = cu_cru;
	}
	public Date getCu_edate() {
		return cu_edate;
	}
	public void setCu_edate(Date cu_edate) {
		this.cu_edate = cu_edate;
	}
	public int getCu_cid() {
		return cu_cid;
	}
	public void setCu_cid(int cu_cid) {
		this.cu_cid = cu_cid;
	}
	public int getCu_tid() {
		return cu_tid;
	}
	public void setCu_tid(int cu_tid) {
		this.cu_tid = cu_tid;
	}
	
	@Override
	public String toString() {
		return "ChatUser [cu_no=" + cu_no + ", cu_name=" + cu_name + ", cu_cru=" + cu_cru + ", cu_edate=" + cu_edate
				+ ", cu_cid=" + cu_cid + ", cu_tid=" + cu_tid + "]";
	}
	public int getMemberNo() {
		// TODO Auto-generated method stub
		return 0;
	}
}
