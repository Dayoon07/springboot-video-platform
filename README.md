## 프로젝트명 : springboot-video-platform

### <a href="https://dayoon07.github.io/video/video-platform.mp4" target="_blank">테스트 영상</a>

### 목차
1. [프로젝트 소개](#프로젝트-소개)
2. [개발 기간](#개발-기간)
3. [IDE](#ide)
4. [서버](#서버)
5. [프레임워크](#프레임워크)
6. [언어](#언어)
7. [라이브러리](#라이브러리)
8. [빌드 도구](#빌드-도구)
9. [설계 도구](#설계-도구)
10. [ERD](#erd)
11. [기능 설명](#기능-설명)

<br>

## 프로젝트 소개
<p style="font-size: 24px;">
  Spring Boot, MyBatis 프레임워크와 JPA를 사용해 만들었으며
  주요 기능으로는 비디오 CRUD, 댓글 CRUD, 구독 기능, 좋아요 표시 기능, 영상 분석 기능이 
  있습니다. <br>
  (배포 안함)
</p>

## 개발 기간
<p style="font-size: large;">2024. 12. 25 ~ 2025. 03. 09</p>

## IDE

<div align="center">
  <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRtQyXi1necbFlJOetK3_3MHaLeHDGZ-C3pw&s" width="150" height="150">
  <img src="https://upload.wikimedia.org/wikipedia/en/thumb/6/68/Oracle_SQL_Developer_logo.svg/800px-Oracle_SQL_Developer_logo.svg.png" width="150" height="150">
</div>

## 서버
- Spring Boot 내장 서버

## 프레임워크

<div align="center">
  <img src="https://velog.velcdn.com/images/alsgudtkwjs/post/7e8d4ffb-67bb-441a-87f4-be01d1ede318/image.png" width="300" height="245">
  <img src="https://taetaetae.github.io/images/mybatis-useGeneratedKeys/mybatis.png" width="360">
  <img src="https://getlogovector.com/wp-content/uploads/2021/01/tailwind-css-logo-vector.png" width="350">
</div>

## 언어

<div align="center">
  <img src="https://static-00.iconduck.com/assets.00/java-original-icon-756x1024-j3tx11wk.png" width="150" height="150">
  <img src="https://blog.kakaocdn.net/dn/uyDoO/btrUvXWoORO/r9I7YkYSnihkTq2vpJqlv1/img.png" width="300" height="168">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/HTML5_logo_and_wordmark.svg/480px-HTML5_logo_and_wordmark.svg.png" width="200">
  <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj5WW8Wc-INY7Xm8Op5AjEHk5fz_bQgocSqg&s" width="125">
  <img src="https://e7.pngegg.com/pngimages/640/199/png-clipart-javascript-logo-html-javascript-logo-angle-text-thumbnail.png" width="200">

</div>

## 라이브러리

<div align="center">
  <img src="https://img1.daumcdn.net/thumb/R750x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbsCjBi%2FbtsIHcJ3Ani%2FoD0I4gr3oxMOufx0ilKgC1%2Fimg.png" width="250">
  <img src="https://velog.velcdn.com/images/bami/post/85b33988-a306-43f6-8354-72ce2e440faa/image.png" width="275">
  <img src="https://w7.pngwing.com/pngs/265/442/png-transparent-jquery-octos-global-javascript-library-document-object-model-ajax-framework-text-trademark-logo.png" width="300">
</div>

## 빌드 도구

<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Apache_Maven_logo.svg/1200px-Apache_Maven_logo.svg.png" width="350">
</div>

## 설계 도구
<div align="center">
  <img src="https://blog.kakaocdn.net/dn/unW26/btrPSZYKyc6/BCKH21EKO8ms93kUHFK7I0/img.png" width="275">
</div>

## ERD

![이미지](https://dayoon07.github.io/static-page-test/img/video-platform-erd.png)

## 기능 설명

<span style="font-size: large; font-weight: bold;">목차</span>

1. [마이페이지](#마이패이지-내-페이지)
2. [업로드](#업로드)
3. [댓글](#댓글-기능-crud)
4. [태그(카테고리)](#태그-기능)
5. [구독](#구독-기능-구독-구독-취소-내가-구독한-채널)
6. [좋아요](#좋아요-기능)
7. [스튜디오](#스튜디오)

### 마이패이지 (내 페이지) 
<a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/me/you.jsp" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/controller/MainController.java#L152" target="_blank">백엔드 코드 (컨트롤러)</a>
- 자기소개말 만들기 (Rest API로 구현)
- 최근 시청한 영상 4개
- 최근 좋아요를 누른 영상 4개 

```
// Rest API
@PostMapping("/createBio")
public ResponseEntity<String> createBio(@RequestParam String bio, HttpSession session) {
  creatorService.createBio(bio, session);
  return ResponseEntity.ok(bio);
}
```

![](https://dayoon07.github.io/static-page-test/img/whynot_%EB%A7%88%EC%9D%B4%ED%8E%98%EC%9D%B4%EC%A7%80.png)

<br>

---

### 업로드
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/video/upload.jsp" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/model/service/VideosService.java#L48" target="_blank">백엔드 코드 (비즈니스 로직)</a>
- 섬네일 이미지 업로드 (3MB 이하)
- 영상 업로드 (100MB 이하)
- 제목, 설명란, 태그
- 태그는 띄어쓰기를 하면 여러 태그를 추가할 수 있음 예:tag1 tag2 -> 결과 #tag1 #tag2
```
/** 영상 업로드 기능 */
public void uploadVideo(String tag, String title, String more, String videoLen, MultipartFile imgPath, MultipartFile videoPath, HttpSession session) throws IOException {
  CreatorEntity creator = (CreatorEntity) session.getAttribute("creatorSession");
  Optional<CreatorEntity> user = creatorRepository.findByCreatorName(creator.getCreatorName());
  if (user.isEmpty() || user.get().getCreatorName() == null || user.get().getCreatorName().isEmpty()) {
    throw new IllegalArgumentException("크리에이터를 찾을 수가 없습니다");
  }

  String thumbnailDir = session.getServletContext().getRealPath("/resources/video-img/");
  String videoDir = session.getServletContext().getRealPath("/resources/video/");

  String n = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss"));
  String imgExten = imgPath.getOriginalFilename().substring(imgPath.getOriginalFilename().lastIndexOf("."));
  String videoExten = videoPath.getOriginalFilename().substring(videoPath.getOriginalFilename().lastIndexOf("."));

  String imgName = n + UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "") + imgExten;
  String videoName = n + UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "") + videoExten;

  File imgDir = new File(thumbnailDir);
  File vdoDir = new File(videoDir);

  if (!imgDir.exists()) imgDir.mkdirs();
  if (!vdoDir.exists()) vdoDir.mkdirs();

  imgPath.transferTo(new File(thumbnailDir + imgName));
  videoPath.transferTo(new File(videoDir + videoName));

  VideosEntity video = VideosEntity.builder()
      .creator(user.get().getCreatorName())
      .creatorVal(user.get().getCreatorId())
      .title(title)
      .more(more)
      .videoName(videoName)
      .videoPath("/resources/video/" + videoName)
      .videoLen(videoLen)
      .imgName(imgName)
      .imgPath("/resources/video-img/" + imgName)
      .createAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
      .frontProfileImg(user.get().getProfileImgPath())
      .videoUrl(UUID.randomUUID().toString().replaceAll("-", "")).tag(tag).build();

  videosRepository.save(video);
}
```
![](https://dayoon07.github.io/static-page-test/img/whynot_업로드.png)

<br>

---

### 댓글 기능 (CRUD)
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/video/watch.jsp#L140" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/model/service/CommentService.java#L39" target="_blank">백엔드 코드 (비즈니스 로직)</a>
- 댓글 작성
- 댓글 수정
- 댓글 삭제
```
// 작성 함수
public void commentAdd(long commentVideo, HttpSession session, String commentContent) {
		CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
		VideosEntity video = videosRepository.findById(commentVideo)
			.orElseThrow(() -> new IllegalArgumentException("videoId가 비어있습니다"));

  CreatorEntity creator = creatorRepository.findById(user.getCreatorId()).orElse(null);
  Optional<CreatorEntity> uploder = creatorRepository.findById(video.getCreatorVal());

  if (creator != null) {
    CommentEntity comment = CommentEntity.builder()
        .commentVideo(commentVideo)
        .commentUserid(uploder.get().getCreatorId())
        .commenter(creator.getCreatorName()).commentUserid(uploder.get().getCreatorId())
        .commenterUserid(user.getCreatorId())
        .commenterProfile(creator.getProfileImg())
        .commenterProfilepath(creator.getProfileImgPath())
        .commentContent(commentContent)
        .datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))).build();
    commentRepository.save(comment);
  }
}

// 수정 함수
public String commentEdit(long commentId, String commentContent, long commentVideo) {
  CommentEntity comment = commentRepository.findById(commentId).orElseThrow(() -> new IllegalArgumentException("고유 아이디가 없습니다."));
  comment.setCommentContent(commentContent);
  commentRepository.save(comment);
  return "redirect:/watch?v=" + videosRepository.findById(commentVideo).orElse(null).getVideoUrl();
}

// 삭제 함수
public void deleteComment(long commentId) {
  commentRepository.deleteById(commentId);
}
```
![](https://dayoon07.github.io/static-page-test/img/whynot_댓글crud.png)

<br>

---

### 태그 기능
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/tag/tag.jsp" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/controller/MainController.java#L259" target="_blank">백엔드 코드 (컨트롤러)</a>
- 태그 보기

![](https://dayoon07.github.io/static-page-test/img/whynot_태그.png)
- 태그 작성

![](https://dayoon07.github.io/static-page-test/img/whynot_태그작성.png)
```
<!-- 예시 값: (태그1 태그2 태그3) -->
<!-- 결과 값: #태그1 #태그2 #태그3 -->
<c:forEach var="t" items="${ fn:split(watchTheVideo.tag, ' ') }">
  <a href="${ cl }/tag/${ t }" class="text-blue-600 hover:underline">
        #${ t }
    </a>
</c:forEach>
```

- 태그 (카테고리) 페이지

![](https://dayoon07.github.io/static-page-test/img/whynot_해시태그.png)

<br>

---

### 구독 기능 (구독, 구독 취소, 내가 구독한 채널)
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/creator/channel.jsp#L38" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/model/service/SubscriptionsService.java#L30" target="_blank">백엔드 코드</a>
- 프론트 UI <br> 
  세션의 값이 비어있으면 메세지 <br>
  세션의 값이 비어있지 않으면서 DB에 채널의 <br>
  pk와 세션에 로그인한 유저의 pk가 있다면 구독 취소 버튼 <br>
  아니면 구독 버튼
```
<c:if test="${ isSubscribed }">
    <div class="flex items-center">
      <p>구독중</p>
      <div class="px-4">
        <form action="${ cl }/deleteSubscri" method="post" autocomplete="off">
          <input type="hidden" name="subscriberId" id="subscriberId" value="${ creator.creatorId }" readonly readonly>
          <button type="submit" class="btn px-4 py-2 bg-red-500 hover:bg-red-300 rounded-lg text-white">구독 취소</button>
        </form>
      </div>
    </div>
</c:if>
<c:if test="${ sessionScope.creatorSession != null }">
  <c:if test="${ !isSubscribed }">
      <form action="${ cl }/subscri?subscriberId=${ creator.creatorId }&subscribingId=${ sessionScope.creatorSession.creatorId }" method="post" autocomplete="off">
          <button type="submit" class="px-6 py-2 mt-3 bg-black text-white rounded-full hover:bg-white hover:shadow-xl hover:text-black transition duration-300">
              구독
          </button>
      </form>
  </c:if> 
</c:if>
<c:if test="${ sessionScope.creatorSession == null }">
  <h1>구독은 로그인 후 사용 하실 수 있습니다</h1>
</c:if>
```
<br>

- 백엔드 구독 기능 <br>
  구독 정보를 DB에 저장하고 <br>
  구독을 받은 채널의 pk로 기존의 가지고 있던 구독자 수에 업데이트함
```
/** 
  구독 버튼을 누르면 구독을 누른 유저와 구독을 받은 
  채널의 pk를 DB에 저장하는 방식으로 저장함
*/
public String subscribe(long subscriberId, long subscribingId) {
  Optional<CreatorEntity> subscriberOpt = creatorRepository.findById(subscriberId);
  Optional<CreatorEntity> subscribingOpt = creatorRepository.findById(subscribingId);

  if (subscriberOpt.isEmpty() || subscribingOpt.isEmpty()) {
    throw new IllegalArgumentException("해당 사용자를 찾을 수 없습니다.");
  }

  CreatorEntity subscriber = subscriberOpt.get();
  CreatorEntity subscribing = subscribingOpt.get();

  // 구독 정보 저장
  SubscriptionsEntity subscription = SubscriptionsEntity.builder().subscriberName(subscriber.getCreatorName())
      .subscriberId(subscriberId).subscribingName(subscribing.getCreatorName()).subscribingId(subscribingId)
      .subscribedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 a HH:mm:ss")))
      .build();
  subscriptionsRepository.save(subscription);

  // 구독자 수 업데이트
  long subscriberCount = subscriptionsRepository.countBySubscriberId(subscriberId);
	CreatorEntity updatedSubscriber = creatorRepository.findById(subscriberId).get();
	updatedSubscriber.setSubscribe(subscriberCount);
	creatorRepository.save(updatedSubscriber);

  log.info("{}님이 {}님을 구독했습니다.", subscribing.getCreatorName(), subscriber.getCreatorName());

  return "redirect:/channel/" + convertToUrlEncoded(subscriber.getCreatorName());
}
```
<br>

- 내가 구독한 채널 페이지
```
public List<CreatorEntity> mySubscribingChannelsList(HttpSession session) {
  CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
  // 나를 구독한 사람들의 정보 조회 (구독중인 유저의 pk(creatorId)를 기준으로)
  List<SubscriptionsEntity> mySubscribers = subscriptionsRepository.findBySubscribingId(user.getCreatorId());

  // 나를 구독한 사람들의 creatorId 가져오기
  // subscriberId가 나를 구독한 채널들의 pk(creatorId)
  List<Long> subscriberIds = mySubscribers.stream().map(SubscriptionsEntity::getSubscriberId).collect(Collectors.toList());

  // 나를 구독한 사람들의 상세 정보 조회
  List<CreatorEntity> subscribers = creatorRepository.findByCreatorIdIn(subscriberIds);
  return subscribers;
}
```
<br>

---

### 좋아요 기능
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/video/watch.jsp#L59" target="_blank">프론트 코드</a> &nbsp; <a href="" target="_blank">백엔드 코드</a>

- UI<br>
```
<c:if test="${ likeuser eq true }">
  <form action="${ cl }/delLike"	method="post" autocomplete="off">
      <button type="submit" class="px-4 py-2 bg-black text-white rounded-full   hover:opacity-70 transition text-sm">
        <span id="watchTheVideoLikeVal">${ watchTheVideo.likes }</span>
        좋아요 취소 
    </button>
  <input type="hidden" name="likeId" value="${ delLikeBtn }" required readonly>
  </form>
</c:if>
<c:if test="${ likeuser eq false }">
  <form action="${ cl }/like"	method="post" autocomplete="off" id="likeAddForm">
    <button type="submit" class="px-4 py-2 bg-gray-200 rounded-full hover:bg-gray-300     transition text-sm" onclick="addLike()">
      좋아요 <span id="watchTheVideoLikeVal">${ watchTheVideo.likes }</span>
    </button>
    <input type="hidden" name="likeVdoId" value="${ watchTheVideo.videoId }" required readonly>
    <input type="hidden" name="likeVdoName" value="${ watchTheVideo.title }" required readonly>
  </form>
</c:if>
<c:if test="${ empty sessionScope.creatorSession }">
  <button type="button" class="px-4 py-2 border-gray-200 border rounded-full hover:bg-gray-300 transition text-sm">
    좋아요 ${ watchTheVideo.likes }
  </button>
</c:if>
```

- 좋아요 유무 로직
```
/* 
  현재 사용자가 로그인을 했다면 해당 영상의 
  조회수를 증가하고 like 테이블에 해당 영상의 
  좋아요를 눌렀는지 안눌렀는지 비디오의 pk와 
  사용자의 pk를 확인하고 true면 likeuser를 
  map(model)에 넣고 취소할 수 있는 버튼(기능)을 추가
*/
if (user != null) {
  video.setViews(video.getViews() + 1);
  video.setCommentCnt(comments.size());
  videosRepository.save(video);

  if (likeRepository.findByLikeVdoIdAndLikerId(video.getVideoId(), user.getCreatorId()).isPresent()) {
    response.put("likeuser", true);
    response.put("delLikeBtn", likeRepository
        .findByLikeVdoIdAndLikerId(video.getVideoId(), user.getCreatorId()).get().getLikeId());
  } else {
    response.put("likeuser", false);
  }
}
```

- 좋아요 표시, 좋아요 취소 기능
```
public void addLike(long likeVdoId, String likeVdoName, HttpSession session) {
  CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
  
  String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd a HH:mm:ss"));
  
  LikeEntity entity = LikeEntity.builder()
      .likeVdoId(likeVdoId)
      .likeVdoName(likeVdoName)
      .likerId(user.getCreatorId())
      .likerName(user.getCreatorName())
      .datetime(now)
      .build();
  likeRepository.save(entity);
  log.info("{}이(가) {}영상에 좋아요를 눌렀습니다", user.getCreatorName(), likeVdoName);
}

public String delLike(long likeId) {
  LikeEntity like = likeRepository.findById(likeId).get();
  VideosEntity video = videosRepository.findById(like.getLikeVdoId()).get();
  likeRepository.deleteById(likeId);;
  log.info("{}영상에 대한 좋아요 하나가 취소 되었습니다", video.getTitle());
  return "redirect:/watch?v=" + video.getVideoUrl();
}
```
<br>

- 영상에 좋아요를 저장하는 방식 <br>
  사용자가 비디오에 표시한 '좋아요'를 저장하고 업데이트하는 기능입니다. <br>
  좋아요 버튼을 클릭하면 서버에 정보가 전송되어 저장되고, 화면에 업데이트됩니다.
- 주요 구성 요소 <br>
  초기 좋아요 수 로드 <br>
  좋아요 추가 기능
- 작동 방식 <br>
  페이지 로드 시 writeLikeValue() 함수가 호출되어 현재 좋아요 수를 가져옵니다. <br> 사용자가 좋아요 버튼을 클릭하면 addLike() 함수가 실행되어 <br> 서버에 요청을 보내고 화면을 업데이트합니다.
```
// rest api 서버 메서드
@PostMapping("/likeCount")
public long likeCount(@RequestParam long param, @RequestParam long id) {
  log.info("서버가 받은 값 param: {}, id: {}", param, id);
  return videosService.addLikeButRestApi(param, id);
}
```

```
// likeCount.js

const likeVal = document.getElementById("likeCount").value;
const id = document.getElementById("likeCountButVideoId").value;

document.addEventListener("DOMContentLoaded", () => {
	"use strict";
	
	writeLikeValue();
	setTimeout(writeLikeValue, 1500);
});

function writeLikeValue() {
	fetch(`${location.origin}/likeCount?param=${likeVal}&id=${id}`, {
			method: "post"})
			.then(res => res.json())
			.then((data) => {
				if (document.getElementById("watchTheVideoLikeVal") != null) {
					console.log(data);
					document.getElementById("watchTheVideoLikeVal").textContent = data;
				} else {
					console.log(data);	
				}
			})
			.catch((err) => {
				console.log(err);
			});
}

function addLike() {	
	fetch(`${location.origin}/likeCount?param=${likeVal}&id=${id}`, {method: "post"})
		.then(res => res.json())
		.then((data) => {
			document.getElementById("watchTheVideoLikeVal").textContent = data;
			console.log(data);
		})
		.catch((err) => {
			console.log(err);
		});
}
```
<br>

---

### 스튜디오

스튜디오는 5개의 항목으로 되어 있음

1. [콘텐츠](#콘텐츠)
2. [대시보드](#대시보드)
3. [영상 피드백](#영상-피드백)
4. [나의 댓글](#나의-댓글)
5. [구독자 조회](#구독자-조회)

<br>

### 콘텐츠
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/dashboard/myVideo.jsp" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/controller/MainController.java#L272" target="_blank">백엔드 코드 (컨트롤러)</a>
- 콘텐츠 : 사용자가 업로드한 영상 전체 보기 페이지 <br>
  (내가 업로드한 영상의 수정 및 삭제 가능)

![](https://dayoon07.github.io/static-page-test/img/whynot_콘텐츠.png)

<br>


### 대시보드
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/dashboard/dashboard.jsp" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/controller/MainController.java#L281" target="_blank">백엔드 코드 (컨트롤러)</a>
- 대시보드: 구독자수 (5초마다 Rest API를 이용해 서버한테 요청 뒤 값을 받아오는 방식, 실시간 구현할려고 생각 조금 함) <br>
영상통계 <br>1. 업로드된 영상 count, <br>2. 총 조회수, <br> 3. 총 좋아요, <br>4. 내가 올린 모든 영상에 달린 모든 댓글 수<br>

```
// Rest API
@GetMapping("/subscribeCount")
public ResponseEntity<Long> subscribeCount(HttpSession s) {
    CreatorEntity user = (CreatorEntity) s.getAttribute("creatorSession");
    if (user == null) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(0L);
    }
    
    return ResponseEntity.ok(creatorService.getSubscribeCount(user.getCreatorId()));
}
```

```
// 비동기 처리 js
document.addEventListener("DOMContentLoaded", function() {
    const subscribeElement = document.getElementById("subscribeCount");

    async function fetchSubscribeCount() {
        try {
            const response = await fetch(`${location.origin}/subscribeCount`);
            if (!response.ok) throw new Error("서버 응답 오류");

            const count = await response.json();
            // 숫자 포맷
            const formattedCount = count.toLocaleString();
            subscribeElement.textContent = formattedCount;
            console.log(count);
        } catch (error) {
            console.error("구독자 수 갱신 실패:", error);
        }
    }

    setInterval(fetchSubscribeCount, 5000);

    fetchSubscribeCount();
});
```

![](https://dayoon07.github.io/static-page-test/img/whynot_대시보드.png)

<br>

### 영상 피드백
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/dashboard/videoAllComment.jsp" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/controller/MainController.java#L305" target="_blank">백엔드 코드 (컨트롤러)</a>
- 영상 피드백: 내가 업로드한 영상의 모든 <br>
  댓글 조회 및 검색 가능(검색 기능은 Rest API로 구현)

```
// Rest API
@GetMapping("/searchComments")
public List<CommentVo> searchComments(HttpSession session, @RequestParam String keyword) {
    CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
    if (user == null) return Collections.emptyList();
    
    List<CommentVo> comments = commentService.findCommentsByKeyword(user.getCreatorId(), keyword);
    return comments;
}
```

```
// 태그의 onclick 속성으로 작동함
function searchComments() {
	let keyword = document.getElementById("keywordInput").value;

	fetch(`${location.origin}/searchComments?keyword=${keyword}`)
		.then(response => response.json())
		.then(data => {
			let resultDiv = document.getElementById('searchResults');
			resultDiv.innerHTML = "";

			if (data.length === 0) {
				resultDiv.innerHTML = "<p class='text-gray-500 mt-5'>검색 결과가 없습니다.</p>";
				return;
			}

			data.forEach(comment => {
				console.log(comment);
				resultDiv.innerHTML += `
					<div class="border-b border-gray-300 py-4">
                    	<div class="flex items-start space-x-4">
                        	<a href="${location.origin}/channel/${comment.commenter}">
                            	<img src="${comment.commenterProfilepath}" class="w-10 h-10 rounded-full">
                            </a>
							<div class="flex-1">
                            	<p class="text-sm text-gray-500">${comment.datetime}</p>
                                <span class="font-semibold">${comment.commenter}</span>
                                <p class="mt-1 text-gray-700">${comment.commentContent}</p>
							</div>
							<div>
		                        <form action="${location.origin}/deleteCommentButAdminAccount" method="post" autocomplete="off">
		                        	<input type="hidden" name="commentId" id="commentId" value="${comment.commentId}" required readonly>
		                            <button type="submit" class="hover:underline hover:text-red-500 mr-5">댓글 삭제</button>
								</form>
	                        </div>
                        </div>
					</div>
				`;
			});
		});
}
```

![](https://dayoon07.github.io/static-page-test/img/whynot_영상피드백.png)
![](https://dayoon07.github.io/static-page-test/img/whynot_영상피드백_rest.png)

<br>

### 나의 댓글
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/dashboard/myComment.jsp" target="_blank">프론트 코드</a> &nbsp; <a href="" target="_blank">백엔드 코드 (컨트롤러)</a>
- 나의 댓글: 내가 작성한 모든 댓글 조회 페이지 <br>
  (댓글 수정은 해당 영상에서, 삭제는 가능)

![](https://dayoon07.github.io/static-page-test/img/whynot_내댓글.png)

<br>

### 구독자 조회
- <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/webapp/WEB-INF/jsp/dashboard/subscribe.jsp" target="_blank">프론트 코드</a> &nbsp; <a href="https://github.com/Dayoon07/SpringBoot_Video_Web/blob/main/whynot/src/main/java/com/e/d/controller/MainController.java#L296" target="_blank">백엔드 코드 (컨트롤러)</a>
- 구독자 조회: 나를 구독한 사용자 전체 조회 및 구독한 유저 검색 <br>
  (검색은 Rest API로 구현)

```
// get으로 한 이유는 그냥 그때 post로 비동기 처리하는 방법을 몰라서
@GetMapping("/selectByMySubscribingUsername")
public List<CreatorSubscriptionDto> selectByMySubscribingUsername(HttpSession session, @RequestParam String name) {
  CreatorEntity user = (CreatorEntity) session.getAttribute("creatorSession");
  if (user == null) {
    return Collections.emptyList();
  } else {
    return creatorService.selectBySubscribeUsername(name, user.getCreatorId());
  }
}
```

```
function searchSubscrubeingUsername() {
	let name = document.getElementById("subscribingName").value;

	fetch(`${location.origin}/selectByMySubscribingUsername?name=${name}`)
		.then(response => response.json())
		.then(data => {
			let resultDiv = document.getElementById('subscribingUserSearchResults');
			resultDiv.innerHTML = "";

			if (!Array.isArray(data) || data.length === 0) {
				resultDiv.innerHTML = "<p class='text-gray-500'>검색 결과가 없습니다.</p>";
				return;
			}

			console.log("데이터 :", data);

			data.forEach(user => {
				resultDiv.innerHTML += `
					<div class="border-b border-gray-300 py-4">
					    <div class="flex items-start space-x-6">
					        <a href="${location.origin}/channel/${user.subscription.subscribingName || '알 수 없음'}">
					            <img src="${user.creator.profileImgPath || '/default-profile.png'}" class="w-16 h-16 rounded-full object-cover">
					        </a>
	
					        <div class="flex-1">
								<a href="${location.origin}/channel/${user.creator.creatorName || '알 수 없음'}" class="font-semibold text-xl">
					            	${user.creator.creatorName || '알 수 없음'}
					            </a>
	
					            <div class="mt-2 text-gray-600">
									<p class="text-gray-500 text-sm">구독자 수 : ${user.creator.subscribe || 0}</p>
					                <p class="text-sm">이메일 : ${user.creator.creatorEmail || '알 수 없음'}</p>
					                <p class="text-sm">구독일 : ${user.subscription.subscribedAt || '알 수 없음'}</p>
					            </div>
	
					            <div class="mt-4 text-gray-700">
					                <p class="text-sm">소개말 : ${user.creator.bio || '없음' }</p>
					            </div>
					        </div>
					    </div>
					</div>
			    `;
			});
		})
		.catch(error => console.error("데이터 전송 중 오류 : ", error));
}
```

![](https://dayoon07.github.io/static-page-test/img/whynot_구독자조회.png)
![](https://dayoon07.github.io/static-page-test/img/whynot_구독자조회_rest.png)
