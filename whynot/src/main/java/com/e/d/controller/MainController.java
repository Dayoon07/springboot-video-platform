package com.e.d.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.CommentEntity;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.SubscriptionsEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.LikeRepository;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.service.CommentService;
import com.e.d.model.service.CreatorService;
import com.e.d.model.service.LikeService;
import com.e.d.model.service.SubscriptionsService;
import com.e.d.model.service.VideosService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MainController {
	
	private final CommentRepository commentRepository;
	private final CreatorRepository creatorRepository;
	private final LikeRepository likeRepository;
	private final SubscriptionsRepository subscriptionsRepository;
	private final VideosRepository videosRepository;
	
	private final CommentService commentService;
	private final CreatorService creatorService;
	private final LikeService likeService;
	private final SubscriptionsService subscriptionsService;
	private final VideosService videosService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncode;
	
	protected void ipPrint() {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	    String ip = req.getHeader("X-FORWARDED-FOR");
	    if (ip == null || ip.isEmpty()) {
	        ip = req.getRemoteAddr();
	        if (ip.equals("0:0:0:0:0:0:0:1")) {
	            try {
	                ip = InetAddress.getLocalHost().getHostAddress();
	            } catch (UnknownHostException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    log.info("클라이언트 IP : {}", ip);
	    log.info("클라이언트 브라우저 종류 : {}", req.getHeader("User-Agent"));
	}
	
	@GetMapping("/")
	public String index(@RequestParam(defaultValue = "0") int page, Model model) {
	    int pageSize = 4;
	    Pageable pageable = PageRequest.of(page, pageSize, Sort.by(Direction.DESC, "videoId"));
	    Page<VideosEntity> videoPage = videosRepository.findAll(pageable);
	    
	    ipPrint();
	    
	    model.addAttribute("allVideo", videoPage.getContent());
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", videoPage.getTotalPages());
	    model.addAttribute("countVideos", videosRepository.count());
	    
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
		 try {
			 creatorService.creatorSignupFunction(creatorName, creatorEmail, creatorPassword, bio, tel, profileImgPath);
		 } catch (IOException e) {
			 e.printStackTrace();
	         return "redirect:/error";
		 }
		 return "redirect:/";
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
	
	@GetMapping("/channel/{creatorName}/videos")
	public String channelProfile(@PathVariable String creatorName, Model model, HttpSession session) {
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
		return "creator/channelVideo";
	}

	@GetMapping("/you")
	public String showCreatorProfile(HttpSession session, Model model) {
		return "creator/you";
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
        try {
            videosService.uploadVideo(creatorName, tag, title, more, imgPath, videoPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/";
    }
	
	@GetMapping("/watch")
    public String watchTheVideo(@RequestParam String v, Model model, HttpSession session) {
        try {
            Map<String, Object> videoDetails = videosService.watchVideo(v, session);
            model.addAllAttributes(videoDetails);
            return "video/watch";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/error";
        }
    }
	
	@Transactional
	@PostMapping("/commentAdd")
	public String addVideoComment(@RequestParam long commentVideo,
	                              @RequestParam String commentContent,
	                              @RequestParam long creatorId) throws UnsupportedEncodingException {
	    VideosEntity video = videosRepository.findById(commentVideo)
	            .orElseThrow(() -> new IllegalArgumentException("videoId가 비어있습니다"));
	    
	    Optional<CreatorEntity> creator = creatorRepository.findById(creatorId);
	    Optional<CreatorEntity> uploder = creatorRepository.findById(video.getCreatorVal());
	    
	    if (creator.isPresent()) {
	    	CommentEntity comment = CommentEntity.builder()
		            .commentVideo(commentVideo)
		            .commenter(creator.get().getCreatorName())
		            .commentUserid(uploder.get().getCreatorId())
		            .commenterUserid(creatorId)
		            .commenterProfile(creator.get().getProfileImg() != null ? creator.get().getProfileImg() : "없음")
		            .commenterProfilepath(creator.get().getProfileImgPath() != null ? creator.get().getProfileImgPath() : "없음")
		            .commentContent(commentContent)
		            .datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
		            .build();
		    commentRepository.save(comment);
	    }

	    return "redirect:/watch?v=" + URLEncoder.encode(video.getV(), "UTF-8");
	}
	
	@Transactional
	@PostMapping("/deleteComment")
	public String deleteComment(@RequestParam long commentId, @RequestParam long videoId) {
		commentRepository.deleteById(commentId);
		return "redirect:/watch?v=" + videosRepository.findById(videoId).get().getV();
	}
	
	@Transactional
	@PostMapping("/deleteCommentButAdminAccount")
	public String deleteCommentButAdminAccount(@RequestParam long commentId) {
		commentRepository.deleteById(commentId);
		return "redirect:/myVideo/analysis";
	}
	
	@Transactional
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

	    return "redirect:/channel/" + subscriber.get().getCreatorName();
	}
	
	@Transactional
	@PostMapping("/deleteSubscri")
	public String deleteMySubscri(@RequestParam long subscriberId, HttpSession session) {
	    CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
	    if (user == null) return "redirect:/login";

	    Optional<SubscriptionsEntity> mySubscribe = subscriptionsRepository.findBySubscriberIdAndSubscribingId(subscriberId, user.getCreatorId());
	    Optional<CreatorEntity> channel = creatorRepository.findById(subscriberId);
	    if (mySubscribe.isPresent()) {
	        subscriptionsRepository.deleteById(mySubscribe.get().getSubscriptionId());
	    }
	    
	    long subscriberCount = subscriptionsRepository.countBySubscriberId(subscriberId);
        CreatorEntity e = CreatorEntity.builder()
        		.creatorId(channel.get().getCreatorId())
        		.creatorName(channel.get().getCreatorName())
        		.creatorEmail(channel.get().getCreatorEmail())
        		.creatorPassword(channel.get().getCreatorPassword())
        		.createAt(channel.get().getCreateAt())
        		.bio(channel.get().getBio())
        		.tel(channel.get().getTel())
        		.profileImg(channel.get().getProfileImg())
        		.profileImgPath(channel.get().getProfileImgPath())
        		.subscribe(subscriberCount)
        		.build();
        creatorRepository.save(e);
	    
	    return "redirect:/mySubscri";
	}
	
	@GetMapping("/tag/{tag}")
	public String hashTag(@PathVariable String tag, Model model) {
		List<VideosEntity> videoTagList = videosRepository.findByTagOrderByVideoIdDesc(tag);
		model.addAttribute("videosTagList", videoTagList);
		model.addAttribute("tagWord", tag);
		return "tag/tag";
	}
	
	@GetMapping("/mySubscri")
	public String mySubscribingChannelsList(HttpSession session, Model model) {
	    CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");

	    if (user == null) return "creator/login";

	    // 내가 구독한 채널 정보 조회 (subscriberId 기준으로)
	    List<SubscriptionsEntity> mySubscriptions = subscriptionsRepository.findBySubscriberId(user.getCreatorId());

	    // 내가 구독한 채널들의 creatorId 가져오기
	    List<Long> subscribedChannelIds = mySubscriptions.stream()
	        .map(SubscriptionsEntity::getSubscribingId)  // subscribingId가 구독한 채널의 creatorId
	        .collect(Collectors.toList());

	    // 구독한 채널들의 상세 정보 조회 (한 번에)
	    List<CreatorEntity> subscribedChannels = creatorRepository.findByCreatorIdIn(subscribedChannelIds);

	    // 구독한 채널 목록을 Model에 추가하여 뷰로 전달
	    model.addAttribute("mySubscribeLists", subscribedChannels);

	    // 나를 구독한 사람들의 정보 조회 (subscribingId 기준으로)
	    List<SubscriptionsEntity> mySubscribers = subscriptionsRepository.findBySubscribingId(user.getCreatorId());

	    // 나를 구독한 사람들의 creatorId 가져오기
	    List<Long> subscriberIds = mySubscribers.stream()
	        .map(SubscriptionsEntity::getSubscriberId)  // subscriberId가 나를 구독한 사람들의 creatorId
	        .collect(Collectors.toList());

	    // 나를 구독한 사람들의 상세 정보 조회 (한 번에)
	    List<CreatorEntity> subscribers = creatorRepository.findByCreatorIdIn(subscriberIds);
	    model.addAttribute("mySubscribers", subscribers);
	    return "creator/mySubscriChannel";
	}

	@GetMapping("/myVideo")
	public String myVideo(HttpSession session, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) return "creator/login";
		m.addAttribute("myvideos", videosRepository.findByCreatorVal(user.getCreatorId()));
		return "dashboard/myVideo";
	}
	
	@GetMapping("/myVideo/dashboard")
	public String dashboardPage(HttpSession session, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user == null) return "creator/login";
		
		if (videosRepository.countByCreatorVal(user.getCreatorId()) != 0) {
			m.addAttribute("countMyVideos", videosRepository.countByCreatorVal(user.getCreatorId()));				// 내가 올린 영상
			m.addAttribute("commentCntMyVideos", commentRepository.countByCommenterUserid(user.getCreatorId()));	// 내 영상에 달린 모든 댓글 갯수
			m.addAttribute("sumMyVideosLikes", videosService.sumByMyVideoLikes(user.getCreatorId()));				// 내가 올린 영상의 모든 좋아요 수
			m.addAttribute("sumMyVideosViews", videosService.sumByMyVideoViews(user.getCreatorId()));				// 내가 올린 영상의 모든 조회수
		}
		
		return "dashboard/dashboard";
	}
	
	@GetMapping("/myVideo/analysis")
	public String myVideoAnalysis(HttpSession session, Model m) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		m.addAttribute("myVideoCommentList", commentRepository.findByCommentUserid(user.getCreatorId()));
		return session.getAttribute("creatorSession") != null ? "dashboard/videoAnalysis" : "creator/login";
	}
	
	@PostMapping("/myVideoDelete")
	public String myVideoDelete(HttpSession session, @RequestParam long videoId) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		if (user != null && videosRepository.findById(videoId).isPresent()) {
			videosRepository.deleteById(videoId);
		}
		return "redirect:/myVideo";
	}

	@PostMapping("/myVideoUpdate")
	public String myVideoUpdate(HttpSession session, @RequestParam long videoId, Model m) {
	    CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
	    Optional<VideosEntity> video = videosRepository.findById(videoId);
	    
	    if (user == null) return "creator/login";
	    if (video.isPresent() && user != null && user.getCreatorId() == video.get().getCreatorVal()) {
	        m.addAttribute("updatingVideo", video.get());
	        return "creator/myVideoUpdate";
	    }
	    return "redirect:/myVideo";
	}

	@Transactional
	@PostMapping("/updateVideo")
	public String updateVideo(@RequestParam Long videoId,  // 비디오 ID 추가
	                         @RequestParam String creatorName,
	                         @RequestParam String tag,
	                         @RequestParam String title,
	                         @RequestParam String more,
	                         @RequestParam(required = false) MultipartFile imgPath,  // 선택적 파일
	                         @RequestParam(required = false) MultipartFile videoPath,
	                         @RequestParam String currentImgPath,     // 현재 이미지 경로
	                         @RequestParam String currentVideoPath) { // 현재 비디오 경로 
	    // 비디오 엔티티 조회
	    Optional<VideosEntity> videoOptional = videosRepository.findById(videoId);
	    if (videoOptional.isEmpty()) {
	        return "redirect:/error";  // 비디오가 존재하지 않을 경우
	    }
	    VideosEntity existingVideo = videoOptional.get();

	    // 크리에이터 확인
	    Optional<CreatorEntity> user = creatorRepository.findByCreatorName(creatorName);
	    if (user.get().getCreatorName().isEmpty() && user.get().getCreatorName() == null) {
	        return "index";
	    }

	    // 새 파일명 생성 (새 파일이 업로드된 경우에만 사용)
	    String uuidTest = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy_MM_dd_HH_mm_ss"));
	    String imgName = currentImgPath;  // 기본값으로 현재 이미지명 사용
	    String videoName = currentVideoPath;  // 기본값으로 현재 비디오명 사용

	    try {
	        // 새 이미지가 업로드된 경우
	        if (imgPath != null && !imgPath.isEmpty()) {
	            // 이전 파일 삭제
	            String oldImgPath = "C:/youtubeProject/video-img/" + existingVideo.getImgName();
	            new File(oldImgPath).delete();

	            // 새 이미지 저장
	            imgName = uuidTest + "-" + imgPath.getOriginalFilename().trim().replaceAll(" ", "_");
	            String videoImgUploadDir = "C:/youtubeProject/video-img/";
	            File imgDir = new File(videoImgUploadDir);
	            if (!imgDir.exists()) imgDir.mkdirs();
	            imgPath.transferTo(new File(videoImgUploadDir + imgName));
	        }

	        // 새 비디오가 업로드된 경우
	        if (videoPath != null && !videoPath.isEmpty()) {
	            // 이전 파일 삭제
	            String oldVideoPath = "C:/youtubeProject/" + existingVideo.getVideoName();
	            new File(oldVideoPath).delete();

	            // 새 비디오 저장
	            videoName = uuidTest + "-" + videoPath.getOriginalFilename().trim().replaceAll(" ", "_");
	            String videoUploadDir = "C:/youtubeProject/";
	            File videoDir = new File(videoUploadDir);
	            if (!videoDir.exists()) videoDir.mkdirs();
	            videoPath.transferTo(new File(videoUploadDir + videoName));
	        }

	        // 엔티티 업데이트
	        existingVideo.setTitle(title);
	        existingVideo.setMore(more);
	        existingVideo.setTag(tag);
	        
	        // 새 파일이 업로드된 경우에만 파일 관련 정보 업데이트
	        if (imgPath != null && !imgPath.isEmpty()) {
	            existingVideo.setImgName(imgName);
	            existingVideo.setImgPath("/youtubeProject/video-img/" + imgName);
	        }
	        if (videoPath != null && !videoPath.isEmpty()) {
	            existingVideo.setVideoName(videoName);
	            existingVideo.setVideoPath("/youtubeProject/" + videoName);
	        }

	        videosRepository.save(existingVideo);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/";
	    }

	    return "dashboard/myVideo";
	}
	
	@GetMapping("/update")
	public String updateMeMovePage(HttpSession s, Model m) {
		return s.getAttribute("creatorSession") != null ? "creator/updateMe" : "index";
	}
	
	@PostMapping("/confirmPassword")
	public String confirmPassword(@RequestParam String creatorPassword, HttpSession s, Model m) {
	    CreatorEntity user = (CreatorEntity) s.getAttribute("creatorSession");
	    Optional<CreatorEntity> userInfo = creatorRepository.findById(user.getCreatorId());
	    if (user != null && userInfo.isPresent() && passwordEncode.matches(creatorPassword, user.getCreatorPassword())) {
	        m.addAttribute("creatorInfomation", userInfo.get());
	        m.addAttribute("realCreatorPassword", creatorPassword);
	        return "creator/realUpdateMe";
	    }
	    return "creator/login";
	}
	
	@PostMapping("/updateAboutMe")
	public String updateAboutMe(@RequestParam String creatorName,
	                             @RequestParam String creatorEmail,
	                             @RequestParam String creatorPassword,
	                             @RequestParam String bio,
	                             @RequestParam String tel,
	                             @RequestParam MultipartFile profileImgPath,
	                             HttpSession session) {
	    CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
	    Optional<CreatorEntity> info = creatorRepository.findById(user.getCreatorId());

	    String profileImg;
	    if (profileImgPath != null && !profileImgPath.isEmpty()) {
	        String fileName = UUID.randomUUID() + "_" + profileImgPath.getOriginalFilename().trim().replaceAll(" ", "_");
	        String uploadDir = "C:/youtubeProject/profile-img/";

	        File dir = new File(uploadDir);
	        if (!dir.exists()) dir.mkdirs();

	        try {
	            profileImgPath.transferTo(new File(uploadDir + fileName));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        profileImg = "/youtubeProject/profile-img/" + fileName;
	    } else {
	        profileImg = info.get().getProfileImgPath();
	    }

	    CreatorEntity entity = CreatorEntity.builder()
	            .creatorId(info.get().getCreatorId())
	            .creatorName(creatorName)
	            .creatorEmail(creatorEmail)
	            .creatorPassword(passwordEncode.encode(creatorPassword))
	            .createAt(info.get().getCreateAt())
	            .bio(bio)
	            .tel(tel)
	            .profileImg(profileImgPath.getOriginalFilename())
	            .profileImgPath(profileImg)
	            .subscribe(info.get().getSubscribe())
	            .build();

	    creatorRepository.save(entity);

	    return "creator/you";
	}

	@Transactional
	@PostMapping("/deleteAccount")
	public String deleteAccount(@RequestParam long creatorId, HttpSession session) {
	    log.info("deleteAccount 요청이 들어왔습니다. creatorId: {}", creatorId);

	    if (creatorRepository.findById(creatorId).isEmpty()) {
	        log.warn("creatorId {}에 해당하는 계정이 존재하지 않습니다.", creatorId);
	    } else {
	        log.info("creatorId {}에 해당하는 계정을 삭제합니다.", creatorId);
	        creatorRepository.deleteById(creatorId);
	        commentRepository.deleteByCommenterUserid(creatorId);
	        subscriptionsRepository.deleteBySubscribingId(creatorId);
	        videosRepository.deleteByCreatorVal(creatorId);
	        log.info("creatorId {}에 해당하는 계정을 성공적으로 삭제했습니다.", creatorId);
	    }
	    
	    session.invalidate();

	    return "index";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
