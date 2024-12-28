<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${ cl }/source/img/videoPlayer-icon.png" type="image/x-icon">
    <link rel="stylesheet" href="${ cl }/source/css/custom.css">
	<title>${ watchTheVideo.title } - whynot</title>
</head>
<body>
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	<div class="container mx-auto py-10 px-5 flex justify-between">
	    <div class="w-10/12 px-4 mx-auto">
		    <div class="aspect-video bg-black rounded-lg overflow-hidden">
		        <video controls autoplay class="w-full h-full">
		            <source src="${ watchTheVideo.videoPath }" type="video/mp4">
		        </video>
		    </div>
		
		    <div class="mt-5">
		        <h1 class="text-2xl font-bold">${ watchTheVideo.title }</h1>
		        
		        <div class="flex items-center space-x-3 mt-2">
		            <a href="${ cl }/channel/${ videoCreatorProfileInfo.creatorName }" class="flex items-center">
		                <img src="${ videoCreatorProfileInfo.profileImgPath }" alt="${ videoCreatorProfileInfo.creatorName } 프로필" class="w-10 h-10 rounded-full border-2 border-gray-300">
						<span class="ml-2 text-sm font-semibold text-gray-900">${ videoCreatorProfileInfo.creatorName }</span>
		            </a>
					<span class="ml-2 text-sm text-gray-600">구독자 ${ videoCreatorProfileInfo.subscribe }명</span>
		        </div>
		
		        <div class="text-sm text-gray-600 mt-2">
		            조회수: ${ watchTheVideo.views } | 업로드 날짜: ${ watchTheVideo.createAt }
		        </div>
		
		        <div class="flex items-center space-x-3 mt-3">
		            <button class="px-6 py-2 bg-gray-200 rounded-full hover:bg-gray-300 transition flex items-center space-x-2">
		                <span class="ml-1">좋아요 ${ watchTheVideo.likes }</span>
		            </button>
		            <button class="px-6 py-2 bg-gray-200 rounded-full hover:bg-gray-300 transition flex items-center space-x-2">
		                <span class="ml-1">싫어요 ${ watchTheVideo.unlikes }</span>
		            </button>
		            <button class="px-6 py-2 bg-red-600 text-white rounded-full hover:bg-red-500 transition">
		                구독
		            </button>
		        </div>
		    </div>
		
		    <div class="mt-5 p-4 bg-gray-100 rounded-lg">
		        <p class="text-gray-800">${ watchTheVideo.more }</p>
		    </div>
		
		    <div class="mt-10">
		        <h2 class="text-lg font-bold mb-3">댓글</h2>
		        <form action="/addComment" method="post" class="mb-5">
		            <textarea name="comment" rows="3" class="w-full p-3 border rounded-md" placeholder="댓글을 입력하세요..."></textarea>
		            <button type="submit" class="mt-2 px-6 py-2 bg-blue-600 text-white rounded-full hover:bg-blue-500 transition">
		                댓글 달기
		            </button>
		        </form>
		
		        <!-- Comment List (uncomment the below block to show comments) -->
		        <!--<div class="space-y-4">
		            <div class="p-3 bg-gray-100 rounded-md">
		                <p class="font-bold">User1</p>
		                <p class="text-sm text-gray-700">This is a comment.</p>
		                <div class="text-xs text-gray-600">2024-12-28 10:00 AM</div>
		            </div>
		            <div class="p-3 bg-gray-100 rounded-md">
		                <p class="font-bold">User2</p>
		                <p class="text-sm text-gray-700">Another comment here!</p>
		                <div class="text-xs text-gray-600">2024-12-28 10:05 AM</div>
		            </div>
		        </div>-->
		    </div>
		
		    <div class="mt-10">
		        <h2 class="text-lg font-bold mb-3">추천 동영상</h2>
		        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-5">
		            <div class="flex flex-col">
		                <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
		                    <a href="${ cl }/watch?v=1lendjqdjasjkd123">
		                        <img src="" alt="Video thumbnail" class="w-full h-full object-cover">
		                    </a>
		                </div>
		                <h3 class="font-medium text-sm mt-2 line-clamp-2">제목</h3>
		                <p class="text-sm text-gray-600">채널명 또는 영상 제작자 이름</p>
		                <div class="text-sm text-gray-600">조회수: 4.5만회 | 업로드: 12월 28일</div>
		            </div>
		        </div>
		    </div>
		</div>
	    <div class="w-96 border rounded-lg overflow-y-scroll" style="height: 1100px;">
	    	<c:forEach var="rec" items="${ recentVideo }" varStatus="recentStatus">
	    		<c:if test="${ recentStatus.index < 20 }">
	    			<div class="flex flex-col gap-2 p-4 hover:bg-gray-200">
		                <div class="relative group">
		                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
		                        <a href="${ cl }/watch?v=${ rec.v }">
		                        	<img src="${ rec.imgPath }" alt="Video thumbnail" class="w-full h-full object-cover">
		                        </a>
		                    </div>
		                </div>
		                <div class="flex gap-2">
		                    <a href="${ cl }/channel/${ rec.creator }">
		                    	<img src="${ rec.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
		                    </a>
		                    <div class="flex-1 min-w-0">
		                        <a href="${ cl }/watch?v=${ rec.v }" class="font-medium text-sm line-clamp-2 hover:underline">
		                        	${ rec.title }
		                        </a>
		                        <a href="${ cl }/channel/${ rec.creator }" class="text-sm text-gray-600 hover:underline">
		                        	${ rec.creator }
		                        </a>
		                        <div class="text-sm text-gray-600">
		                        	조회수 ${ rec.views == 0 ? "없음" : rec.views } | 	${ rec.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
		                        	 ? rec.createAt.substring(6, 13) : rec.createAt.substring(0, 13) }
		                        </div>
		                    </div>
		                </div>
		            </div>
	    		</c:if>
	    	</c:forEach>
	    </div>
	</div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>