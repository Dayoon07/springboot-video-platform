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
	
	        <form action="${ cl }/search" method="get" autocomplete="on" class="flex items-center space-x-4">
	            <input type="text" name="t" class="w-96 p-2 rounded bg-gray-800 text-white" placeholder="검색" required>
	            <button type="submit" class="bg-red-600 hover:bg-red-500 text-white px-4 py-2 rounded">검색</button>
	        </form>
	
	        <div class="flex items-center space-x-4 font-semibold">
	            <c:if test="${ empty sessionScope.creatorSession }">
					<a href="${ cl }/login" class="btn text-white hover:text-black hover:bg-white border-2 border-white rounded px-4 py-2 mx-2 transition-all duration-300">로그인</a>
					<a href="${ cl }/signup" class="btn text-white hover:text-black hover:bg-white border-2 border-white rounded px-4 py-2 mx-2 transition-all duration-300">회원가입</a>
				</c:if>
				<c:if test="${ not empty sessionScope.creatorSession }">
				  	<a href="${ cl }/upload" class="btn text-white hover:text-black hover:bg-white border-2 border-white rounded-lg px-4 py-2 
				  		transition-all duration-300">업로드</a>
			        <a href="${ cl }/you" class="text-white text-xl">${ sessionScope.creatorSession.creatorName }</a>
				  	<img src="${ sessionScope.creatorSession.profileImgPath }" id="profile" class="w-10 h-10 border-gray-100 border-2 rounded-full cursor-pointer">
				  	
				  	<div id="profileDropdownMenu" class="fixed top-0 right-0 w-full h-full z-10 hidden"></div>
				  	
				  	<div id="profileDropdown" class="fixed top-16 right-4 bg-white py-1 text-black w-72 border z-20 rounded-lg font-normal hidden">
				  		<div class="flex px-4 pb-1">
				  			<img src="${ sessionScope.creatorSession.profileImgPath }" class="w-16 h-16 rounded-full">
				  			<div class="ml-2">
				  				<p class="text-xl py-1 font-normal cursor-pointer">${ sessionScope.creatorSession.creatorName }</p>
				  				<a href="${ cl }/channel/${ sessionScope.creatorSession.creatorName }" class="text-blue-600 hover:underline">내 채널 보기</a>
				  			</div>
				  		</div><hr>
				  		
				  		<div>
				  			<a href="${ cl }/you" class="block w-full text-lg py-2 px-4 hover:bg-gray-200">내 페이지</a>
				  			<form action="${ cl }/logout" method="post" autocomplete="off">
						        <button type="submit" class="block text-left w-full text-lg py-2 px-4 hover:bg-gray-200">로그아웃</button>
							</form>
				  		</div>
				  	</div>
				</c:if>
	        </div>
	        
	    </div>
	</header>
	
	<div class="fixed top-0 left-0 w-full h-full z-50 bg-black opacity-50 hidden" id="sidebar-drop" onclick="closeSide()"></div>
	
	<aside id="sidebar" class="w-64 h-full fixed left-0 top-0 py-2 bg-black text-white z-50 transform -translate-x-full transition-transform overflow-y-scroll">
	    <div class="w-full bg-black flex items-center p-4" style="height: 56px;">
	        <button class="text-white text-3xl mr-5 cursor-pointer" onclick="closeSide()">&#9776;</button>
	        <a href="/" class="text-2xl font-bold">
		    	<span class="text-red-600">Why</span><span class="text-white">not</span>
			</a>
		</div>
	    <ul class="space-y-2 pt-4 px-4">
		    <li><a href="${ cl }/" class="block py-2 px-4 rounded-md hover:bg-gray-800">홈</a></li>
		    <li><a href="${ cl }/mySubscri" class="block py-2 px-4 rounded-md hover:bg-gray-800">구독</a></li>
		    <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-800">좋아요를 누른 영상</a></li>
		    <c:if test="${ not empty sessionScope.creatorSession }">
		        <li><a href="${ cl }/channel/${ sessionScope.creatorSession.creatorName }" class="block py-2 px-4 rounded-md hover:bg-gray-800">내 채널</a></li>
		    </c:if>
		    <hr class="my-2 border-gray-600">
		    <li class="font-semibold text-gray-400 uppercase">탐색</li>
		    <li><a href="${ cl }/tag/music" class="block py-2 px-4 rounded-md hover:bg-gray-800">음악</a></li>
		    <li><a href="${ cl }/tag/movie" class="block py-2 px-4 rounded-md hover:bg-gray-800">영화</a></li>
		    <li><a href="${ cl }/tag/game" class="block py-2 px-4 rounded-md hover:bg-gray-800">게임</a></li>
		    <li><a href="${ cl }/tag/sports" class="block py-2 px-4 rounded-md hover:bg-gray-800">스포츠</a></li>
		    <li><a href="${ cl }/tag/edu" class="block py-2 px-4 rounded-md hover:bg-gray-800">교육</a></li>
		    <hr class="my-2 border-gray-600">
		    <li class="font-semibold text-gray-400 uppercase">내 콘텐츠</li>
		    <li><a href="${ cl }/myVideo" class="block py-2 px-4 rounded-md hover:bg-gray-800">내 영상</a></li>
		    <li><a href="#" class="block py-2 px-4 rounded-md hover:bg-gray-800">시청 기록</a></li>
		</ul><br>
		<div class="w-full">
			<div class="border-gray-600 border-t border-b py-2 px-4">
				<a href="mailto:gangd0642@gmail.com" class="block py-2 px-4 rounded-md hover:bg-gray-800">문의하기</a>
			</div>
	    	<p class="text-sm text-gray-500 mt-4 px-4">
	    		&copy; 2024 Whynot. <br> All rights reserved. <br>
        		영상 제작자가 whynot에서 게시한 영상은 각 영상 제작자의 소유이며 저작권을 인정하며
        		whynot은 영상 제작자가 만든 영상에 관여하지 않으며, 그와 관련된 책임을 지지 않습니다.
    		</p>
	    </div>
	</aside>