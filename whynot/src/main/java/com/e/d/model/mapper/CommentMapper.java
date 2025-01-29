package com.e.d.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.vo.CommentVo;

@Mapper
public interface CommentMapper {
	List<CommentVo> findCommentsByKeyword(long myid, String keyword);
}
