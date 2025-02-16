package com.e.d.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.dto.LikeVideosDto;

@Mapper
public interface VideosMapper {
	long sumByMyVideoViews(long creatorVal);
	long sumByMyVideoLikes(long creatorVal);
	int updateLike(long likes, long videoId);
	List<LikeVideosDto> selectByMyLikeVideo(long id);
}
