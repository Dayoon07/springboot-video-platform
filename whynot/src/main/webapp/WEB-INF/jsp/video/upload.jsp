<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> <!-- JSTL 코어 태그 라이브러리 -->
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %> <!-- JSTL 함수 태그 라이브러리 -->
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> <!-- JSTL 포맷 태그 라이브러리 -->
<c:set var="cl" value="${ pageContext.request.contextPath }" /> <!-- 컨텍스트 경로 저장 변수 설정 -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 반응형 웹 설정 -->
    <link rel="icon" href="${ cl }/source/img/videoPlayer-icon.png" type="image/x-icon"> <!-- 파비콘 설정 -->
    <link rel="stylesheet" href="${ cl }/source/css/custom.css"> <!-- 커스텀 CSS 파일 로드 -->
	<title>업로드 - whynot</title> <!-- 페이지 제목 -->
</head>
<body>
	<!-- 헤더 포함 -->
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	<!-- 메인 컨텐츠 영역 - 업로드 폼 -->
	<div class="max-w-6xl mx-auto m-8 p-8 bg-white rounded-lg">
	    <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">영상 업로드</h1>
	    <!-- 멀티파트 폼 - 파일 업로드를 위해 enctype 속성 필수 -->
	    <form action="${ cl }/uploadVideo" method="post" enctype="multipart/form-data" class="space-y-8">
	        <div class="flex flex-wrap gap-6">	
	            <!-- 파일 업로드 영역 (왼쪽 컬럼) -->
	            <div class="space-y-6 w-full px-4">
	                <!-- 섬네일 이미지 업로드 영역 -->
	                <div>
					    <label for="imgPath" class="block text-lg font-semibold mb-2 text-gray-700">섬네일 이미지</label>
					    <!-- 드래그 앤 드롭 영역 -->
					    <div id="imgDropZone" class="w-full p-6 bg-gray-50 border-2 border-dashed border-gray-300 text-center rounded-lg cursor-pointer">
					        <p class="text-gray-600">이미지를 드래그 앤 드롭 <br> 하거나 클릭하여 선택하세요</p>
					        <input type="file" id="imgPath" name="imgPath" accept="image/*" class="hidden" required>
					    </div>
					    <!-- 섬네일 미리보기 영역 -->
					    <div id="thumbnailPreview" class="mt-4 flex justify-center items-center">
					        <img id="previewImg" class="hidden w-full object-cover border rounded-md">
					    </div>
					</div>
					
					<!-- 영상 파일 업로드 영역 -->
					<div>
					    <label for="videoPath" class="block text-lg font-semibold mb-2 text-gray-700">영상 파일</label>
					    <!-- 드래그 앤 드롭 영역 -->
					    <div id="videoDropZone" class="w-full p-6 bg-gray-50 border-2 border-dashed border-gray-300 text-center rounded-lg cursor-pointer">
					        <p class="text-gray-600">영상을 드래그 앤 드롭 <br> 하거나 클릭하여 선택하세요</p>
					        <input type="file" id="videoPath" name="videoPath" accept="video/*" class="hidden" onchange="videoLen(event)" required>
					    </div>
					    <!-- 비디오 미리보기 영역 -->
					    <div id="videoPreview" class="mt-4 flex justify-center items-center">
					        <video id="previewVideo" class="hidden w-full border rounded-md" controls></video>
					    </div>
					</div>
					
					<!-- 영상 길이 저장용 히든 필드 -->
					<div>
						<input type="hidden" name="videoLen" value="">
					</div>
	            </div>
	            
	            <!-- 영상 정보 입력 영역 (오른쪽 컬럼) -->
	            <div class="space-y-6 w-full px-4">
	                <!-- 영상 제목 입력 필드 -->
	                <div>
	                    <label for="title" class="block text-lg font-semibold mb-2 text-gray-700">영상 제목</label>
	                    <textarea class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400 resize-none" 
	                    	id="title" name="title" placeholder="영상 제목을 입력하세요" rows="3" required></textarea>
	                </div>
	                <!-- 영상 태그 입력 필드 -->
	                <div>
	                    <label for="tag" class="block text-lg font-semibold mb-2 text-gray-700">영상 태그</label>
	                    <input class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" 
	                    	id="tag" name="tag" placeholder="태그를 입력하세요">
	                </div>
	                <!-- 영상 설명 입력 필드 -->
	                <div>
	                    <label for="more" class="block text-lg font-semibold mb-2 text-gray-700">영상 설명</label>
	                    <textarea id="more" name="more" rows="15" class="resize-none w-full p-3 bg-gray-50 rounded-lg border border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" placeholder="영상 설명을 입력하세요"></textarea>
	                </div>
	            </div>
	        </div>
	
	        <!-- 폼 제출 버튼 -->
	        <div class="text-right">
	            <button type="submit" class="bg-red-600 hover:bg-red-400 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-300">
	                업로드
	            </button>
	        </div>
	    </form>
	</div>
	
	<!-- 필요한 스크립트 로드 -->
	<script src="https://cdn.tailwindcss.com"></script> <!-- Tailwind CSS -->
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script> <!-- jQuery -->
	<script src="${ cl }/source/js/upload.js"></script> <!-- 업로드 관련 자바스크립트 -->
	<script src="${ cl }/source/js/script.js"></script> <!-- 공통 자바스크립트 -->
	
	<script>
		document.querySelector("button[type='submit']").addEventListener("click", function(e) {
			const title = document.getElementById("title");
			const tag = document.getElementById("tag");
			const more = document.getElementById("more");
			const imgPath = document.getElementById("imgPath");
			const videoPath = document.getElementById("videoPath");
	
			if (title.value == "") {
				alert("영상 제목을 입력하세요.");
				e.preventDefault();
				return;
			}
	
			if (tag.value == "") {
				alert("영상 태그를 입력하세요.");
				e.preventDefault();
				return;
			}
	
			if (more.value == "") {
				alert("영상 설명을 입력하세요.");
				e.preventDefault();
				return;
			}
	
			if (imgPath.files.length != 1) {
				alert("섬네일 이미지를 선택하세요.");
				e.preventDefault();
				return;
			}
	
			if (videoPath.files.length != 1) {
				alert("영상 파일을 선택하세요.");
				e.preventDefault();
				return;
			}
		});
	</script>
	
</body>
</html>