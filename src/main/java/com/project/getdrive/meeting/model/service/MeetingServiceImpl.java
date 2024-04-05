package com.project.getdrive.meeting.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.getdrive.common.Paging;
import com.project.getdrive.meeting.model.dao.MeetingDao;
import com.project.getdrive.meeting.model.vo.Meeting;
import com.project.getdrive.team.common.SearchPaging;

@Service("meetingService")
public class MeetingServiceImpl implements MeetingService {
	@Autowired
	private MeetingDao meetingDao;

	@Override
	public int selectListCount() {
		return meetingDao.getListCount();
	}

	@Override
	public ArrayList<Meeting> selectList(Paging paging) {
		// TODO Auto-generated method stub
		return meetingDao.selectList(paging);
	}

	@Override
	public int insertMeeting(Meeting meeting) {
		return meetingDao.insertMeeing(meeting);
	}

	@Override
	public Meeting selectOne(int meetingId) {
		return meetingDao.selectOne(meetingId);
	}

	@Override
	public void updateAddReadCount(int meetingId) {
		meetingDao.addReadCount(meetingId);	
	}

	@Override
	public int updateMeeting(Meeting meeting) {
		return meetingDao.updateMeeting(meeting);
	}

	@Override
	public int deleteMeeting(int meetingId) {
		return meetingDao.deleteMeeting(meetingId);
	}

	@Override
	public int selectSearchTitleCount(String keyword) {
		return meetingDao.getSearchTitleCount(keyword);
	}

	@Override
	public ArrayList<Meeting> selectSearchTitle(SearchPaging search) {
		return meetingDao.selectSearchTitle(search);
	}

	@Override
	public int selectSearchContentCount(String keyword) {
		return meetingDao.getSearchContentCount(keyword);
	}

	@Override
	public ArrayList<Meeting> selectSearchContent(SearchPaging search) {
		return meetingDao.selectSearchContent(search);
	}

	@Override
	public int selectSearchDateCount(SearchPaging date) {
		return meetingDao.getSearchDateCount(date);
	}

	@Override
	public ArrayList<Meeting> selectSearchDate(SearchPaging search) {
		return meetingDao.selectSearchDate(search);
	}

	
	
	
	
	
	
}
