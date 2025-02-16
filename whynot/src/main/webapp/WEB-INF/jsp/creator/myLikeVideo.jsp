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
	    <h1 class="text-2xl font-bold mb-6">좋아요 표시한 동영상</h1>
	    
	    <c:forEach var="mlv" items="${ myLikeVideo }">
	        <a href="${ cl }/watch?v=${ mlv.videos.videoUrl }" 
	        	class="block bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow p-4 mb-4 flex cursor-pointer">
	            <div class="relative w-48 h-28 flex-shrink-0">
	                <img src="${ mlv.videos.imgPath }" alt="thumbnail" class="w-full h-full object-cover rounded-lg"/>
	            </div>
	            
	            <div class="ml-4 flex-grow">
	                <h3 class="font-semibold text-lg mb-1">${ mlv.videos.title }</h3>
	                <p class="text-gray-500 text-sm">${ mlv.videos.creator }</p>
	                <div class="text-gray-500 text-sm mt-1">
	                    조회수 ${ mlv.videos.views }회 &nbsp; &#8226; &nbsp; ${ mlv.videos.createAt.substring(0, 13) }
	                </div>
	            </div>
	        </a>
	    </c:forEach>
	</div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>