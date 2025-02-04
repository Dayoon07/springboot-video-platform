package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_VIDEOS")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VideosEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "video_id", nullable = false)
	private long videoId;
	
	@Column(name = "creator", nullable = false)
	private String creator;
	
	@Column(name = "creator_val", nullable = false)
	private long creatorVal;
	
	@Column(name = "title", nullable = false)
	private String title;
	
	@Column(name = "more")
	private String more;
	
	@Column(name = "video_name", nullable = false)
	private String videoName;
	
	@Column(name = "video_path", nullable = false)
	private String videoPath;
	
	@Column(name = "img_name", nullable = false)
	private String imgName;
	
	@Column(name = "img_path", nullable = false)
	private String imgPath;
	
	@Column(name = "create_at", nullable = false)
	private String createAt;
	
	@Column(name = "front_profile_img", nullable = false)
	private String frontProfileImg;
	
	@Column(name = "v", unique = true, nullable = false)
	private String v;
	
	@Column(name = "views")
	private long views;
	
	@Column(name = "likes")
	private long likes;
	
	@Column(name = "unlikes")
	private long unlikes;
	
	@Column(name = "comment_cnt")
	private long commentCnt;
	
	@Column(name = "tag")
	private String tag;
	
	public void incrementVideoViews() {
		this.views++;
	}
	
	public void updateVideo(String title, String more, String tag, String imgName, String videoName) {
        this.title = title;
        this.more = more;
        this.tag = tag;

        // 이미지 변경 시 업데이트
        if (imgName != null) {
            this.imgName = imgName;
            this.imgPath = "/youtubeProject/video-img/" + imgName;
        }

        // 비디오 변경 시 업데이트
        if (videoName != null) {
            this.videoName = videoName;
            this.videoPath = "/youtubeProject/" + videoName;
        }
    }
	
}