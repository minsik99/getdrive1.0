package com.project.getdrive.drive.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.getdrive.drive.handler.AwsS3;
import com.project.getdrive.drive.model.vo.Drive;
import com.project.getdrive.member.model.vo.Member;

@Controller
public class DriveController {
	private static final Logger logger = LoggerFactory.getLogger(DriveController.class);
	
	// 드라이브 메인으로 이동
	@RequestMapping("dmain.do")
	public String moveDriveMainPage(HttpServletRequest request, Model model) {
		
		Member member = (Member) request.getSession().getAttribute("loginMember");
		int tUID = member.getAccountNo();
		int tNo = (int) request.getSession().getAttribute("tNo");
		
		// insert를 위한 객체
		Drive drive = new Drive();
		drive.setdTID(tNo);
		drive.setdCRUID(tUID);
		
		// 아마존 SDK를 사용해서 AWS S3에 버킷 생성
		AwsS3 aws = new AwsS3();
		String bucketName = "testgetdrive";
		aws.createBucket(bucketName);
		
		String folderName = "test-folder/";
		aws.createFolder(bucketName, folderName);
		
		String objectName = "getdrive-object";
		String filePath = "C:\\Users\\kimmi\\Downloads\\trash.png";
		
		aws.uploadFile(bucketName, objectName, filePath);
		
		aws.downloadObject(bucketName, objectName, filePath);
		
		/* 2024.04.05 kimyh - 조장님 주석 요청
		// 드라이브 먼저 입장한다면 휴지통(고유번호: 1번) 먼저 생성한다
		/*
		 * if(driveService.insertTrashCan(drive) > 0) { }
		 */
		
		return "drive/driveMain";			
	}
}
