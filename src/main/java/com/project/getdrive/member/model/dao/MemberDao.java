package com.project.getdrive.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.getdrive.member.model.vo.Member;

@Repository("memberDao")
public class MemberDao {
	
	@Autowired 
	private SqlSessionTemplate sqlSessionTemplate;

	public int register(Member member) {
		return sqlSessionTemplate.insert("memberMapper.register", member);
	}

	public Member login(Member member) {
		return sqlSessionTemplate.selectOne("memberMapper.login", member);
	}

	public Member selectMember(String email) {
		return sqlSessionTemplate.selectOne("memberMapper.selectMember", email);
	}

	public int selectCheckEmail(String email) {
		return sqlSessionTemplate.selectOne("memberMapper.selectCheckEmail", email);
	}


	public boolean accountCheck(Member member) {
		return sqlSessionTemplate.selectOne("memberMapper.accountCheck", member);
	}

	public void updatePassword(Member member) {
		sqlSessionTemplate.update("memberMapper.updatePassword",member);
		
	}



}
