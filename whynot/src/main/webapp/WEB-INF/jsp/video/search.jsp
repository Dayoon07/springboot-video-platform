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
	<title>${ searchWord } - whynot</title>
</head>
<body>
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	<div class="max-w-6xl mx-auto p-4">
		<c:forEach var="searchVideos" items="${ searchList }">
			<div class="flex justify-start" style="height: 250px;">
				<div class="pr-2">
					<a href="${ cl }/watch?v=${ searchVideos.v }">
						<img src="${ searchVideos.imgPath }" width="375" class="h-full rounded-lg object-cover">
					</a>
				</div>
				<div class="pl-2 py-2">
					<h1 class="text-2xl">${ searchVideos.title }</h1>
					<p class="text-gray-500">
						<span>조회수 ${ searchVideos.views == 0 ? "없음" : searchVideos.views }회 | </span>
						<span>${ searchVideos.createAt }</span>
					</p>
					<div class="flex items-center my-2">
						<img src="${ searchVideos.frontProfileImg }" class="w-8 h-8 rounded-full object-cover">
						<p class="text-gray-500 ml-3">${ searchVideos.creator }</p>
					</div>
					<div class="text-gray-500">
						${ searchVideos.more.length() >= 50 ? searchVideos.more.substring(0, 50) : searchVideos.more }
					</div>
				</div>
			</div>
		</c:forEach>
    </div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>