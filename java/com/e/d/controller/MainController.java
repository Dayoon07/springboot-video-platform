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
import com.e.d.model.entity.SubscriptionsEntity;
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
	    // 사용자 이름으로만 DB에서 사용자 정보 찾기
	    Optional<CreatorEntity> creatorOpt = creatorRepository.findByCreatorName(creatorName);
	    
	    // 입력값 검증
	    if (creatorName == null || creatorName.trim().isEmpty() || 
	        creatorPassword == null || creatorPassword.trim().isEmpty()) {
	        log.warn("로그인 시도 실패: 입력값이 비어있음.");
	        return "redirect:/";
	    }

	    if (creatorOpt.isPresent()) {
	        CreatorEntity creator = creatorOpt.get();
	        if (passwordEncode.matches(creatorPassword, creator.getCreatorPassword())) {
	            session.setAttribute("creatorSession", creator);
	            log.info("로그인 성공: 사용자 [{}], ID [{}]", creator.getCreatorName(), creator.getCreatorId());
	        } else {
	            log.warn("로그인 실패: 비밀번호 불일치 (사용자 [{}], ID [{}])", creator.getCreatorName(), creator.getCreatorId());
	        }
	    } else {
	        log.warn("로그인 실패: 사용자 이름 [{}]에 해당하는 계정을 찾을 수 없음.", creatorName);
	    }

	    return "redirect:/";
	}
	
	@PostMapping("/logout")
	public String logout(HttpSession session) {
		CreatorEntity creator = (CreatorEntity) session.getAttribute("creatorSession");
		if (creator != null) {
			log.info(creator.getCreatorName() + "이 로그아웃함 ( 고유 번호 : " + creator.getCreatorId() + " )");
			session.invalidate();
		}
		return "redirect:/";
	}
	
	@PostMapping("/signupF")
	public String signup(@RequestParam String creatorName,
						@RequestParam String creatorEmail, 
						@RequestParam String creatorPassword, 
						@RequestParam String bio, 
						@RequestParam String tel, 
						@RequestParam MultipartFile profileImgPath) {
	    String fileName = UUID.randomUUID() + profileImgPath.getOriginalFilename().trim().replaceAll(" ", "_");
	    String uploadDir = "C:/youtubeProject/profile-img/";
	    String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분"));

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
	            .creatorPassword(passwordEncode.encode(creatorPassword))
	            .createAt(now)
	            .bio(bio)
	            .tel(tel)
	            .profileImg(profileImgPath != null ? profileImgPath.getOriginalFilename() : "프로필 이미지 없음") // 파일 이름 저장
	            .profileImgPath(profileImgPath != null ? "/youtubeProject/profile-img/"+fileName : "프로필 이미지 없음") // 파일 경로 저장
	            .build();

	    creatorRepository.save(entity);

	    return "redirect:/"; // 회원가입 완료 후 리디렉션
	}
	
	@GetMapping("/channel/{creatorName}")
	public String creatorProfile(@PathVariable String creatorName, Model model, HttpSession session) {
	    // 채널 정보를 조회
	    Optional<CreatorEntity> creator = creatorRepository.findByCreatorName(creatorName);
	    List<VideosEntity> videos = videosRepository.findByCreatorVal(creator.get().getCreatorId());
	    CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
	    
	    List<SubscriptionsEntity> list = subscriptionsRepository.findBySubscriberId(creator.get().getCreatorId());
	    
	    if (creator.isPresent()) {
	    	model.addAttribute("creator", creator.get());
	    	model.addAttribute("creatorVideosList", videos);
	    }
	    if (user != null) {
	        // 구독 상태를 확인하여 모델에 추가
	        boolean isSubscribed = false;
	        for (SubscriptionsEntity subscription : list) {
	            if (subscription.getSubscribingId() == user.getCreatorId()) {
	                isSubscribed = true;
	                break;
	            }
	        }
	        model.addAttribute("isSubscribed", isSubscribed);  // 구독 여부
	    }
	    return "creator/channel";
	}

	@GetMapping("/you")
	public String showCreatorProfile(HttpSession session, Model model) {
		CreatorEntity me = (CreatorEntity) session.getAttribute("creatorSession");
	    if (me == null) {
	        return "creator/login";
	    } else {
	    	model.addAttribute("you", me);
	    	return "creator/you";
	    }
	}
	
	@GetMapping("/upload")
	public String moveOnUploadForm(HttpSession session) {
		return (session.getAttribute("creatorSession") != null) ? "video/upload" : "creator/login";
	}
	
	@PostMapping("/uploadVideo")
	public String upload(@RequestParam String creatorName,
			@RequestParam String tag,
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
					.tag(tag)
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
	        CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
	        List<SubscriptionsEntity> subscriList = subscriptionsRepository.findBySubscriberId(creator.get().getCreatorId());
	        
	        model.addAttribute("watchTheVideo", video);
	        model.addAttribute("videoCreatorProfileInfo", creator.get());
	        model.addAttribute("recentVideo", videosRepository.findAll(Sort.by(Direction.DESC, "videoId")));
	        model.addAttribute("watchTheVideoCommentList", comment);
		
	        if (user != null) {	// 사용자가 로그인을 하면
	            video.incrementVideoViews();	// 조회수를 1씩 증가
	            videosRepository.save(video);	// 조회수를 저장
	            // 구독 상태를 확인하여 모델에 추가
		        boolean isSubscribed = false;
		        for (SubscriptionsEntity subscription : subscriList) {	// entity에 forEach문으로 전부 다 비교
		            if (subscription.getSubscribingId() == user.getCreatorId()) {	// 해서 구독을 누른 사람인지 아닌지 확인하는 거
		                isSubscribed = true;	// 맞으면 멈추고 model에 저장하는 방식
		                break;
		            }
		        }
		        model.addAttribute("thisIsSubscribed", isSubscribed);  // 구독 여부
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
	
	@PostMapping("/subscri")
	public String subscri(@RequestParam long subscriberId, @RequestParam long subscribingId) {
	    Optional<CreatorEntity> subscriber = creatorRepository.findById(subscriberId);    // 구독을 받은 채널
	    Optional<CreatorEntity> subscribing = creatorRepository.findById(subscribingId);    // 구독한 사람
	    
	        // 구독 정보 저장
	        SubscriptionsEntity subscri = SubscriptionsEntity.builder()
	        		.subscriberName(subscriber.get().getCreatorName())
	        		.subscriberId(subscriberId)
	        		.subscribingName(subscribing.get().getCreatorName())
	        		.subscribingId(subscribingId)
	        		.subscribedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 a HH:mm:ss")))
	        		.build();
	        subscriptionsRepository.save(subscri);

	        long subscriberCount = subscriptionsRepository.countBySubscriberId(subscriberId);
	        CreatorEntity e = CreatorEntity.builder()
	        		.creatorId(subscriber.get().getCreatorId())
	        		.creatorName(subscriber.get().getCreatorName())
	        		.creatorEmail(subscriber.get().getCreatorEmail())
	        		.creatorPassword(subscriber.get().getCreatorPassword())
	        		.createAt(subscriber.get().getCreateAt())
	        		.bio(subscriber.get().getBio())
	        		.tel(subscriber.get().getTel())
	        		.profileImg(subscriber.get().getProfileImg())
	        		.profileImgPath(subscriber.get().getProfileImgPath())
	        		.subscribe(subscriberCount)
	        		.build();
	        creatorRepository.save(e);
	        
	        log.info(subscribing.get().getCreatorName() + "님이 " + subscriber.get().getCreatorName() + "님을 구독을 했습니다.");

	    return "redirect:/";
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
