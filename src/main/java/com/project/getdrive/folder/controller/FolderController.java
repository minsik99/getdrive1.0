package com.project.getdrive.folder.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.getdrive.drive.handler.AwsS3;
import com.project.getdrive.drive.model.vo.Drive;
import com.project.getdrive.file.model.service.FileService;
import com.project.getdrive.file.model.vo.File;
import com.project.getdrive.folder.model.service.FolderService;
import com.project.getdrive.folder.model.vo.Folder;

@Controller
public class FolderController {

	@Autowired
	private FolderService folderService;
	@Autowired
	private FileService fileService;
	
	// 새 폴더 생성
	@RequestMapping(value="ifolder.do", method={RequestMethod.POST, RequestMethod.GET})
	public String createFolder(Model model, Drive drive,
			@RequestParam("flName") String flName) {
		
		drive.setdName(flName);
		
		if(folderService.createFolder(drive) > 0) {
			AwsS3 aws = new AwsS3();
			aws.createFolder("team"+drive.getdTID()+"drive-"+drive.getdNo(), flName);
			
			return "redirect:dpage.do";
		} else {
			model.addAttribute("message", "폴더 생성 실패");
			return "common/error";
		}
	}
	
	// 폴더 내부로 이동
	@RequestMapping(value="fpage.do", method={RequestMethod.POST, RequestMethod.GET})
	public String moveFolder(Model model, Folder folder) {
		
		Folder selectedFolder = folderService.selectFolder(folder.getFdNo());
		model.addAttribute("selectedFolder", selectedFolder);
		
		
		 ArrayList<File> list = fileService.selectFileList(folder.getFdNo()); 
		 if(list != null && list.size() > 0) { 
			 model.addAttribute("list", list); 
		 }
		 
		
		if(selectedFolder != null) {
			return "drive/folderDetail";
		} else {
			model.addAttribute("message", "폴더 진입 실패");
			return "common/error";
		}
	}
}
