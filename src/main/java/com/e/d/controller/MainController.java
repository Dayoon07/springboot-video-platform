package com.e.d.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.CommentEntity;
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
	
	@Autowired
	private BCryptPasswordEncoder passwordEncode;

	@GetMapping("/")
	public String index(Model model) {
		List<VideosEntity> videos = videosRepository.findAll(Sort.by(Direction.DESC, "videoId"));
		model.addAttribute("allVideo", videos);
		return "index";
	}
	
	@GetMapping("/search")
	public String searchMethod(@RequestParam String t, Model model) {
		List<VideosEntity> searchList = videosRepository.searchByTitleIgnoreCaseContaining(t);
		model.addAttribute("searchList", searchList);
		model.addAttribute("searchWord", t);
		return "video/search";
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
			@RequestParam String creatorName,
			@RequestParam String creatorPassword,
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
					log.info(creatorName + "이 로그인함 ( 고유 번호 : " + creatorList.get().getCreatorId() + " )");
				}
			}
		}
		return "redirect:/";
	}
	
	@PostMapping("/logout")
	public String logout(@RequestParam long creatorId, HttpSession session) {
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
						@RequestParam MultipartFile profileImgPath) {
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
	    CreatorEntity creator = creatorRepository.findByCreatorName(creatorName)
	                                              .orElseThrow(() -> new IllegalArgumentException("Creator not found"));
	    List<VideosEntity> videos = videosRepository.findByCreatorVal(creator.getCreatorId());
	    
	    model.addAttribute("creator", creator);
	    model.addAttribute("creatorVideosList", videos);
	    return "creator/channel";
	}

	@GetMapping("/you")
	public String showCreatorProfile(HttpSession session, Model model) {
	    CreatorEntity me = (CreatorEntity) session.getAttribute("creatorSession");
	    if (me == null || me.getCreatorName() == null || me.getCreatorName().isEmpty()) {
	        return "creator/login";
	    }
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
	public String upload(@RequestParam String creatorName,
			@RequestParam String title,
			@RequestParam String more,
			@RequestParam MultipartFile imgPath,
			@RequestParam MultipartFile videoPath) {
		
		Optional<CreatorEntity> user = creatorRepository.findByCreatorName(creatorName);
		
		if (user.get().getCreatorName().isEmpty() && user.get().getCreatorName() == null) {
			return "index";
		}
		
		String uuidTest = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy_MM_dd_HH_mm_ss"));
		String imgName = uuidTest + "-" + imgPath.getOriginalFilename().trim().replaceAll(" ", "_");
		String videoName = uuidTest + "-" + videoPath.getOriginalFilename().trim().replaceAll(" ", "_");
		    
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
					.creator(user.get().getCreatorName())
					.creatorVal(user.get().getCreatorId())
					.title(title)
					.more(more)
					.videoName(videoName)
					.videoPath("/youtubeProject/" + videoName)
					.imgName(imgName)
					.imgPath("/youtubeProject/video-img/" + imgName)
					.createAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
					.frontProfileImg(user.get().getProfileImgPath())
					.v(UUID.randomUUID().toString().replaceAll("-", ""))
					.build();
		    videosRepository.save(videoBuilder);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	@GetMapping("/watch")
	public String watchTheVideo(@RequestParam String v, Model model, HttpSession session) {
	    Optional<VideosEntity> list = videosRepository.findByV(v);
	    if (list.isPresent()) {
	        VideosEntity video = list.get();
	        Optional<CreatorEntity> creator = creatorRepository.findById(video.getCreatorVal());
	        List<CommentEntity> comment = commentRepository.findByCommentVideoOrderByCommentIdDesc(list.get().getVideoId());
	        CreatorEntity creatorList = (CreatorEntity) session.getAttribute("creatorSession");
	        
	        model.addAttribute("watchTheVideo", video);
	        model.addAttribute("videoCreatorProfileInfo", creator.orElse(null));
	        model.addAttribute("recentVideo", videosRepository.findAll(Sort.by(Direction.DESC, "videoId")));
	        model.addAttribute("watchTheVideoCommentList", comment);

	        if (creatorList != null) {
	            video.incrementVideoViews();
	            videosRepository.save(video); // 변경사항을 저장
	        }
	        return "video/watch";
	    }
	    return "redirect:/";
	}
	
	@PostMapping("/commentAdd")
	public String addVideoComment(@RequestParam long commentVideo,
	                              @RequestParam String commentContent,
	                              @RequestParam long creatorId) throws UnsupportedEncodingException {
	    VideosEntity video = videosRepository.findById(commentVideo)
	            .orElseThrow(() -> new IllegalArgumentException("videoId가 비어있습니다"));
	    
	    Optional<CreatorEntity> creator = creatorRepository.findById(creatorId);
	    
	    if (creator.isPresent()) {
	    	CommentEntity comment = CommentEntity.builder()
		            .commentVideo(commentVideo)
		            .commenter(creator.get().getCreatorName())
		            .commentUserid(creatorId)
		            .commenterProfile(creator.get().getProfileImg() != null ? creator.get().getProfileImg() : "없음")
		            .commenterProfilepath(creator.get().getProfileImgPath() != null ? creator.get().getProfileImgPath() : "없음")
		            .commentContent(commentContent)
		            .datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
		            .build();

		    commentRepository.save(comment);
	    }

	    return "redirect:/watch?v=" + URLEncoder.encode(video.getV(), "UTF-8");
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
