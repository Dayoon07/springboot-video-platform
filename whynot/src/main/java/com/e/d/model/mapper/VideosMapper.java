package com.e.d.model.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface VideosMapper {
	long sumByMyVideoViews(long creatorVal);
	long sumByMyVideoLikes(long creatorVal);
	int updateLike(long likes, long videoId);
}
