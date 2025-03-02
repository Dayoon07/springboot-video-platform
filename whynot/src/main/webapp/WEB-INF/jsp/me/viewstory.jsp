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
	<title>whynot</title>
</head>
<body>
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	<div class="max-w-7xl mx-auto p-4">
	    <h1 class="text-2xl font-bold mb-6">시청 기록</h1>
	
	    <c:forEach var="mvs" items="${ myViewStory }">
	        <div class="w-full flex p-2 hover:bg-gray-100 rounded-lg transition duration-200">
	            <a href="${ cl }/watch?v=${ mvs.videosVo.videoUrl }" style="width: 170px; height: 109px;" class="overflow-hidden">
	                <img class="w-full h-full object-cover rounded-lg" src="${ mvs.videosVo.imgPath }" alt="${ mvs.videosVo.title } 영상의 섬네일">
	            </a>
				<div class="mx-2">
					<c:choose>
						<c:when test="${ mvs.videosVo.title.length() > 10 }">
			                <span class="text-lg font-semibold line-clamp-2">${ mvs.videosVo.title.substring(0, 10) }...</span>
						</c:when>
						<c:otherwise>
			                <span class="text-lg font-semibold line-clamp-2">${ mvs.videosVo.title }</span>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${ mvs.videosVo.creator.length() > 10 }">
							<span class="text-sm text-gray-500">${ mvs.videosVo.creator.substring(0, 10) }...</span><br>
						</c:when>
						<c:otherwise>
			                <span class="text-sm text-gray-500">${ mvs.videosVo.creator }</span><br>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${ mvs.videosVo.views == 0 }">
							<span class="text-sm text-gray-500">조회수 없음</span>
						</c:when>
						<c:when test="${ mvs.videosVo.views >= 10000 }">
							<span class="text-sm text-gray-500">
								조회수 <fmt:formatNumber value="${ mvs.videosVo.views / 10000 }" pattern="#"/>만회
							</span>
						</c:when>
						<c:otherwise>
							<span class="text-sm text-gray-500">
								조회수 <fmt:formatNumber value="${ mvs.videosVo.views }" type="number" />회
							</span>
						</c:otherwise>
					</c:choose>
	            </div>
	        </div>
	    </c:forEach>
	</div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>