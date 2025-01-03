package com.e.d.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.e.d.model.entity.SubscriptionsEntity;
import com.e.d.model.repository.SubscriptionsRepository;

@RestController
public class RestMainController {

	@Autowired
	private SubscriptionsRepository repository;
	
	@GetMapping("/all")
	List<SubscriptionsEntity> list() {
		return repository.findAll();
	}
	
}
