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
<body class="bg-gray-100">
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
    <div class="flex">
        <aside class="w-64 h-screen fixed bg-white overflow-y-auto border-r border-gray-200">
            <ul class="space-y-2 pt-4 px-4">
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="home" class="w-5 h-5 mr-4"></i>
                        홈
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="play-square" class="w-5 h-5 mr-4"></i>
                        구독
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="thumbs-up" class="w-5 h-5 mr-4"></i>
                        좋아요를 누른 영상
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="user" class="w-5 h-5 mr-4"></i>
                        내 채널
                    </a>
                </li>

                <li><hr class="my-2 border-gray-200"></li>

                <li class="text-xs font-semibold text-gray-500 uppercase px-4">탐색</li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="music" class="w-5 h-5 mr-4"></i>
                        음악
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="film" class="w-5 h-5 mr-4"></i>
                        영화
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="gamepad-2" class="w-5 h-5 mr-4"></i>
                        게임
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="trophy" class="w-5 h-5 mr-4"></i>
                        스포츠
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="book-open" class="w-5 h-5 mr-4"></i>
                        교육
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="mic-2" class="w-5 h-5 mr-4"></i>
                        팟캐스트
                    </a>
                </li>

                <li><hr class="my-2 border-gray-200"></li>

                <li class="text-xs font-semibold text-gray-500 uppercase px-4">내 콘텐츠</li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="video" class="w-5 h-5 mr-4"></i>
                        내 영상
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center px-4 py-2 text-sm rounded-lg hover:bg-gray-100">
                        <i data-lucide="history" class="w-5 h-5 mr-4"></i>
                        시청 기록
                    </a>
                </li>
            </ul>

            <div class="p-4 mt-4">
                <p class="text-xs text-gray-500">
                    &copy; 2024 Whynot. <br>
                    All rights reserved. <br><br>
                    영상 제작자가 whynot에서 게시한 영상은 각 영상 제작자의 소유이며 저작권을 인정하며
                    whynot은 영상 제작자가 만든 영상에 관여하지 않으며, 그와 관련된 책임을 지지 않습니다.
                </p>
            </div>
        </aside>

        <main class="ml-64 flex-1 p-8">
            <div class="mb-6">
                <h1 class="text-2xl font-bold text-gray-800">내가 올린 영상</h1>
                <p class="text-sm text-gray-600">당신이 업로드한 영상 목록을 확인하세요.</p>
            </div>

            <div class="space-y-4">
                <div class="flex bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                    <img src="/api/placeholder/320/180" alt="비디오 썸네일" class="w-72 object-cover">
                    <div class="p-4">
                        <h3 class="font-semibold text-lg text-gray-800">영상 제목</h3>
                        <p class="text-sm text-gray-600">업로드 날짜: 2024-01-03</p>
                        <p class="mt-2 text-sm text-gray-500">조회수 1.2만회</p>
                    </div>
                </div>

                <div class="flex bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                    <img src="/api/placeholder/320/180" alt="비디오 썸네일" class="w-72 object-cover">
                    <div class="p-4">
                        <h3 class="font-semibold text-lg text-gray-800">두 번째 영상</h3>
                        <p class="text-sm text-gray-600">업로드 날짜: 2024-01-02</p>
                        <p class="mt-2 text-sm text-gray-500">조회수 8.5천회</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>