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
	<title>${ sessionScope.creatorSession.creatorName } 채널 - whynot</title>
</head>
<body>
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
    <div class="max-w-3xl mx-auto mt-10 p-8 bg-white rounded-lg shadow-lg">
	    <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">영상 업로드</h1>
	    <form action="${ cl }/uploadVideo" method="post" enctype="multipart/form-data" class="space-y-6">
	        <div class="flex">
	        	<div class="space-y-6 w-3/6 px-2">
	        		<div>
		                <label for="creatorName" class="block text-lg font-semibold mb-2 text-gray-700">제작자 이름</label>
		                <input type="text" id="creatorName" name="creatorName" class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 
		                	text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" 
		                	value="${ sessionScope.creatorSession.creatorName }" readonly required>
		            </div>
		            <div>
		                <label for="title" class="block text-lg font-semibold mb-2 text-gray-700">영상 제목</label>
		                <input type="text" id="title" name="title" placeholder="영상 제목을 입력하세요" class="w-full p-3 bg-gray-50 rounded-lg border 
		                	border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" required>
		            </div>
		            <div>
		                <label for="more" class="block text-lg font-semibold mb-2 text-gray-700">영상 설명</label>
		                <textarea id="more" name="more" rows="8" class="resize-none w-full p-3 bg-gray-50 rounded-lg border 
		                	border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" 
		                	placeholder="영상 설명을 입력하세요"></textarea>
		            </div>
		        </div>
		        <div class="space-y-6 w-3/6 px-2">
		            <div>
		                <label for="imgPath" class="block text-lg font-semibold mb-2 text-gray-700">섬네일 이미지</label>
		                <input type="file" id="imgPath" name="imgPath" accept="image/*" class="w-full p-3 bg-gray-50 rounded-lg border 
		                	border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" onchange="previewImage(event)" required>
		                <div id="thumbnailPreview" class="mt-4 flex justify-center items-center">
		                    <img id="previewImg" class="hidden w-3/5 object-cover border">
		                </div>
		            </div>
		            <div>
		                <label for="videoPath" class="block text-lg font-semibold mb-2 text-gray-700">영상 파일</label>
		                <input type="file" id="videoPath" name="videoPath" accept="video/*" class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 
		                	text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" required>
		            </div>
		        </div>
	        </div>
	        <div class="text-right">
	            <button type="submit" class="bg-red-600 hover:bg-red-400 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-300">
	                업로드
	            </button>
	        </div>
	    </form>
	</div>

    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            const previewImg = document.getElementById("previewImg");
 
            if (file) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewImg.classList.remove("hidden");
                };

                reader.readAsDataURL(file);
            } else {
                previewImg.src = "";
                previewImg.classList.add("hidden");
            }
        }
    </script>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>