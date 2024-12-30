package com.e.d.model.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.CreatorEntity;

@Repository
public interface CreatorRepository extends JpaRepository<CreatorEntity, Long> {
	Optional<CreatorEntity> findByCreatorNameAndCreatorPassword(String creatorName, String creatorPassword);
	Optional<CreatorEntity> findByCreatorName(String creatorName);
	Optional<CreatorEntity> findByProfileImgPath(String profileImgPath);
}
