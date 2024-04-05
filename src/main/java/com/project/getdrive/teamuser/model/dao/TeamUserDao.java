package com.project.getdrive.teamuser.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.getdrive.common.CommonSch;
import com.project.getdrive.member.model.vo.Member;
import com.project.getdrive.team.common.TeamCreator;
import com.project.getdrive.team.model.vo.Team;
import com.project.getdrive.teamuser.model.vo.TeamUser;

@Repository("teamUserDao")
public class TeamUserDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int insertTeamLeader(Member member) {
		return sqlSessionTemplate.insert("teamUserMapper.insertTeamLeader", member);
	}

	public int selectMemberCount(int tNo) {
		return sqlSessionTemplate.selectOne("teamUserMapper.selectMemberCount", tNo);
	}

	public ArrayList<TeamUser> selectMembers(int tNo) {
		List<TeamUser> list= sqlSessionTemplate.selectList("teamUserMapper.selectMembers", tNo);
		return (ArrayList<TeamUser>) list;
	}

	public int insertTeamUser(TeamCreator teamCreator) {
		return sqlSessionTemplate.insert("teamUserMapper.insertTeamUser", teamCreator);
	}

	public int updateInvitedTeams(TeamUser teamUser) {
		return sqlSessionTemplate.update("teamUserMapper.updateInvitedTeams", teamUser);
	}

	public int deleteTeamUser(Team team) {
		return sqlSessionTemplate.update("teamUserMapper.deleteTeamUser", team);
	}

	public int removeAuth(Team teamLeader) {
		return sqlSessionTemplate.update("teamUserMapper.removeAuth", teamLeader);
	}

	public int upgradeAuth(Team teamUser) {
		return sqlSessionTemplate.update("teamUserMapper.upgradeAuth", teamUser);
	}
}
