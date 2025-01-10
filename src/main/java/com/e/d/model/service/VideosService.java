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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.CommentEntity;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.SubscriptionsEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;

import jakarta.servlet.http.HttpSession;

@Service
public class VideosService {

    @Autowired
    private CreatorRepository creatorRepository;

    @Autowired
    private VideosRepository videosRepository;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private SubscriptionsRepository subscriptionsRepository;

    @Transactional
    public void uploadVideo(String creatorName, String tag, String title, String more,
                            MultipartFile imgPath, MultipartFile videoPath) throws IOException {
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
        if (!imgDir.exists()) imgDir.mkdirs();

        File videoDir = new File(videoUploadDir);
        if (!videoDir.exists()) videoDir.mkdirs();

        imgPath.transferTo(new File(videoImgUploadDir + imgName));
        videoPath.transferTo(new File(videoUploadDir + videoName));

        VideosEntity video = VideosEntity.builder()
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
        List<SubscriptionsEntity> subscriptions = subscriptionsRepository.findBySubscriberId(creator.get().getCreatorId());

        if (user != null) {
        	video.setViews(video.getViews() + 1);
            video.setCommentCount(comments.size());
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
}
