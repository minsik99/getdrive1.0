package com.project.getdrive.drive.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DriveController {

	@RequestMapping("dmain.do")
	public String moveDriveMainPage() {
		return "drive/driveMain";
	}
}
