package com.e.d.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.e.d.model.repository.VideoImgRepository;

@Service
public class VideoImgService {

	@Autowired
	private VideoImgRepository videoImgRepository;
	
}
