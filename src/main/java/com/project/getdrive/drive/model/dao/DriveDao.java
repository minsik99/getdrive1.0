package com.project.getdrive.drive.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.getdrive.drive.model.vo.Drive;

@Repository("driveDao")
public class DriveDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int insertTrashCan(Drive drive) {
		return sqlSessionTemplate.insert("driveMapper.insertTrashCan", drive);
	}

	public int checkTrash(Drive drive) {
		return sqlSessionTemplate.selectOne("driveMapper.checkTrash", drive);
	}

	public ArrayList<Drive> selectDriveList(Drive drive) {
		List list = sqlSessionTemplate.selectList("driveMapper.selectDriveList", drive);
		return (ArrayList<Drive>) list;
	}
}
