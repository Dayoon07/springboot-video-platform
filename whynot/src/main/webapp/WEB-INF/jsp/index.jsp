<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
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
	    <div id="videoContainer" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
	        <c:forEach var="video" items="${ allVideo }">
	            <div class="video-item flex flex-col gap-2 p-2 rounded-lg hover:bg-gray-200">
	                <div class="relative">
	                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
	                        <a href="${ cl }/watch?v=${ video.v }">
	                            <img src="${ video.imgPath }" class="w-full h-full object-cover" loading="lazy">
	                        </a>
	                    </div>
	                </div>
	                <div class="flex gap-2">
	                    <a href="${ cl }/channel/${ video.creator }">
	                        <img src="${ video.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
	                    </a>
	                    <div class="flex-1 min-w-0">
	                        <a href="${ cl }/watch?v=${ video.v }" class="font-medium text-sm line-clamp-2 hover:underline">
	                            ${ video.title }
	                        </a>
	                        <a href="${ cl }/channel/${ video.creator }" class="text-sm text-gray-600 hover:underline">
	                            ${ video.creator }
	                        </a>
	                        <div class="text-sm text-gray-600">
	                            조회수 ${ video.views == 0 ? "없음" : video.views += "회" } |  
	                            ${ video.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
	                            ? video.createAt.substring(6, 13) : video.createAt.substring(0, 13) }
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </c:forEach>
	    </div>
	
	    <div class="flex justify-center mt-4">
		    <c:if test="${ countVideos < 100 }">
		        <button id="loadMoreBtn" class="bg-black w-60 text-white px-4 py-2 rounded-lg hover:opacity-80 mb-40" data-page="0">
		            더보기
		        </button>
		    </c:if>
		</div>
	</div> 

    <jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
    
</body>
</html>