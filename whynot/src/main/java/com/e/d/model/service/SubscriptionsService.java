package com.e.d.model.service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.entity.SubscriptionsEntity;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.repository.SubscriptionsRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class SubscriptionsService {
	
	private final CreatorRepository creatorRepository;
	private final SubscriptionsRepository subscriptionsRepository;
	
	@Transactional
    public String subscribe(long subscriberId, long subscribingId) {
        Optional<CreatorEntity> subscriberOpt = creatorRepository.findById(subscriberId);
        Optional<CreatorEntity> subscribingOpt = creatorRepository.findById(subscribingId);

        if (subscriberOpt.isEmpty() || subscribingOpt.isEmpty()) {
            throw new IllegalArgumentException("해당 사용자를 찾을 수 없습니다.");
        }

        CreatorEntity subscriber = subscriberOpt.get();
        CreatorEntity subscribing = subscribingOpt.get();

        // 구독 정보 저장
        SubscriptionsEntity subscription = SubscriptionsEntity.builder()
                .subscriberName(subscriber.getCreatorName())
                .subscriberId(subscriberId)
                .subscribingName(subscribing.getCreatorName())
                .subscribingId(subscribingId)
                .subscribedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 a HH:mm:ss")))
                .build();
        subscriptionsRepository.save(subscription);

        // 구독자 수 업데이트
        long subscriberCount = subscriptionsRepository.countBySubscriberId(subscriberId);
        CreatorEntity updatedSubscriber = CreatorEntity.builder()
        		.creatorId(subscriberId)
        		.creatorName(subscriber.getCreatorName())
        		.creatorEmail(subscriber.getCreatorEmail())
        		.creatorPassword(subscriber.getCreatorPassword())
        		.createAt(subscriber.getCreateAt())
        		.bio(subscriber.getBio())
        		.tel(subscriber.getTel())
        		.profileImg(subscriber.getProfileImg())
        		.profileImgPath(subscriber.getProfileImgPath())
        		.subscribe(subscriberCount)
        		.build();
        creatorRepository.save(updatedSubscriber);

        log.info("{}님이 {}님을 구독했습니다.", subscribing.getCreatorName(), subscriber.getCreatorName());

        return "redirect:/channel/" + convertToUrlEncoded(subscriber.getCreatorName());
    }

	private String convertToUrlEncoded(String text) {
	    try {
	        return URLEncoder.encode(text, StandardCharsets.UTF_8.toString());
	    } catch (Exception e) {
	        log.error("URL 인코딩 중 오류 발생: {}", e.getMessage());
	        return text;
	    }
	}
	
}
