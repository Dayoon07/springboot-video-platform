package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_V_IMG")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VideoImgEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "img_id", nullable = false)
	private long imgId;
	
	@Column(name = "video_num", nullable = false)
	private long videoNum;
	
	@Column(name = "filename", nullable = false)
	private String filename;
	
	@Column(name = "filepath", nullable = false)
	private String filepath;
	
	@Column(name = "create_at", nullable = false)
	private String createAt;

}
