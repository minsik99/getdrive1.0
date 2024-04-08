package com.project.getdrive.file.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.getdrive.drive.handler.AwsS3;
import com.project.getdrive.drive.model.service.DriveService;
import com.project.getdrive.drive.model.vo.Drive;
import com.project.getdrive.file.model.service.FileService;
import com.project.getdrive.file.model.vo.File;
import com.project.getdrive.folder.model.service.FolderService;
import com.project.getdrive.folder.model.vo.Folder;

@Controller
public class FileController {

	@Autowired
	private DriveService driveService;
	@Autowired
	private FolderService folderService;
	@Autowired
	private FileService fileService;
	
	// 파일 업로드
	@RequestMapping(value="upload.do", method={RequestMethod.POST, RequestMethod.GET})
    public String uploadFile(@RequestParam("file") MultipartFile file, Model model, File setFile) throws IOException {

		AwsS3 aws = new AwsS3();
		
		// 저장 위치 기록용 드라이브 추출
		Drive drive = driveService.selectDrive(setFile.getFlDID());
		// 저장 위치 기록용 폴더 추출
		Folder folder = folderService.selectFolder(setFile.getFlFDID());
		
		String fileName = file.getOriginalFilename();
		// 파일 확장자명을 알아내기 위한 인덱스 추출
		int lastIndex = fileName.lastIndexOf('.');
		setFile.setFlName(fileName);
		setFile.setFlExt(fileName.substring(lastIndex + 1));
		setFile.setFlLoc(drive.getdName() + "/" + folder.getFdName());
		setFile.setFlSize(file.getSize());
		
		aws.uploadFile("team"+drive.getdTID()+"drive-"+drive.getdNo(),
				folder.getFdName(), file.getOriginalFilename(), file.getInputStream());
		aws.listFoldersAndFiles("team"+drive.getdTID()+"drive-"+drive.getdNo());
		
        if (!file.isEmpty()) {
            try {
            	if(fileService.uploadFile(setFile) > 0) {
            		
            	}
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
        	model.addAttribute("message", "폴더 생성 실패");
			return "common/error";
        }
		return "redirect:fpage.do?fdTID=" + drive.getdTID() +
				"&fdDID=" + folder.getFdDID() + "&fdCRUID=" + folder.getFdCRUID()
				+ "&fdNo=" + folder.getFdNo();
    }
	
	// 파일 다운로드
	@RequestMapping(value="fdown.do", method=RequestMethod.POST)
	@ResponseBody
	public void fileDownload(@RequestParam("fileId") int flNo, HttpServletRequest request) {
		
		String savePath = request.getSession().getServletContext().getRealPath(
				"resources/drive_upfiles");
		
		AwsS3 aws = new AwsS3();
		
		File file = fileService.selectFile(flNo);
		Folder folder = folderService.selectFolder(file.getFlFDID());
		aws.listAllObjects("team"+file.getFlTID()+"drive-"+file.getFlDID());
		
		aws.downloadObject("team"+file.getFlTID()+"drive-"+file.getFlDID(),
							folder.getFdName() + "/" + file.getFlName(),
							savePath);
	}
	
	
	/*
	 * public byte[] downloadFile(@RequestParam("filename") String filename) throws
	 * IOException { // 클라우드에서 파일 다운로드 downloadFromCloud(filename);
	 * 
	 * // 다운로드된 파일 경로 String filePath = "/path/to/downloaded/files/" + filename;
	 * 
	 * // 파일을 읽어서 byte 배열로 변환 Path path = Paths.get(filePath); return
	 * Files.readAllBytes(path); }
	 */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
