<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
	<header class="bg-black text-white p-4">
	    <div class="flex items-center justify-between w-full mx-auto">
	        <div class="flex items-center">
	        	<button class="text-white text-3xl mr-5 cursor-pointer" onclick="openSide()">&#9776;</button>
	        	<a href="/" class="text-2xl font-bold">
		            <span class="text-red-600">Why</span><span class="text-white">not</span>
		        </a>
	        </div>
	
	        <div class="flex items-center space-x-4">
	            <input type="text" class="w-96 p-2 rounded bg-gray-800 text-white" placeholder="Search...">
	            <button class="bg-red-600 hover:bg-red-500 text-white px-4 py-2 rounded">검색</button>
	        </div>
	
	        <div class="flex items-center space-x-4 font-semibold">
	            <c:if test="${ empty sessionScope.creatorSession }">
					<a href="${ cl }/login" class="btn text-white hover:text-black hover:bg-white border-2 border-white rounded px-4 py-2 mx-2 transition-all duration-300">로그인</a>
					<a href="${ cl }/signup" class="btn text-white hover:text-black hover:bg-white border-2 border-white rounded px-4 py-2 mx-2 transition-all duration-300">회원가입</a>
				</c:if>
				<c:if test="${ not empty sessionScope.creatorSession }">
				  	<a href="${ cl }/upload" class="btn text-white hover:text-black hover:bg-white border-2 border-white rounded-lg px-4 py-2 mx-2 transition-all duration-300">업로드</a>
					<a href="${ cl }/you" class="text-white text-xl">${ sessionScope.creatorSession.creatorName }</a>
				  	<img src="${ sessionScope.creatorSession.profileImgPath }" class="w-10 h-10 border-gray-100 border-2 rounded-full cursor-pointer">
				</c:if>
	        </div>
	    </div>
	</header>
	
	<div class="fixed top-0 left-0 w-full h-full z-40 bg-black opacity-50 hidden" id="sidebar-drop" onclick="closeSide()"></div>
	
	<!-- hidden lg:block -->
	<aside id="sidebar" class="w-64 h-full fixed left-0 top-0 py-2 bg-black text-white z-50 transform -translate-x-full transition-transform">
	    <div class="w-full bg-black flex items-center p-4" style="height: 56px;">
	        <button class="text-white text-3xl mr-5 cursor-pointer" onclick="closeSide()">&#9776;</button>
	        <a href="/" class="text-2xl font-bold">
		    	<span class="text-red-600">Why</span><span class="text-white">not</span>
			</a>
		</div>
	    <ul class="space-y-2 pt-2">
	        <li><a href="${ cl }/" class="block py-2 px-4 rounded-md hover:bg-gray-700">홈</a></li>
	        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700">구독</a></li>
	        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700">내 페이지</a></li>
	        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700">좋아요를 누른 영상</a></li>
	        <c:if test="${ not empty sessionScope.creatorSession }">
	        	<li><a href="${ cl }/channel/${ sessionScope.creatorSession.creatorName }" class="block py-2 px-4 rounded-md hover:bg-gray-700">내 채널</a></li>
	        </c:if>
	        <details>
	        	<summary class="block py-2 px-4 rounded-md hover:bg-gray-700">카테고리</summary>
		        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700 ml-4">음악</a></li>
		        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700 ml-4">영화</a></li>
		        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700 ml-4">게임</a></li>
		        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700 ml-4">스포츠</a></li>
		        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700 ml-4">교육</a></li>
		        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700 ml-4">팟캐스트</a></li>
	        </details>
	        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700">내 영상</a></li>
	        <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-700">시청 기록</a></li>
	        <c:if test="${ not empty sessionScope.creatorSession }">
	        	<form action="${ cl }/logout" method="post" autocomplete="off">
		        	<input type="hidden" id="creatorId" name="creatorId" value="${ sessionScope.creatorSession.creatorId }" required>
		        	<button type="submit" class="w-60 border mx-2 py-2 px-4 rounded-xl hover:bg-red-600">로그아웃</button>
		        </form>
	        </c:if>
	    </ul><br>
	    <div class="w-full border-gray-600 border-t py-4">
	    	<p class="text-center">&copy; 2024 WhynotTube. <br> All rights reserved.</p>
	    </div>
	</aside>