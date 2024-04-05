package com.project.getdrive.meeting.model.vo;

import java.sql.Date;

public class Meeting implements java.io.Serializable {
	private static final long serialVersionUID = 1401137704835676588L;

	private int meetingId;
	private String meetingTitle;
	private Date meetingDate;
	private Date meetingUpdate;
	private String meetingWriter;
	private String meetingContent;
	private String meetingOriginalFileName;
	private String meetingRenameFileName;
	private String importance;
	private Date impEndDate;
	private String readCount;
	private String m_teamid;
	
	public Meeting() {
		super();
	}
	public Meeting(int meetingId, String meetingTitle, Date meetingDate, Date meetingUpdate, String meetingWriter,
			String meetingContent, String meetingOriginalFileName, String meetingRenameFileName, String importance,
			Date impEndDate, String readCount, String m_teamid) {
		super();
		this.meetingId = meetingId;
		this.meetingTitle = meetingTitle;
		this.meetingDate = meetingDate;
		this.meetingUpdate = meetingUpdate;
		this.meetingWriter = meetingWriter;
		this.meetingContent = meetingContent;
		this.meetingOriginalFileName = meetingOriginalFileName;
		this.meetingRenameFileName = meetingRenameFileName;
		this.importance = importance;
		this.impEndDate = impEndDate;
		this.readCount = readCount;
		this.m_teamid = m_teamid;
	}
	
	public int getMeetingId() {
		return meetingId;
	}
	public void setMeetingId(int meetingId) {
		this.meetingId = meetingId;
	}
	public String getMeetingTitle() {
		return meetingTitle;
	}
	public void setMeetingTitle(String meetingTitle) {
		this.meetingTitle = meetingTitle;
	}
	public java.sql.Date getMeetingDate() {
		return meetingDate;
	}
	public void setMeetingDate(java.sql.Date meetingDate) {
		this.meetingDate = meetingDate;
	}
	public java.sql.Date getMeetingUpdate() {
		return meetingUpdate;
	}
	public void setMeetingUpdate(java.sql.Date meetingUpdate) {
		this.meetingUpdate = meetingUpdate;
	}
	public String getMeetingWriter() {
		return meetingWriter;
	}
	public void setMeetingWriter(String meetingWriter) {
		this.meetingWriter = meetingWriter;
	}
	public String getMeetingContent() {
		return meetingContent;
	}
	public void setMeetingContent(String meetingContent) {
		this.meetingContent = meetingContent;
	}
	public String getMeetingOriginalFileName() {
		return meetingOriginalFileName;
	}
	public void setMeetingOriginalFileName(String meetingOriginalFileName) {
		this.meetingOriginalFileName = meetingOriginalFileName;
	}
	public String getMeetingRenameFileName() {
		return meetingRenameFileName;
	}
	public void setMeetingRenameFileName(String meetingRenameFileName) {
		this.meetingRenameFileName = meetingRenameFileName;
	}
	public String getImportance() {
		return importance;
	}
	public void setImportance(String importance) {
		this.importance = importance;
	}
	public java.sql.Date getImpEndDate() {
		return impEndDate;
	}
	public void setImpEndDate(java.sql.Date impEndDate) {
		this.impEndDate = impEndDate;
	}
	public String getReadCount() {
		return readCount;
	}
	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}
	public String getM_teamid() {
		return m_teamid;
	}
	public void setM_teamid(String m_teamid) {
		this.m_teamid = m_teamid;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Override
	public String toString() {
		return "Meeting [meetingId=" + meetingId + ", meetingTitle=" + meetingTitle + ", meetingDate=" + meetingDate
				+ ", meetingUpdate=" + meetingUpdate + ", meetingWriter=" + meetingWriter + ", meetingContent="
				+ meetingContent + ", meetingOriginalFileName=" + meetingOriginalFileName + ", meetingRenameFileName="
				+ meetingRenameFileName + ", importance=" + importance + ", impEndDate=" + impEndDate + ", readCount="
				+ readCount + ", m_teamid=" + m_teamid + "]";
	}
	public void setOriginalFileName(String meetingOriginalFileName) {
		this.meetingOriginalFileName = meetingOriginalFileName;
	}
	public void setRenameFileName(String meetingRenameFileName) {
		this.meetingRenameFileName =meetingRenameFileName;
	}
	
}
