package com.e.d.model.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.e.d.model.entity.LikeEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.mapper.LikeMapper;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.LikeRepository;
import com.e.d.model.repository.VideosRepository;
import com.e.d.model.vo.LikeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class LikeService {

	private final LikeRepository likeRepository;
	private final LikeMapper likeMapper;
	private final CreatorRepository creatorRepository;
	private final VideosRepository videosRepository;
	private final VideosService videosService;
	
	// 좋아요 등록
    @Transactional
    public void addLike(long videoId, String videoName, long creatorId) {
        if (likeRepository.existsByLikeVdoIdAndLikerId(videoId, creatorId)) {
            throw new IllegalStateException("이미 좋아요를 눌렀습니다.");
        }
        Optional<VideosEntity> vdo = videosRepository.findById(videoId);
        
        LikeEntity like = LikeEntity.builder()
            .likeVdoId(videoId)
            .likeVdoName(videoName)
            .likerId(creatorId)
            .likerName(creatorRepository.findById(creatorId).get().getCreatorName())
            .datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
            .build();
        
        videosService.updateLike(countVideoLikes(videoId), videoId);	// 좋아요를 받은 영상의 likes 필드를 update하는 함수
        likeRepository.save(like);	// like 테이블에 새로운 레코드를 추가하는 거
    }
    
    // 좋아요 취소
    @Transactional
    public void removeLike(long videoId, long likerId) {
        Optional<LikeEntity> like = likeRepository.findByLikeVdoIdAndLikerId(videoId, likerId);
        like.ifPresent(likeRepository::delete);
    }
    
    // 특정 동영상의 좋아요 개수 조회
    public long countLikes(long videoId) {
        return likeRepository.countByLikeVdoId(videoId);
    }
    
    public long countVideoLikes(long id) {
    	return likeMapper.countVideoLikes(id);
    }
	
    public Optional<LikeVo> likeOrNot(long likeVdoId, long likerId) {
    	return likeMapper.likeOrNot(likeVdoId, likerId);
    }
    
}
