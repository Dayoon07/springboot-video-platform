package com.e.d.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.SubscriptionsEntity;

@Repository
public interface SubscriptionsRepository extends JpaRepository<SubscriptionsEntity, Long> {
	List<SubscriptionsEntity> findBySubscriberIdAndSubscribingId(long subscriberId, long subscribingId);
	List<SubscriptionsEntity> findBySubscriberId(long subscriberId);
	long countBySubscriberId(long subscriberId);
}
