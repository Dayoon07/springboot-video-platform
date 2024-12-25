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
	
	@Column(name = "comment_content", nullable = false)
	private String commentContent;
	
	@Column(name = "datetime", nullable = false)
	private String datetime;
	
}
