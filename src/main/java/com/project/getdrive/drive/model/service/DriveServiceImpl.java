package com.project.getdrive.drive.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.getdrive.drive.model.dao.DriveDao;
import com.project.getdrive.drive.model.vo.Drive;

@Service("driveService")
public class DriveServiceImpl implements DriveService{

	@Autowired
	private DriveDao driveDao;

	@Override
	public int insertTrashCan(Drive drive) {
		return driveDao.insertTrashCan(drive);
	}
}
