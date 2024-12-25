package com.e.d.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.SubscriptionsEntity;

@Repository
public interface SubscriptionsRepository extends JpaRepository<SubscriptionsEntity, Long> {

}
