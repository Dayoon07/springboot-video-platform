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
    <title>whynot - 구독 정보</title>
</head>
<body class="flex flex-col h-screen">
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <main class="flex flex-grow" style="height: calc(100% - 76px);">
        <div class="w-64 bg-gray-200">
            <ul>
            	<li>
                    <a href="${ cl }/myVideo" class="block p-4 rounded bg-gray-200 hover:bg-white transition">콘텐츠</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo/dashboard" class="block p-4 rounded bg-gray-200 hover:bg-white transition">대시보드</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo/comment" class="block p-4 rounded bg-gray-200 hover:bg-white transition">댓글</a>
                </li>
                <li>
	                <a href="${ cl }/myVideo/subscribe" class="block p-4 bg-white hover:bg-white transition">나를 구독한 유저</a>
	            </li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6" style="width: calc(100% - 256px);">
            <div class="border-b border-gray-200">
                <nav class="flex space-x-4" id="tabs">
                    <button class="py-2 px-4 text-gray-600 border-b-2 border-blue-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('comments')">구독한 유저</button>
                    <button class="py-2 px-4 text-gray-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('commentSearch')">구독 유저 검색</button>
                </nav>
            </div>

            <div id="comments" class="mt-6">
                <h1 class="text-2xl font-bold mb-4">모든 구독자 ${ mySubscribeLists.size() }명</h1>
                <div style="height: 700px;" class="py-2 border-t border-b overflow-y-scroll">
	                <c:if test="${ empty mySubscribeLists }">
				        <h2 class="text-lg text-gray-500">나를 구독한 사람이 없습니다.</h2>
				    </c:if>
				    
				    <c:if test="${ not empty mySubscribeLists }">
				        <c:forEach var="msl" items="${ mySubscribeLists }">
				            <div class="w-full p-4 flex items-center gap-6 bg-white rounded-lg shadow">
							    <div class="shrink-0">
							        <c:if test="${ not empty msl.profileImgPath }">
							            <a href="${ cl }/channel/${ msl.creatorName }">
							            	<img src="${ msl.profileImgPath }" alt="${ msl.creatorName }'s profile" 
							            		class="w-20 h-20 rounded-full object-cover border-2 border-gray-200">
							            </a>
									</c:if>
							    </div>
							    <div class="flex flex-col gap-2">
							        <h1 class="text-xl font-bold text-gray-800">
							        	<a href="${ cl }/channel/${ msl.creatorName }">
							        		${ msl.creatorName }
							        	</a>
							        </h1>
							        <p class="text-gray-600">구독자 ${ msl.subscribe }명</p>
							        <p class="text-sm text-gray-500">${ msl.bio }</p>
							    </div>
							</div>
				        </c:forEach>
				    </c:if>
				</div>
            </div>
            
            <div id="commentSearch" class="mt-6 hidden">
                <h1 class="text-2xl font-bold mb-4">구독한 유저 이름 검색</h1>
                <div class="mt-6">
				    <div class="bg-white flex rounded border border-2 border-black overflow-hidden w-96 rounded-full">
						<input type="text" id="subscribingName" placeholder="검색할 유저의 이름을 입력하세요" class="w-96 outline-none bg-white pl-4 pr-5 text-sm" required>
					    <button onclick="searchSubscrubeingUsername()" class="w-20 bg-black transition-all text-white text-sm px-5 py-3 rounded-r-full">검색</button>
					</div>
				</div>
				
				<div id="subscribingUserSearchResults" style="height: 500px;" class="mt-4 p-2 border-t border-b overflow-y-scroll"></div>
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