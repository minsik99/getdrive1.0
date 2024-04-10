package com.project.getdrive.search.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.getdrive.common.CommonSch;
import com.project.getdrive.search.model.dao.SearchDao;
import com.project.getdrive.search.model.vo.Search;

@Service("serviceService")
public class SearchServiceImpl implements SearchService {

	@Autowired
	private SearchDao searchDao;
	
	@Override
	public int selectSearchCount(CommonSch commonSch) {
		return searchDao.selectSearchCount(commonSch);
	}

	@Override
	public ArrayList<Search> selectSearch(CommonSch commonSch) {
		return searchDao.selectSearch(commonSch);
	}

	@Override
	public ArrayList<Search> selectAlarmList(int accountNo) {
		return searchDao.selectAlarmList(accountNo);
	}

}
