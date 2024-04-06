package com.project.getdrive.drive.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.getdrive.drive.handler.AwsS3;
import com.project.getdrive.drive.model.service.DriveService;
import com.project.getdrive.drive.model.vo.Drive;
import com.project.getdrive.member.model.vo.Member;

@Controller
public class DriveController {
	private static final Logger logger = LoggerFactory.getLogger(DriveController.class);
	
	@Autowired
	private DriveService driveService;
	
	// 드라이브 메인으로 이동하자마자 휴지통 생성
	@RequestMapping("dmain.do")
	public String moveDriveMainPage(HttpServletRequest request, Model model) {
		
		Member member = (Member) request.getSession().getAttribute("loginMember");
		int tUID = member.getAccountNo();
		int tNo = (int) request.getSession().getAttribute("tNo");
		
		// insert를 위한 객체
		Drive drive = new Drive();
		drive.setdTID(tNo);
		drive.setdCRUID(tUID);
		
		// 휴지통 (index: 0, 드라이브 고유 번호: 1) 먼저 생성
		AwsS3 aws = new AwsS3();
		aws.createBucket("trash");
		aws.listBuckets();
		
		// 휴지통이 생성되지 않았다면 생성
		if(driveService.checkTrash(drive) <= 0) {
			driveService.insertTrashCan(drive);			
		}
		 
		return "drive/driveMain";			
	}
}
