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
    <title>whynot - 모든 댓글</title>
</head>
<body class="flex flex-col h-screen">
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <main class="flex flex-grow border-t" style="height: calc(100% - 76px);">
        <div class="w-64 bg-gray-200 border-r">
            <ul>
            	<li>
                    <a href="${ cl }/myVideo" class="block p-4 bg-gray-200 hover:bg-white transition">콘텐츠</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo/dashboard" class="block p-4 bg-gray-200 hover:bg-white transition">대시보드</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo/comment" class="block p-4 bg-white hover:bg-white transition">댓글</a>
                </li>
                <li>
	                <a href="${ cl }/myVideo/subscribe" class="block p-4 bg-gray-200 hover:bg-white transition">나를 구독한 유저</a>
	            </li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6" style="width: calc(100% - 256px);">
            <div class="border-b border-gray-200">
                <nav class="flex space-x-4" id="tabs">
                    <button class="py-2 px-4 text-gray-600 border-b-2 border-blue-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('comments')">모든 댓글</button>
                    <button class="py-2 px-4 text-gray-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('commentSearch')">댓글 검색</button>
                </nav>
            </div>

            <div id="comments" class="mt-6">
                <h1 class="text-2xl font-bold mb-4">모든 댓글 ${ myVideoCommentList.size() }개</h1>
                <c:if test="${ empty myVideoCommentList }">
					<h2 class="text-lg text-gray-500">영상에 달린 댓글이 없습니다.</h2>
				</c:if>
                <c:if test="${ not empty myVideoCommentList }">
	                <div style="height: 500px;" class="py-2 border-t border-b overflow-y-scroll">
		                <c:forEach var="mvcl" items="${ myVideoCommentList }">
						    <div class="border-b border-gray-300 py-4">
						        <div class="flex items-start space-x-4">
						            <img src="${ mvcl.commenterProfilepath }" class="w-10 h-10 rounded-full">
						
						            <div class="w-full flex justify-between">
					                    <div>
					                    	<span class="text-sm text-gray-500">${ mvcl.datetime }</span><br>
						                    <span class="font-semibold text-md">${ mvcl.commenter }</span>
							                <p class="mt-1 text-gray-700">${ mvcl.commentContent }</p>
					                    </div>
					                    <div>
					                    	<form action="${ cl }/deleteCommentButAdminAccount" method="post" autocomplete="off">
												<input type="hidden" name="commentId" id="commentId" value="${ mvcl.commentId }" required readonly>
			                                    <button type="submit" class="hover:underline hover:text-red-500 mr-5">댓글 삭제</button>
											</form>
					                    </div>
						            </div>
						        </div>
						    </div>
						</c:forEach>
					</div>
				</c:if>
            </div>
            
            <div id="commentSearch" class="mt-6 hidden">
                <h1 class="text-2xl font-bold mb-4">댓글 검색</h1>
                <div class="mt-6">
				    <div class="bg-white flex rounded border border-2 border-black overflow-hidden w-96 rounded-full">
						<input type="text" id="keywordInput" placeholder="검색할 키워드를 입력하세요" class="w-96 outline-none bg-white pl-4 pr-5 text-sm" required>
					    <button onclick="searchComments()" class="w-20 bg-black transition-all text-white text-sm px-5 py-2 rounded-r-full">검색</button>
					</div>
				</div>
				
				<div id="searchResults" style="height: 500px;" class="mt-4 p-2 border-t border-b overflow-y-scroll"></div>
            </div>
            
        </div>
    </main>
    
	<script src="https://cdn.tailwindcss.com"></script>
    <script src="${ cl }/source/js/searchCommentFetch.js"></script>
	<script src="${ cl }/source/js/script.js"></script>
	<script src="${ cl }/source/js/myVideoTab.js"></script>
	<script src="${ cl }/source/js/main.js"></script>
</body>
</html>