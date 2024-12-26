package com.e.d.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.service.CommentService;
import com.e.d.model.service.CreatorService;
import com.e.d.model.service.SubscriptionsService;
import com.e.d.model.service.VideosService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MainController {
	
	private final CommentRepository commentRepository;
	private final CreatorRepository creatorRepository;
	private final SubscriptionsRepository subscriptionsRepository;
	private final VideosRepository videosRepository;
	
	private final CommentService commentService;
	private final CreatorService creatorService;
	private final SubscriptionsService subscriptionsService;
	private final VideosService videosService;

	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	@GetMapping("/login")
	public String moveLoginForm() {
		return "creator/login";
	}
	
	@GetMapping("/signup")
	public String moveSignupForm() {
		return "creator/signup";
	}
	
	@PostMapping("/loginF")
	public String login(
			@RequestParam("creatorName") String creatorName,
			@RequestParam("creatorPassword") String creatorPassword,
			HttpSession session) {
		Optional<CreatorEntity> creatorList = creatorRepository.findByCreatorNameAndCreatorPassword(creatorName, creatorPassword);
		
		// 입력값 검증
	    if (creatorName == null || creatorName.trim().isEmpty() || 
	        creatorPassword == null || creatorPassword.trim().isEmpty()) {
	        return "redirect:/";
	    }
		
		if (creatorList.isPresent()) {
			if (!(creatorName.isEmpty()) && creatorList.get().getCreatorName().equals(creatorName)) {
				if (!(creatorPassword.isEmpty()) && creatorList.get().getCreatorPassword().equals(creatorPassword)) {
					CreatorEntity creator = creatorList.get();
					session.setAttribute("creatorSession", creator);
				}
			}
		}
		log.info(creatorName + "이 로그인함 ( 고유 번호 : " + creatorList.get().getCreatorId() + " )");
		return "redirect:/";
	}
	
	@PostMapping("/logout")
	public String logout(@RequestParam("creatorId") long creatorId, HttpSession session) {
		CreatorEntity creator = creatorRepository.findById(creatorId).orElse(null);
		if (creator.getCreatorId() == creatorId) {
			session.invalidate();
		}
		log.info(creator.getCreatorName() + "이 로그아웃함 ( 고유 번호 : " + creator.getCreatorId() + " )");
		return "redirect:/";
	}
	
	@PostMapping("/signupF")
	public String signup(@RequestParam String creatorName,
						@RequestParam String creatorEmail, 
						@RequestParam String creatorPassword, 
						@RequestParam String bio, 
						@RequestParam String tel, 
						@RequestParam("profileImgPath") MultipartFile profileImgPath) {
	    String fileName = profileImgPath.getOriginalFilename().trim();
	    String uploadDir = "C:/youtubeProject/profile-img/";
	    File dir = new File(uploadDir);

	    if (!dir.exists()) dir.mkdirs();
	    
	    try {
	        profileImgPath.transferTo(new File(uploadDir + fileName));
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    CreatorEntity entity = CreatorEntity.builder()
	            .creatorName(creatorName)
	            .creatorEmail(creatorEmail)
	            .creatorPassword(creatorPassword)
	            .createAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
	            .bio(bio)
	            .tel(tel)
	            .profileImg(profileImgPath != null ? profileImgPath.getOriginalFilename() : null) // 파일 이름 저장
	            .profileImgPath(profileImgPath != null ? "/youtubeProject/profile-img/"+fileName : null) // 파일 경로 저장
	            .build();

	    creatorRepository.save(entity);

	    return "redirect:/"; // 회원가입 완료 후 리디렉션
	}
	
	@GetMapping("/channel/{creatorName}")
	public String creatorProfile(@PathVariable String creatorName, Model model) {
		Optional<CreatorEntity> creator = creatorRepository.findByCreatorName(creatorName);
		List<VideosEntity> video = videosRepository.findByCreatorVal(creator.get().getCreatorId());
		if (creator.isPresent() && !(video.isEmpty())) {
			model.addAttribute("creator", creator.get());
			model.addAttribute("creatorVideosList", video);
		}
		return "creator/channel";
	}

	@GetMapping("/you")
	public String heyYouYeahahYou(HttpSession session, Model model) {
		CreatorEntity me = (CreatorEntity) session.getAttribute("creatorSession");
		model.addAttribute("you", me);
		return "creator/you";
	}
	
	@GetMapping("/upload")
	public String moveOnUploadForm(HttpSession session) {
		if (session.getAttribute("creatorSession") != null) {			
			return "video/upload";
		} else {
			return "creator/login";
		}
	}
	
	@PostMapping("/uploadVideo")
	public String upload(@RequestParam long creatorId,
			@RequestParam String title,
			@RequestParam String more,
			@RequestParam MultipartFile imgPath,
			@RequestParam MultipartFile videoPath) {
		
		String uuidTest = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy_MM_dd_HH_mm"));
		String imgName = uuidTest + imgPath.getOriginalFilename().trim().replaceAll(" ", "_");
		String videoName = uuidTest + videoPath.getOriginalFilename().trim().replaceAll(" ", "_");
	    
		String videoImgUploadDir = "C:/youtubeProject/video-img/";
	    File imgDir = new File(videoImgUploadDir);
	    if (!imgDir.exists()) imgDir.mkdirs();
	    
	    String videoUploadDir = "C:/youtubeProject/";
	    File videoDir = new File(videoUploadDir);
	    if (!videoDir.exists()) videoDir.mkdirs();
	    
	    try {
	    	imgPath.transferTo(new File(videoImgUploadDir + imgName));
	    	videoPath.transferTo(new File(videoUploadDir + videoName));
	    	
	    	VideosEntity videoBuilder = VideosEntity.builder()
	    			.creator(creatorRepository.findById(creatorId).get().getCreatorName())
	    			.creatorVal(creatorId)
	    			.title(title)
	    			.more(more)
	    			.videoName(videoName)
	    			.videoPath("/youtubeProject/" + videoName)
	    			.imgName(imgName)
	    			.imgPath("/youtubeProject/video-img/" + imgName)
	    			.createAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
	    			.build();
	    	videosRepository.save(videoBuilder);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		return "redirect:/";
	}
	
}
