package com.e.d.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.VideosEntity;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.SubscriptionsRepository;
import com.e.d.model.repository.VideosRepository;

import jakarta.servlet.http.HttpSession;

@RestController
public class RestMainController {

	@Autowired
	private VideosRepository videosRepository;
	
	@Autowired
	private CreatorRepository creatorRepository;
	
	@Autowired
	private SubscriptionsRepository subscriptionsRepository;
	
	@GetMapping("/api/all")
	List<VideosEntity> list() {
		return videosRepository.findAll();
	}
	
	@GetMapping("/loadMore")
	public List<VideosEntity> loadMore(@RequestParam(defaultValue = "0") int page) {
	    int pageSize = 8;
	    Pageable pageable = PageRequest.of(page, pageSize, Sort.by(Direction.DESC, "videoId"));
	    Page<VideosEntity> videoPage = videosRepository.findAll(pageable);

	    return videoPage.getContent();
	}
	
	@GetMapping("/subscribeCount")
	public ResponseEntity<Long> subscribeCount(HttpSession s) {
	    CreatorEntity user = (CreatorEntity) s.getAttribute("creatorSession");
	    if (user == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(0L);
	    
	    return creatorRepository.findById(user.getCreatorId())
	        .map(creator -> ResponseEntity.ok(creator.getSubscribe()))
	        .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(0L));
	}
	
}
