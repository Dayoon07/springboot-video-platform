package com.e.d.model.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.dto.CreatorSubscriptionDto;
import com.e.d.model.entity.CreatorEntity;
import com.e.d.model.mapper.CreatorMapper;
import com.e.d.model.repository.CreatorRepository;
import com.e.d.model.vo.CreatorVo;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class CreatorService {

	private final CreatorRepository creatorRepository;
	private final CreatorMapper creatorMapper;
	private final PasswordEncoder passwordEncoder;

	public CreatorEntity creatorSignupFunction(String creatorName, String creatorEmail, String creatorPassword,
			String bio, String tel, MultipartFile profileImgPath) throws IOException {
		String fileName = UUID.randomUUID() + "_" + profileImgPath.getOriginalFilename().trim().replaceAll(" ", "_");
		String uploadDir = "C:/youtubeProject/profile-img/";
		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분"));

		File dir = new File(uploadDir);
		if (!dir.exists())
			dir.mkdirs();

		profileImgPath.transferTo(new File(uploadDir + fileName));

		CreatorEntity entity = CreatorEntity.builder().creatorName(creatorName).creatorEmail(creatorEmail)
				.creatorPassword(passwordEncoder.encode(creatorPassword)).createAt(now).bio(bio).tel(tel)
				.profileImg(profileImgPath.getOriginalFilename())
				.profileImgPath("/youtubeProject/profile-img/" + fileName).build();

		return creatorRepository.save(entity);
	}

	public CreatorEntity creatorSignupFunction2(String creatorName, String creatorEmail, String creatorPassword,
			String bio, String tel, MultipartFile profileImgPath, HttpSession session) throws IOException {
		String fileName = UUID.randomUUID() + "_" + profileImgPath.getOriginalFilename().trim().replaceAll(" ", "_");

		String uploadDir = session.getServletContext().getRealPath("/resources/profile-img/");

		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분"));

		// 파일 저장할 디렉토리 확인 후 생성
		File dir = new File(uploadDir);
		if (!dir.exists()) {
			dir.mkdirs(); // 디렉토리가 없으면 생성
		}

		profileImgPath.transferTo(new File(uploadDir + fileName));

		CreatorEntity entity = CreatorEntity.builder().creatorName(creatorName).creatorEmail(creatorEmail)
				.creatorPassword(passwordEncoder.encode(creatorPassword)).createAt(now).bio(bio).tel(tel)
				.profileImg(fileName) // 저장된 파일 이름 (UUID 포함)
				.profileImgPath("/resources/profile-img/" + fileName) // 클라이언트가 접근할 수 있는 상대 경로
				.build();

		return creatorRepository.save(entity);
	}

	public List<CreatorSubscriptionDto> selectBySubscribeUsername(String name, long id) {
		return creatorMapper.selectBySubscribeUsername(name, id);
	}

	public void updateAboutMe(Long creatorId, String creatorName, String creatorEmail, String creatorPassword,
			String bio, String tel, MultipartFile profileImgPath) {

		CreatorEntity creator = creatorRepository.findById(creatorId)
				.orElseThrow(() -> new IllegalArgumentException("존재하지 않는 사용자입니다."));

		// 프로필 이미지 저장
		String profileImg = saveProfileImage(profileImgPath, creator.getProfileImgPath());

		// 비밀번호 변경 여부 확인
		String encodedPassword = creatorPassword.isEmpty() ? creator.getCreatorPassword()
				: passwordEncoder.encode(creatorPassword);

		// 기존 데이터 업데이트
		creator.updateProfile(creatorName, creatorEmail, encodedPassword, bio, tel, profileImg);

		creatorRepository.save(creator);
	}

	private String saveProfileImage(MultipartFile profileImgPath, String currentProfileImg) {
		if (profileImgPath != null && !profileImgPath.isEmpty()) {
			String fileName = UUID.randomUUID() + "_"
					+ profileImgPath.getOriginalFilename().trim().replaceAll(" ", "_");
			String uploadDir = "C:/youtubeProject/profile-img/";

			File dir = new File(uploadDir);
			if (!dir.exists())
				dir.mkdirs();

			try {
				profileImgPath.transferTo(new File(uploadDir + fileName));
			} catch (IOException e) {
				throw new RuntimeException("파일 저장 실패", e);
			}
			return "/youtubeProject/profile-img/" + fileName;
		}
		return currentProfileImg; // 기존 이미지 유지
	}

}
