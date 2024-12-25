package com.e.d.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.CreatorEntity;

@Repository
public interface CreatorRepository extends JpaRepository<CreatorEntity, Long> {

}
