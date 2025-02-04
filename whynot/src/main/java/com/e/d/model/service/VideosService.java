package com.e.d.model.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.CommentEntity;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.SubscriptionsEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.mapper.VideosMapper;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class VideosService {

	private final CreatorRepository creatorRepository;
	private final VideosRepository videosRepository;
	private final CommentRepository commentRepository;
	private final SubscriptionsRepository subscriptionsRepository;
	private final VideosMapper mapper;

	@Transactional
	public void uploadVideo(String creatorName, String tag, String title, String more, MultipartFile imgPath,
			MultipartFile videoPath) throws IOException {
		Optional<CreatorEntity> user = creatorRepository.findByCreatorName(creatorName);

		if (user.isEmpty() || user.get().getCreatorName() == null || user.get().getCreatorName().isEmpty()) {
			throw new IllegalArgumentException("Creator not found");
		}

		String uuidTest = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy_MM_dd_HH_mm_ss"));
		String imgName = uuidTest + "-" + imgPath.getOriginalFilename().trim().replaceAll(" ", "_");
		String videoName = uuidTest + "-" + videoPath.getOriginalFilename().trim().replaceAll(" ", "_");

		String videoImgUploadDir = "C:/youtubeProject/video-img/";
		String videoUploadDir = "C:/youtubeProject/";

		File imgDir = new File(videoImgUploadDir);
		if (!imgDir.exists())
			imgDir.mkdirs();

		File videoDir = new File(videoUploadDir);
		if (!videoDir.exists())
			videoDir.mkdirs();

		imgPath.transferTo(new File(videoImgUploadDir + imgName));
		videoPath.transferTo(new File(videoUploadDir + videoName));

		VideosEntity video = VideosEntity.builder().creator(user.get().getCreatorName())
				.creatorVal(user.get().getCreatorId()).title(title).more(more).videoName(videoName)
				.videoPath("/youtubeProject/" + videoName).imgName(imgName)
				.imgPath("/youtubeProject/video-img/" + imgName)
				.createAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
				.frontProfileImg(user.get().getProfileImgPath()).v(UUID.randomUUID().toString().replaceAll("-", ""))
				.tag(tag).build();

		videosRepository.save(video);
	}

	@Transactional
	public Map<String, Object> watchVideo(String v, HttpSession session) {
		Optional<VideosEntity> optionalVideo = videosRepository.findByV(v);
		if (optionalVideo.isEmpty()) {
			throw new IllegalArgumentException("Video not found");
		}

		VideosEntity video = optionalVideo.get();
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		Optional<CreatorEntity> creator = creatorRepository.findById(video.getCreatorVal());
		List<CommentEntity> comments = commentRepository.findByCommentVideoOrderByCommentIdDesc(video.getVideoId());
		List<SubscriptionsEntity> subscriptions = subscriptionsRepository
				.findBySubscriberId(creator.get().getCreatorId());

		if (user != null) {
			video.setViews(video.getViews() + 1);
			video.setCommentCnt(comments.size());
			videosRepository.save(video);
		}

		boolean isSubscribed = user != null && subscriptions.stream()
				.anyMatch(subscription -> subscription.getSubscribingId() == user.getCreatorId());

		Map<String, Object> response = new HashMap<>();
		response.put("watchTheVideo", video);
		response.put("videoCreatorProfileInfo", creator.orElse(null));
		response.put("recentVideo", videosRepository.findAll(Sort.by(Direction.DESC, "videoId")));
		response.put("watchTheVideoCommentList", comments);
		response.put("thisIsSubscribed", isSubscribed);

		return response;
	}

	public long sumByMyVideoViews(long creatorVal) {
		return mapper.sumByMyVideoViews(creatorVal);
	}

	public long sumByMyVideoLikes(long creatorVal) {
		return mapper.sumByMyVideoLikes(creatorVal);
	}

	public void updateLike(long likes, long videoId) {
		mapper.updateLike(likes, videoId);
	}

	@Transactional
	public void updateVideo(Long videoId, String creatorName, String tag, String title, String more,
			MultipartFile imgPath, MultipartFile videoPath, String currentImgPath, String currentVideoPath) {

		// 비디오 조회
		VideosEntity existingVideo = videosRepository.findById(videoId)
				.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 비디오입니다."));

		// 크리에이터 검증
		CreatorEntity creator = creatorRepository.findByCreatorName(creatorName)
				.orElseThrow(() -> new IllegalArgumentException("크리에이터를 찾을 수 없습니다."));

		// 새 파일명 생성 (새 파일이 업로드된 경우에만 사용)
		String uuidTest = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy_MM_dd_HH_mm_ss"));
		String imgName = existingVideo.getImgName(); // 기본값: 기존 이미지명 유지
		String videoName = existingVideo.getVideoName(); // 기본값: 기존 비디오명 유지

		try {
			// 새 이미지 저장
			if (imgPath != null && !imgPath.isEmpty()) {
				deleteFile("C:/youtubeProject/video-img/" + existingVideo.getImgName());
				imgName = uuidTest + "-" + imgPath.getOriginalFilename().trim().replaceAll(" ", "_");
				saveFile(imgPath, "C:/youtubeProject/video-img/", imgName);
			}

			// 새 비디오 저장 (비디오 변경이 있을 때만 수행)
			if (videoPath != null && !videoPath.isEmpty()) {
				deleteFile("C:/youtubeProject/" + existingVideo.getVideoName());
				videoName = uuidTest + "-" + videoPath.getOriginalFilename().trim().replaceAll(" ", "_");
				saveFile(videoPath, "C:/youtubeProject/", videoName);
			}

			// 엔티티 업데이트 (비디오를 바꾸지 않았다면 기존 경로 유지)
			existingVideo.updateVideo(title, more, tag, imgName, videoName);
			videosRepository.save(existingVideo);

		} catch (IOException e) {
			throw new RuntimeException("파일 처리 중 오류 발생", e);
		}
	}

	private void saveFile(MultipartFile file, String directory, String fileName) throws IOException {
		File dir = new File(directory);
		if (!dir.exists())
			dir.mkdirs();
		file.transferTo(new File(directory + fileName));
	}

	private void deleteFile(String filePath) {
		File file = new File(filePath);
		if (file.exists())
			file.delete();
	}

}
