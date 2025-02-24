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
    <title>whynot - 작성한 댓글</title>
</head>
<body class="flex flex-col h-screen">
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <main class="flex flex-grow border-t" style="height: calc(100% - 76px);">
        <div class="w-64 h-full bg-gray-200 border-r">
            <ul>
            	<li><a href="${ cl }/myVideo" class="block p-4 bg-gray-200 hover:bg-white transition">콘텐츠</a></li>
	            <li><a href="${ cl }/myVideo/dashboard" class="block p-4 bg-gray-200 hover:bg-white transition">대시보드</a></li>
	            <li><a href="${ cl }/myVideo/comment" class="block p-4 bg-gray-200 hover:bg-white transition">댓글</a></li>
	            <li><a href="${ cl }/myVideo/myComment" class="block p-4 bg-white hover:bg-white transition">작성한 댓글</a></li>
	            <li><a href="${ cl }/myVideo/subscribe" class="block p-4 bg-gray-200 hover:bg-white transition">나를 구독한 유저</a></li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6" style="width: calc(100% - 256px);">
            <div id="comments" class="mt-6">
                <h1 class="text-2xl font-bold mb-4">모든 댓글 ${ myAllComment.size() }개</h1>
                <c:if test="${ empty myAllComment }">
					<h2 class="text-lg text-gray-500">영상에 달린 댓글이 없습니다.</h2>
				</c:if>
                <c:if test="${ not empty myAllComment }">
		                <c:forEach var="mac" items="${ myAllComment }">
						    ${ mac.commentVo } <br>
						    ${ max.videosVo }
						</c:forEach>
				</c:if>
            </div>
        </div>
    </main>
    
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="${ cl }/source/js/script.js"></script>
</body>
</html>