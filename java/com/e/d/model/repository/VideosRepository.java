package com.e.d.model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.VideosEntity;

@Repository
public interface VideosRepository extends JpaRepository<VideosEntity, Long> {
	List<VideosEntity> findByCreatorVal(long creatorVal);
	Optional<VideosEntity> findByV(String v);
	List<VideosEntity> searchByTitleIgnoreCaseContaining(String title);
}
