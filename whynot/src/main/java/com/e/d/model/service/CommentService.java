package com.e.d.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.e.d.model.mapper.CommentMapper;
import com.e.d.model.repository.CommentRepository;
import com.e.d.model.vo.CommentVo;

@Service
public class CommentService {

	@Autowired
	private CommentRepository commentRepository;
	
	@Autowired
	private CommentMapper commentMapper;
	
	public List<CommentVo> findCommentsByKeyword(long myid, String keyword) {
		return commentMapper.findCommentsByKeyword(myid, keyword);
	}
	
}
