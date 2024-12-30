package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_COMMENT")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "comment_id", nullable = false)
	private long commentId;
	
	@Column(name = "comment_video", nullable = false)
	private long commentVideo;
	
	@Column(name = "commenter", nullable = false)
	private String commenter;
	
	@Column(name = "commenter_userid", nullable = false)
	private long commentUserid;
	
	@Column(name = "commenter_profile", nullable = false)
	private String commenterProfile;
	
	@Column(name = "commenter_profilepath", nullable = false)
	private String commenterProfilepath;
	
	@Column(name = "comment_content", nullable = false)
	private String commentContent;
	
	@Column(name = "datetime", nullable = false)
	private String datetime;
	
}
