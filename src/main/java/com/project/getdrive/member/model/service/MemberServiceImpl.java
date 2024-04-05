package com.project.getdrive.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.getdrive.member.model.dao.MemberDao;
import com.project.getdrive.member.model.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired 
	private MemberDao memberDao;

	@Override
	public int register(Member member) {
		return memberDao.register(member);
	}

	@Override
	public Member login(Member member) {
		return memberDao.login(member);
	}

	@Override
	public Member selectMember(String email) {
		return memberDao.selectMember(email);
	}



}
