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


}
