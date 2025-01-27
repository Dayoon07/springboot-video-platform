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
    <script src="https://cdn.tailwindcss.com"></script>
    <title>whynot studio - 대시보드</title>
</head>
<body class="flex flex-col h-screen">
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <main class="flex flex-grow bg-gray-100" style="height: calc(100% - 76px);">
	    <div class="w-64 bg-gray-200">
	        <ul>
	            <li>
	                <a href="${ cl }/myVideo/dashboard" class="block p-4 bg-white hover:bg-white transition">대시보드</a>
	            </li>
	            <li>
	                <a href="${ cl }/myVideo" class="block p-4 hover:bg-white transition">콘텐츠</a>
	            </li>
	            <li>
	                <a href="${ cl }/myVideo/analysis" class="block p-4 hover:bg-white transition">분석</a>
	            </li>
	        </ul>
	    </div>
	
	    <div class="flex-grow bg-white p-6" style="width: calc(100% - 256px);">
	        <h2 class="text-3xl font-bold mb-6 text-gray-900">📊 대시보드</h2>
	
	        <div class="text-center p-6 border border-gray-300 rounded-lg shadow-lg bg-white">
	            <h4 class="text-lg font-semibold text-gray-700">구독자 수</h4>
	            <p id="subscribeCount" class="text-4xl font-bold">${ sessionScope.creatorSession.subscribe }</p>
	        </div>
	
	        <div class="bg-white p-6 rounded-lg shadow-lg mt-6">
	            <h3 class="text-2xl font-semibold mb-6 text-gray-800">📈 영상 통계</h3>
	
	            <div class="grid grid-cols-1 sm:grid-cols-1 lg:grid-cols-2 gap-6">
	                <div class="text-center p-6 border border-gray-300 rounded-lg shadow-md bg-gray-50">
	                    <h4 class="text-lg font-semibold text-gray-700">총 업로드된 영상</h4>
	                    <p class="text-4xl font-bold text-indigo-600">${ countMyVideos }</p>
	                </div>
	                <div class="text-center p-6 border border-gray-300 rounded-lg shadow-md bg-gray-50">
	                    <h4 class="text-lg font-semibold text-gray-700">총 조회수</h4>
	                    <p class="text-4xl font-bold text-green-600">${ sumMyVideosViews }</p>
	                </div>
	            </div>
	
	            <div class="grid grid-cols-1 sm:grid-cols-1 lg:grid-cols-2 gap-6 mt-6">
	                <div class="text-center p-6 border border-gray-300 rounded-lg shadow-md bg-gray-50">
	                    <h4 class="text-lg font-semibold text-gray-700">총 좋아요</h4>
	                    <p class="text-4xl font-bold text-red-500">${ sumMyVideosLikes }</p>
	                </div>
	                <div class="text-center p-6 border border-gray-300 rounded-lg shadow-md bg-gray-50">
	                    <h4 class="text-lg font-semibold text-gray-700">총 댓글 수</h4>
	                    <p class="text-4xl font-bold text-yellow-500">${ commentCntMyVideos }</p>
	                </div>
	            </div>
	        </div>
	    </div>
	</main>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>