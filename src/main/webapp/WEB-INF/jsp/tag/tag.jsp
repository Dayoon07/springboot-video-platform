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
		<h1 class="text-3xl font-semibold">#${ tagWord }</h1>
		<h1 class="text-lg my-2 text-gray-600">관련 태그 영상 ${ videosTagList.size() }개</h1>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
        	<c:if test="${ empty videosTagList }">
        		<h1>없는 태그입니다</h1>
        	</c:if>
        	<c:if test="${ not empty videosTagList }">
	        	<c:forEach var="tagVideo" items="${ videosTagList }">
	        		<div class="flex flex-col gap-2 p-2 rounded-lg hover:bg-gray-200">
		                <div class="relative group">
		                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
		                        <a href="${ cl }/watch?v=${ tagVideo.v }">
		                        	<img src="${ tagVideo.imgPath }" class="w-full h-full object-cover">
		                        </a>
		                    </div>
		                </div>
		                <div class="flex gap-2">
		                    <a href="${ cl }/channel/${ tagVideo.creator }">
		                    	<img src="${ tagVideo.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
		                    </a>
		                    <div class="flex-1 min-w-0">
		                        <a href="${ cl }/watch?v=${ tagVideo.v }" class="font-medium text-sm line-clamp-2 hover:underline">
		                        	${ tagVideo.title }
		                        </a>
		                        <a href="${ cl }/channel/${ tagVideo.creator }" class="text-sm text-gray-600 hover:underline">
			                        ${ tagVideo.creator }
								</a>
		                        <div class="text-sm text-gray-600">
		                        	조회수 ${ tagVideo.views == 0 ? "없음" : tagVideo.views } | ${ tagVideo.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
		                        	 ? tagVideo.createAt.substring(6, 13) : tagVideo.createAt.substring(0, 13) }
		                        </div>
		                    </div>
		                </div>
		            </div>
	        	</c:forEach>
	        </c:if>
        </div>
    </div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>