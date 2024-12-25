package com.e.d.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.e.d.model.entity.VideoImgEntity;

@Repository
public interface VideoImgRepository extends JpaRepository<VideoImgEntity, Long> {

}
