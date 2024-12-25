package com.e.d.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.e.d.model.repository.VideosRepository;

@Service
public class VideosService {

	@Autowired
	private VideosRepository repository;
	
}
