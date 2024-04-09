package com.project.getdrive.member.model.service;

import com.project.getdrive.member.model.vo.Member;
import com.project.getdrive.member.model.vo.Social_Member;

public interface Social_MemberService {

	int kakaoRegister(Social_Member social_member);
	int seletEmail(String email);
	void kakaoNomalRegister(Member member);
	int selectSocialEmail(String email);



	
}
