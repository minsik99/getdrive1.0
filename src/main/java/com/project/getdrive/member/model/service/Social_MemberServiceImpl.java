package com.project.getdrive.member.model.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.getdrive.member.model.dao.Social_MemberDao;
import com.project.getdrive.member.model.vo.Member;
import com.project.getdrive.member.model.vo.Social_Member;

@Service("social_MemberService")
public class Social_MemberServiceImpl implements Social_MemberService {
	
	@Autowired 
	private Social_MemberDao social_MemberDao;

	@Override
	public int kakaoRegister(Social_Member social_member) {
		return social_MemberDao.kakaoRegister(social_member);
	}

	@Override
	public int seletEmail(String email) {
		return social_MemberDao.seletEmail(email);
	}

	@Override
	public void kakaoNomalRegister(Member member) {
		social_MemberDao.kakaoNomalRegister(member);
		
	}

	@Override
	public int selectSocialEmail(String email) {
		return social_MemberDao.selectSocialEmail(email);
	}



}
