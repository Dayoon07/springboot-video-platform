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
    <link rel="stylesheet" hidden="${ cl }/source/css/custom.css">
	<title>${ watchTheVideo.title }</title>
</head>
<body>
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	<div class="max-w-5xl mx-auto py-10 px-5">
	    <!-- Video Player Section -->
	    <div class="aspect-video bg-black rounded-lg overflow-hidden">
	        <video controls autoplay class="w-full h-full">
	            <source src="${ watchTheVideo.videoPath }" type="video/mp4">
	        </video>
	    </div>
	
	    <!-- Video Details Section -->
	    <div class="mt-5">
	        <h1 class="text-2xl font-bold">${ watchTheVideo.title }</h1>
	        <div class="text-sm text-gray-600 mt-2">
	            조회수: ${ watchTheVideo.views } | 업로드 날짜: ${ watchTheVideo.createAt }
	        </div>
	        <div class="flex items-center space-x-3 mt-3">
	            <button class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300 transition">
	                👍 좋아요 ${ watchTheVideo.likes }
	            </button>
	            <button class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300 transition">
	                👎 싫어요 ${ watchTheVideo.unlikes }
	            </button>
	            <button class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-500 transition">
	                구독
	            </button>
	        </div>
	    </div>
	
	    <!-- Video Description -->
	    <div class="mt-5 p-4 bg-gray-100 rounded">
	        <p>${ watchTheVideo.more }</p>
	    </div>
	
	    <!-- Comments Section -->
	    <div class="mt-10">
	        <h2 class="text-lg font-bold mb-3">댓글</h2>
	        <form action="/addComment" method="post" class="mb-5">
	            <textarea name="comment" rows="3" class="w-full p-3 border rounded" placeholder="댓글을 입력하세요..."></textarea>
	            <button type="submit" class="mt-2 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-500 transition">
	                댓글 달기
	            </button>
	        </form>
	        <div class="space-y-4">
	            <!--<c:forEach var="comment" items="${comments}">
	                <div class="p-3 bg-gray-100 rounded">
	                    <p class="font-bold">${comment.user}</p>
	                    <p>${comment.content}</p>
	                    <div class="text-sm text-gray-600">${comment.date}</div>
	                </div>
	            </c:forEach>-->
	        </div>
	    </div>
	
	    <!-- Recommended Videos -->
	    <div class="mt-10">
	        <h2 class="text-lg font-bold mb-3">추천 동영상</h2>
	        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-5">
	            <!--<c:forEach var="video" items="${recommendedVideos}">
	                <div class="flex flex-col">
	                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
	                        <a href="/watch/${video.videoId}">
	                            <img src="${video.imgPath}" alt="${video.title}" class="w-full h-full object-cover">
	                        </a>
	                    </div>
	                    <h3 class="font-medium text-sm mt-2 line-clamp-2">${video.title}</h3>
	                    <p class="text-sm text-gray-600">${video.creator}</p>
	                    <div class="text-sm text-gray-600">조회수: ${video.views} | 업로드: ${video.createAt}</div>
	                </div>
	            </c:forEach>-->
	        </div>
	    </div>
	</div>
	
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>