package com.e.d.model.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.mapper.CreatorMapper;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.vo.CreatorVo;

@Service
public class CreatorService {

    @Autowired
    private CreatorRepository creatorRepository;
    
    @Autowired
    private CreatorMapper creatorMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public CreatorEntity creatorSignupFunction(String creatorName,
							    		String creatorEmail,
							    		String creatorPassword,
							    		String bio,
							    		String tel,
							    		MultipartFile profileImgPath) throws IOException {
        String fileName = UUID.randomUUID() + "_" + profileImgPath.getOriginalFilename().trim().replaceAll(" ", "_");
        String uploadDir = "C:/youtubeProject/profile-img/";
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분"));

        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        profileImgPath.transferTo(new File(uploadDir + fileName));

        CreatorEntity entity = CreatorEntity.builder()
                .creatorName(creatorName)
                .creatorEmail(creatorEmail)
                .creatorPassword(passwordEncoder.encode(creatorPassword))
                .createAt(now)
                .bio(bio)
                .tel(tel)
                .profileImg(profileImgPath.getOriginalFilename())
                .profileImgPath("/youtubeProject/profile-img/" + fileName)
                .build();

        return creatorRepository.save(entity);
    }
    
    public List<CreatorVo> selectBySubscribeUsername(String name, long id) {
    	return creatorMapper.selectBySubscribeUsername(name, id);
    }

}
