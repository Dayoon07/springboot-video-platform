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
	<title>${ creator.creatorName } - whynot</title>
</head>
<body>
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	<div class="flex items-center max-w-4xl py-10 mx-auto">
        <div class="w-40 h-40 overflow-hidden rounded-full">
			<img src="${ creator.profileImgPath }" alt="Profile Image" class="w-full h-full object-cover">
		</div>
        <div class="ml-5"> 
            <h1 class="text-3xl font-semibold">${ creator.creatorName }</h1>
            <p class="text-lg py-2 text-gray-700 truncate max-w-xl">
            	<c:if test="${ creator.bio.length() >= 50 }">
	                ${ creator.bio.substring(0, 50) }
            	</c:if>
            	<c:if test="${ creator.bio.length() < 50 }">
            		${ creator.bio }
            	</c:if>
            </p>
            <button class="px-6 py-2 mt-3 bg-red-600 text-black rounded-full hover:bg-red-500 transition duration-300">
                구독
            </button>
            <nav class="mt-4 space-x-4">
                <a href="#" class="text-black hover:text-red-600">홈</a>
                <a href="#" class="text-black hover:text-red-600">동영상</a>
                <a href="#" class="text-black hover:text-red-600">게시물</a>
            </nav>
        </div>
    </div>
    <div class="max-w-4xl py-10 mx-auto">
        <h1 class="py-3">인기 동영상</h1>
        <div class="flex">
        	<c:if test="${ not empty creatorVideosList }">
        		<c:forEach var="cvl" items="${ creatorVideosList }">
	            	<div class="flex flex-col gap-2 py-3">
		                <div class="relative group">
		                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
		                        <a href="${ cl }/watch?v=${ cvl.v }">
		                        	<img src="${ cvl.imgPath }" alt="Video thumbnail" class="w-full h-full object-cover">
		                        </a>
		                    </div>
		                    <div class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity bg-black/20">
		                        <i data-lucide="play-circle" class="w-12 h-12 text-white"></i>
		                    </div>
		                </div>
		                <div class="flex gap-2">
		                    <div class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0"></div>
		                    <div class="flex-1 min-w-0">
		                        <h3 class="font-medium text-sm line-clamp-2">${ cvl.title }</h3>
		                        <p class="text-sm text-gray-600">${ cvl.more }</p>
		                        <div class="text-sm text-gray-600">${ cvl.views } | ${ cvl.createAt }</div>
		                    </div>
		                </div>
		            </div>
	            </c:forEach>
        	</c:if>
        	<c:if test="${ empty creatorVideosList }">
        		제작한 영상이 없습니다.
        	</c:if>
        </div>
    </div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>