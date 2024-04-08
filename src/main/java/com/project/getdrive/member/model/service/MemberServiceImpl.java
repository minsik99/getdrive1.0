package com.project.getdrive.member.model.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.getdrive.member.model.dao.MemberDao;
import com.project.getdrive.member.model.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired 
	private MemberDao memberDao;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Override
	public int register(Member member) {
		
		member.setPwd(bcryptPasswordEncoder.encode(member.getPwd()));
		
		logger.info("after encode : " + member.getPwd());
		logger.info("pwd length : " + member.getPwd().length());
		
		return memberDao.register(member);
	}
	
	@Override
	public Member selectMember(String email) {
		return memberDao.selectMember(email);
	}

	@Override
	public Member login(Member member) {
		return memberDao.login(member);
	}

	@Override
	public int selectCheckEmail(String email) {
		return memberDao.selectCheckEmail(email);
	}

	@Override
	public boolean accountCheck(Member member) {

		member.setPwd(bcryptPasswordEncoder.encode(member.getPwd()));
		
		logger.info("after encode : " + member.getPwd());
		logger.info("pwd length : " + member.getPwd().length());
		
		return memberDao.accountCheck(member);
	}


	@Override
	public void updatePassword(Member member) {
		memberDao.updatePassword(member);
		
	}





	



}
