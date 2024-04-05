package com.project.getdrive.meeting.model.service;

import java.util.ArrayList;

import com.project.getdrive.common.Paging;
import com.project.getdrive.meeting.model.vo.Meeting;
import com.project.getdrive.team.common.SearchPaging;

public interface MeetingService {

	int selectListCount();

	ArrayList<Meeting> selectList(Paging paging);

	int insertMeeting(Meeting meeting);

	Meeting selectOne(int meetingId);

	void updateAddReadCount(int meetingId);

	int updateMeeting(Meeting meeting);

	int deleteMeeting(int meetingId);

	int selectSearchTitleCount(String keyword);

	ArrayList<Meeting> selectSearchTitle(SearchPaging search);

	int selectSearchContentCount(String keyword);

	ArrayList<Meeting> selectSearchContent(SearchPaging search);

	int selectSearchDateCount(SearchPaging search);

	ArrayList<Meeting> selectSearchDate(SearchPaging search);

}
