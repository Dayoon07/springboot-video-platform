package com.e.d.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping("/all")
	List<VideosEntity> list() {
		return videosRepository.findAll();
	}
	
}
