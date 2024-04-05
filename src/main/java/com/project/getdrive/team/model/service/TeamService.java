package com.project.getdrive.team.model.service;

import java.util.ArrayList;

import com.project.getdrive.team.common.TeamCreator;
import com.project.getdrive.team.model.vo.Team;

public interface TeamService {

	ArrayList<Team> selectList();

	int insertTeam(TeamCreator teamCreator);

	Team selectTeam(int tNo);

	int updateTeamName(TeamCreator teamCreator);

	int selectDuplicate(String tName);

	int deleteTeam(int tNo);
}
