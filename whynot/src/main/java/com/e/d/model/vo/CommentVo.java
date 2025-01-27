package com.e.d.model.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentVo {
	private long commentId;
	private long commentVideo;
	private String commenter;
	private long commentUserid;
	private String commenterProfile;
	private String commenterProfilepath;
	private String commentContent;
	private String datetime;
}
