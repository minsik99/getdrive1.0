package com.project.getdrive.chatcontent.model.vo;

import java.util.Date;

public class ChatContent {
	int cc_no; //채팅 고유번호
	String cc_content; //채팅 내용
	Date cc_cdate; //작성일자
	char cc_notice; //공지여부
	int cc_cruid; //작성자 고유번호
	int cc_cid; //채팅방 고유번호
	int cc_tid; //팀 고유번호
	//***  읽음 여부 객체 추가 필요
	
	public ChatContent() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ChatContent(int cc_no, String cc_content, Date cc_cdate, char cc_notice, int cc_cruid, int cc_cid,
			int cc_tid) {
		super();
		this.cc_no = cc_no;
		this.cc_content = cc_content;
		this.cc_cdate = cc_cdate;
		this.cc_notice = cc_notice;
		this.cc_cruid = cc_cruid;
		this.cc_cid = cc_cid;
		this.cc_tid = cc_tid;
	}
	
	public int getCc_no() {
		return cc_no;
	}
	public void setCc_no(int cc_no) {
		this.cc_no = cc_no;
	}
	public String getCc_content() {
		return cc_content;
	}
	public void setCc_content(String cc_content) {
		this.cc_content = cc_content;
	}
	public Date getCc_cdate() {
		return cc_cdate;
	}
	public void setCc_cdate(Date cc_cdate) {
		this.cc_cdate = cc_cdate;
	}
	public char getCc_notice() {
		return cc_notice;
	}
	public void setCc_notice(char cc_notice) {
		this.cc_notice = cc_notice;
	}
	public int getCc_cruid() {
		return cc_cruid;
	}
	public void setCc_cruid(int cc_cruid) {
		this.cc_cruid = cc_cruid;
	}
	public int getCc_cid() {
		return cc_cid;
	}
	public void setCc_cid(int cc_cid) {
		this.cc_cid = cc_cid;
	}
	public int getCc_tid() {
		return cc_tid;
	}
	public void setCc_tid(int cc_tid) {
		this.cc_tid = cc_tid;
	}
	
	@Override
	public String toString() {
		return "ChatContent [cc_no=" + cc_no + ", cc_content=" + cc_content + ", cc_cdate=" + cc_cdate + ", cc_notice="
				+ cc_notice + ", cc_cruid=" + cc_cruid + ", cc_cid=" + cc_cid + ", cc_tid=" + cc_tid + "]";
	}
	public void setSendTime(String format) {
		// TODO Auto-generated method stub
		
	}
	public int getTargetNo() {
		// TODO Auto-generated method stub
		return 0;
	}
	public int getSenderNo() {
		// TODO Auto-generated method stub
		return 0;
	}
}
