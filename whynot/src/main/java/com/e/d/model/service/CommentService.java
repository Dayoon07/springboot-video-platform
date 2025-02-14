package com.e.d.model.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.e.d.model.entity.CommentEntity;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.mapper.CommentMapper;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.vo.CommentVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class CommentService {

	private final CommentRepository commentRepository;
	private final CreatorRepository creatorRepository;
	private final VideosRepository videosRepository;
	
	private final CommentMapper commentMapper;
	
	public List<CommentVo> findCommentsByKeyword(long myid, String keyword) {
		return commentMapper.findCommentsByKeyword(myid, keyword);
	}
	
	public void commentAdd(long commentVideo, long creatorId, String commentContent) {
		VideosEntity video = videosRepository.findById(commentVideo)
				.orElseThrow(() -> new IllegalArgumentException("videoId가 비어있습니다"));

		Optional<CreatorEntity> creator = creatorRepository.findById(creatorId);
		Optional<CreatorEntity> uploder = creatorRepository.findById(video.getCreatorVal());

		if (creator.isPresent()) {
			CommentEntity comment = CommentEntity.builder().commentVideo(commentVideo)
					.commenter(creator.get().getCreatorName()).commentUserid(uploder.get().getCreatorId())
					.commenterUserid(creatorId)
					.commenterProfile(creator.get().getProfileImg() != null ? creator.get().getProfileImg() : "없음")
					.commenterProfilepath(
							creator.get().getProfileImgPath() != null ? creator.get().getProfileImgPath() : "없음")
					.commentContent(commentContent)
					.datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))).build();
			commentRepository.save(comment);
		}
	}
	
}
