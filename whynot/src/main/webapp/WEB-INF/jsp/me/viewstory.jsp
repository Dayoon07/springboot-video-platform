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
	            <a href="${ cl }/watch?v=${ mvs.videosVo.videoUrl }" style="width: 246px; height: 138px;" class="overflow-hidden">
	                <img class="w-full h-full object-cover rounded-lg" src="${ mvs.videosVo.imgPath }" alt="${ mvs.videosVo.title } 영상의 섬네일">
	            </a>
				<div class="mx-2">            
	                <span class="text-lg font-semibold line-clamp-2">${ mvs.videosVo.title }</span>
	                <span class="text-sm text-gray-500">${ mvs.videosVo.creator }</span>
	                <span class="text-sm text-gray-500 mx-5">조회수 ${ mvs.videosVo.views }회</span>
	                <div>
	                	${ mvs.videosVo.more }
	                </div>
	            </div>
	        </div>
	    </c:forEach>
	</div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>