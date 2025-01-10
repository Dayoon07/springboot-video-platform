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
	<title>${ creator.creatorName } - whynot</title>
</head>
<body>
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	<div class="flex max-w-4xl py-10 mx-auto">
        <div class="w-40 h-40 overflow-hidden rounded-full">
			<img src="${ creator.profileImgPath }" alt="Profile Image" class="w-full h-full object-cover">
		</div>
        <div class="ml-5"> 
            <h1 class="text-3xl font-semibold">${ creator.creatorName }</h1>
            <h1 class="text-xl py-1">구독자 ${ creator.subscribe }명</h1>
            <p class="text-lg py-1 text-gray-700 truncate max-w-xl">
            	<c:if test="${ creator.bio.length() >= 50 }">
	                ${ creator.bio.substring(0, 50) }
            	</c:if>
            	<c:if test="${ creator.bio.length() < 50 }">
            		${ creator.bio }
            	</c:if>
            </p>

            <c:if test="${ isSubscribed }">
			    <div class="flex justify-center items-center">
			    	<div>
			    		<p>구독중</p>
			    	</div>
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

            <nav class="mt-4 space-x-4">
                <a href="${ cl }/channel/${ creator.creatorName }" class="text-black text-red-600 underline">홈</a>
                <a href="${ cl }/channel/${ creator.creatorName }/videos" class="text-black hover:text-red-600 hover:underline">동영상</a>
                <!-- <a href="#" class="text-black hover:text-red-600">게시물</a> -->
            </nav>
        </div>
    </div>
    <div class="max-w-7xl mx-auto p-4">
    	<h1>최신 영상</h1>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
        
        	<c:forEach var="cvl" items="${ creatorVideosList }" varStatus="cvlStatus">
        		<c:if test="${ cvlStatus.index < 20 }">
	        		<div class="flex flex-col gap-2 p-2 rounded-lg hover:bg-gray-200">
		                <div class="relative group">
		                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
		                        <a href="${ cl }/watch?v=${ cvl.v }">
		                        	<img src="${ cvl.imgPath }" alt="Video thumbnail" class="w-full h-full object-cover">
		                        </a>
		                    </div>
		                </div>
		                <div class="flex gap-2">
		                    <a href="${ cl }/channel/${ cvl.creator }">
		                    	<img src="${ cvl.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
		                    </a>
		                    <div class="flex-1 min-w-0">
		                        <a href="${ cl }/watch?v=${ cvl.v }" class="font-medium text-sm line-clamp-2 hover:underline">
		                        	${ cvl.title }
		                        </a>
		                        <a href="${ cl }/channel/${ cvl.creator }" class="text-sm text-gray-600 hover:underline">
			                        ${ cvl.creator }
								</a>
		                        <div class="text-sm text-gray-600">
		                        	조회수 ${ cvl.views == 0 ? "없음" : cvl.views } | ${ cvl.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
		                        	 ? cvl.createAt.substring(6, 13) : cvl.createAt.substring(0, 13) }
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