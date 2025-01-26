package com.e.d.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.e.d.model.entity.VideosEntity;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;

@RestController
public class RestMainController {

	@Autowired
	private VideosRepository videosRepository;
	
	@Autowired
	private SubscriptionsRepository subscriptionsRepository;
	
	@GetMapping("/api/all")
	List<VideosEntity> list() {
		return videosRepository.findAll();
	}
	
	@GetMapping("/loadMore")
	public List<VideosEntity> loadMore(@RequestParam(defaultValue = "0") int page) {
	    int pageSize = 8; // 한 번에 가져올 영상 개수
	    Pageable pageable = PageRequest.of(page, pageSize, Sort.by(Direction.DESC, "videoId"));
	    Page<VideosEntity> videoPage = videosRepository.findAll(pageable);

	    return videoPage.getContent();
	}
	
}
