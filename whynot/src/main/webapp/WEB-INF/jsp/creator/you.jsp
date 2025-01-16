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
	
	<c:if test="${ empty you }">
		<h1 class="text-center mt-24 text-3xl">더 많은 기능을 이용하려면 로그인해주세요</h1>
	</c:if>
	
	<c:if test="${ not empty you }">
		<div class="flex max-w-4xl py-10 mx-auto">
	        <div class="w-40 h-40 overflow-hidden rounded-full">
				<img src="${ you.profileImgPath }" alt="Profile Image" class="w-full h-full object-cover">
			</div>
	        <div class="ml-5"> 
	            <h1 class="text-3xl font-semibold mb-5">${ you.creatorName }</h1>
	            <a href="${ cl }/channel/${ you.creatorName }">${ you.creatorName } | 채널 보기</a>
	        </div>
	    </div>
	</c:if>
	
	<div class="max-w-7xl mx-auto mt-10 p-8 bg-white rounded-lg shadow-lg">
        
        <div class="mb-6">
            <ul class="flex space-x-4 border-b">
                <li class="tab-item cursor-pointer px-4 py-2 text-lg font-semibold text-gray-700 hover:text-blue-500" data-tab="dashboard">대시보드</li>
                <li class="tab-item cursor-pointer px-4 py-2 text-lg font-semibold text-gray-700 hover:text-blue-500" data-tab="video-management">영상 관리</li>
                <li class="tab-item cursor-pointer px-4 py-2 text-lg font-semibold text-gray-700 hover:text-blue-500" data-tab="comment-management">댓글 관리</li>
                <li class="tab-item cursor-pointer px-4 py-2 text-lg font-semibold text-gray-700 hover:text-blue-500" data-tab="analytics">영상 분석</li>
                <li class="tab-item cursor-pointer px-4 py-2 text-lg font-semibold text-gray-700 hover:text-blue-500" data-tab="settings">설정</li>
            </ul>
        </div>

        <div class="tab-content active" id="dashboard">
            <h2 class="text-3xl font-bold text-gray-800 mb-6">대시보드</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <div class="bg-gray-100 p-6 rounded-lg shadow-lg text-center">
                    <p class="text-lg font-semibold text-gray-700">총 조회수</p>
                    <p class="text-3xl font-bold text-gray-800">1,234,567</p>
                </div>
                <div class="bg-gray-100 p-6 rounded-lg shadow-lg text-center">
                    <p class="text-lg font-semibold text-gray-700">좋아요 수</p>
                    <p class="text-3xl font-bold text-gray-800">12,345</p>
                </div>
                <div class="bg-gray-100 p-6 rounded-lg shadow-lg text-center">
                    <p class="text-lg font-semibold text-gray-700">댓글 수</p>
                    <p class="text-3xl font-bold text-gray-800">678</p>
                </div>
            </div>
        </div>

        <div class="tab-content" id="video-management">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">영상 관리</h2>
            <div class="overflow-x-auto bg-white shadow-lg rounded-lg">
                <table class="min-w-full table-auto">
                    <thead>
                        <tr>
                            <th class="px-6 py-3 text-left text-lg font-semibold text-gray-700">영상 제목</th>
                            <th class="px-6 py-3 text-left text-lg font-semibold text-gray-700">업로드 날짜</th>
                            <th class="px-6 py-3 text-left text-lg font-semibold text-gray-700">조회수</th>
                            <th class="px-6 py-3 text-left text-lg font-semibold text-gray-700">상태</th>
                            <th class="px-6 py-3 text-left text-lg font-semibold text-gray-700">설정</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="px-6 py-4 text-gray-700">영상 제목 1</td>
                            <td class="px-6 py-4 text-gray-700">2024-12-25</td>
                            <td class="px-6 py-4 text-gray-700">1,234</td>
                            <td class="px-6 py-4 text-gray-700">공개</td>
                            <td class="px-6 py-4 text-gray-700">
                                <button class="text-blue-600 hover:text-blue-400">편집</button>
                                <button class="text-red-600 hover:text-red-400 ml-4">삭제</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="tab-content" id="comment-management">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">댓글 관리</h2>
            <div class="bg-white shadow-lg rounded-lg p-6">
                <div class="flex items-center space-x-4 mb-4">
                    <img src="https://via.placeholder.com/50" alt="User Avatar" class="w-12 h-12 rounded-full">
                    <div>
                        <p class="font-semibold text-gray-800">사용자 이름</p>
                        <p class="text-sm text-gray-600">2024-12-30</p>
                    </div>
                </div>
                <p class="text-gray-700 mb-4">이 영상은 정말 유익합니다! 많은 사람들이 이 영상을 봤으면 좋겠어요.</p>
                <div class="flex space-x-4">
                    <button class="text-blue-600 hover:text-blue-400">답글</button>
                    <button class="text-red-600 hover:text-red-400">삭제</button>
                </div>
            </div>
        </div>

        <div class="tab-content" id="analytics">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">영상 분석</h2>
            <div class="bg-white shadow-lg rounded-lg p-6">
                <div class="h-72 bg-gray-200 rounded-lg">
                    <p class="text-center py-32 text-gray-500">그래프를 여기에 표시하세요.</p>
                </div>
            </div>
        </div>

        <div class="tab-content" id="settings">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">설정</h2>
            <div class="bg-white shadow-lg rounded-lg p-6">
                <div class="flex justify-between items-center mb-4">
                    <p class="text-lg text-gray-700">기본 업로드 설정</p>
                    <button class="text-blue-600 hover:text-blue-400">편집</button>
                </div>
                <div class="flex justify-between items-center mb-4">
                    <p class="text-lg text-gray-700">계정 정보</p>
                    <button class="text-blue-600 hover:text-blue-400">편집</button>
                </div>
            </div>
        </div>

    </div>
    	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>