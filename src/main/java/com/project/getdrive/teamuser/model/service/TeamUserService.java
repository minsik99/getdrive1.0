package com.project.getdrive.teamuser.model.service;

import java.util.ArrayList;

import com.project.getdrive.member.model.vo.Member;
import com.project.getdrive.team.common.TeamCreator;
import com.project.getdrive.team.model.vo.Team;
import com.project.getdrive.teamuser.model.vo.TeamUser;

public interface TeamUserService {

	int insertTeamLeader(Member member);

	int selectMemberCount(int tNo);

	ArrayList<TeamUser> selectMembers(int tNo);

	int insertTeamUser(TeamCreator teamCreator);

	int updateInvitedTeams(TeamUser teamUser);

	int deleteTeamUser(Team team);

	int removeAuth(Team teamLeader);

	int upgradeAuth(Team teamUser);

}
