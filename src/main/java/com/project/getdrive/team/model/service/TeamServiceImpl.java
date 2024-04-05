package com.project.getdrive.team.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.getdrive.team.common.TeamCreator;
import com.project.getdrive.team.model.dao.TeamDao;
import com.project.getdrive.team.model.vo.Team;

@Service("teamService")
public class TeamServiceImpl implements TeamService{

	@Autowired
	private TeamDao teamDao;
	
	@Override
	public ArrayList<Team> selectList() {
		return teamDao.selectList();
	}

	@Override
	public int insertTeam(TeamCreator teamCreator) {
		return teamDao.insertTeam(teamCreator);
	}

	@Override
	public Team selectTeam(int tNo) {
		return teamDao.selectTeam(tNo);
	}

	@Override
	public int updateTeamName(TeamCreator teamCreator) {
		return teamDao.updateTeamName(teamCreator);
	}

	@Override
	public int selectDuplicate(String tName) {
		return teamDao.selectDuplicate(tName);
	}

	@Override
	public int deleteTeam(int tNo) {
		return teamDao.deleteTeam(tNo);
	}
	
}
