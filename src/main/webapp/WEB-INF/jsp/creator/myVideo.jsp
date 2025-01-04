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
    <title>whynot studio</title>
</head>
<body class="flex flex-col h-screen">
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <main class="flex flex-grow" style="height: calc(100% - 76px);">
        <div class="w-64 bg-gray-200">
            <ul>
                <li>
                    <a href="#" class="block p-4 rounded bg-gray-200 hover:bg-white transition">대시보드</a>
                </li>
                <li>
                    <a href="#" class="block p-4 rounded bg-gray-200 hover:bg-white transition">콘텐츠</a>
                </li>
                <li>
                    <a href="#" class="block p-4 rounded bg-gray-200 hover:bg-white transition">분석</a>
                </li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6" style="width: calc(100% - 256px);"> <!-- Main Content -->
            <div class="border-b border-gray-200">
                <nav class="flex space-x-4" id="tabs">
                    <button class="py-2 px-4 text-blue-600 border-b-2 border-blue-600" onclick="showTab('videos')">영상</button>
                    <button class="py-2 px-4 text-gray-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('analytics')">분석</button>
                    <button class="py-2 px-4 text-gray-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('comments')">댓글</button>
                </nav>
            </div>

            <!-- Tab Contents -->
            <div id="videos" class="mt-6">
                <h2 class="text-xl font-bold mb-4">업로드된 영상</h2>
                <div>
                    <div class="grid grid-cols-12 gap-4 px-6 py-3 border-b border-gray-400 font-medium text-sm">
                        <div class="col-span-6">동영상</div>
                        <div class="col-span-1 text-right">가시성</div>
                        <div class="col-span-2 text-right">날짜</div>
                        <div class="col-span-1 text-right">조회수</div>
                        <div class="col-span-1 text-right">댓글</div>
                        <div class="col-span-1 text-right">좋아요</div>
                    </div>
                    <div class="divide-y">
                    	<c:forEach var="mvdos" items="${ myvideos }">
                        	<div class="grid grid-cols-12 gap-4 px-6 py-4 hover:bg-gray-200">
	                            <div class="col-span-6 flex items-center">
	                                <img src="${ mvdos.imgPath }" class="w-40 rounded">
	                                <div class="ml-4">
	                                    <h3 class="font-medium">${ mvdos.title }</h3>
	                                    <p class="text-sm text-gray-400">${ mvdos.more }</p>
	                                </div>
	                            </div>
	                            <div class="col-span-1 text-right flex items-center justify-end">
	                                <span class="px-2 py-1 bg-blue-500 rounded text-xs">공개</span>
	                            </div>
	                            <div class="col-span-2 text-right text-sm text-gray-400 flex items-center justify-end">${ mvdos.createAt }</div>
	                            <div class="col-span-1 text-right text-sm text-gray-400 flex items-center justify-end">${ mvdos.views }</div>
	                            <div class="col-span-1 text-right text-sm text-gray-400 flex items-center justify-end">${ mvdos.commentCount }</div>
	                            <div class="col-span-1 text-right text-sm text-gray-400 flex items-center justify-end">${ mvdos.likes }</div>
	                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div id="analytics" class="mt-6 hidden">
                <h2 class="text-xl font-bold mb-4">분석</h2>
                <p>이곳에 분석 데이터를 추가하세요.</p>
            </div>

            <div id="comments" class="mt-6 hidden">
                <h2 class="text-xl font-bold mb-4">댓글</h2>
                <p>이곳에 댓글 내용을 추가하세요.</p>
            </div>
            
        </div>
    </main>

	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>
