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
	
	<div class="max-w-6xl mx-auto p-4">
	    <h1 class="text-3xl">구독한 채널</h1>
	
	    <!-- 내가 구독한 채널 목록 -->
	    <c:if test="${ empty mySubscribeLists }">
	        <h2 class="text-lg text-gray-500">구독한 채널이 없습니다.</h2>
	    </c:if>
	    
	    <c:if test="${ not empty mySubscribers }">
	        <c:forEach var="msl" items="${ mySubscribers }">
	            <div class="w-full p-4 flex">
	                <div>
	                    <img src="${ msl.profileImgPath }" class="w-40 h-40 rounded-full object-cover">
	                </div>
	                <div>
	                    <h1>${ msl.creatorName }</h1>
	                    <p>${ msl.subscribe }</p>
	                    <p>${ msl.creatorName }</p>
	                </div>
	            </div>
	        </c:forEach>
	    </c:if>
	
	    <h1 class="text-3xl mt-8">나를 구독한 사람들</h1>
	
	    <!-- 나를 구독한 사람 목록 -->
	    <c:if test="${ empty mySubscribers }">
	        <h2 class="text-lg text-gray-500">나를 구독한 사람이 없습니다.</h2>
	    </c:if>
	    
	    <c:if test="${ not empty mySubscribeLists }">
	        <c:forEach var="msl" items="${ mySubscribeLists }">
	            <div class="w-full p-4 flex">
	                <div>
	                    <img src="${ msl.profileImgPath }" class="w-40 h-40 rounded-full object-cover">
	                </div>
	                <div>
	                    <h1>${ msl.creatorName }</h1>
	                    <p>${ msl.subscribe }</p>
	                    <p>${ msl.creatorName }</p>
	                </div>
	            </div>
	        </c:forEach>
	    </c:if>
	</div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>