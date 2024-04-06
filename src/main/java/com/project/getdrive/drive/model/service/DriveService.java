package com.project.getdrive.drive.model.service;

import com.project.getdrive.drive.model.vo.Drive;

public interface DriveService {

	int insertTrashCan(Drive drive);

	int checkTrash(Drive drive);

}
