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
    <link rel="stylesheet" hidden="${ cl }/source/css/custom.css">
	<title>회원가입</title>
</head>
<body class="bg-gray-900">
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	    <div class="mt-12 mx-auto bg-black p-8 rounded-lg shadow-lg max-w-2xl text-white">
	        <h2 class="text-center text-2xl font-bold mb-4">회원가입</h2>
	        <form action="${ cl }/signupF" method="post" autocomplete="off" enctype="multipart/form-data">
	            <div class="flex justify-between">
	            	<div class="w-96 mx-3">
	            		<div class="mb-4">
						    <label for="creatorName" class="block text-sm mb-2">사용자 이름</label>
			                <input type="text" id="creatorName" name="creatorName" class="w-full p-2 rounded bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-600" required>
						</div>
	            		<div class="mb-4">
			                <label for="creatorEmail" class="block text-sm mb-2">이메일</label>
			                <input type="email" id="creatorEmail" name="creatorEmail" class="w-full p-2 rounded bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-600" required>
			            </div>
			            <div class="mb-4">
			                <label for="creatorPassword" class="block text-sm mb-2">비밀번호</label>
			                <input type="password" id="creatorPassword" name="creatorPassword" class="w-full p-2 rounded bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-600" required>
			            </div>
			            <div class="mb-4">
			                <label for="confirmPassword" class="block text-sm mb-2">비밀번호 확인</label>
			                <input type="password" id="confirmPassword" name="confirmPassword" class="w-full p-2 rounded bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-600" required>
			            </div>
			            <div class="mb-4">
			                <label for="tel" class="block text-sm mb-2">전화번호</label>
			                <input type="tel" id="tel" name="tel" class="w-full p-2 rounded bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-600" required>
			            </div>
	            	</div>
		            <div class="w-96 mx-3">
		            	<div class="mb-4">
							<label for="profileImgPath" class="block text-sm mb-2">프로필 이미지</label>
							<div class="relative bg-gray-800 rounded p-3 flex flex-col items-center justify-center border-2 border border-gray-600 hover:border-red-600">
								<input type="file" id="profileImgPath" name="profileImgPath" class="absolute inset-0 opacity-0 w-full h-full cursor-pointer" accept="image/*" onchange="previewImage(event)">
							    <img id="profilePreview" src="#" alt="미리보기" class="hidden w-28 h-28 object-cover rounded-full" title="미리보기">
							    <p id="uploadText" class="text-sm text-gray-400">이미지를 업로드하려면 <br> 클릭하거나 드래그하세요</p>
							</div>
						</div>
		            	<div class="mb-4">
			                <label for="bio" class="block text-sm mb-2">소개글</label>
			                <textarea id="bio" name="bio" class="w-full p-2 rounded bg-gray-800 text-white focus:outline-none 
			                	focus:ring-2 focus:ring-red-600 resize-none" rows="7"></textarea>
			            </div>
		            </div>
	            </div>
	            <button type="submit" class="w-full bg-red-600 hover:bg-red-500 text-white px-4 py-2 rounded">회원가입</button>
	        </form>
	        <p class="mt-4 text-center text-sm">
	            이미 계정이 있으신가요? <a href="${ cl }/login" class="text-red-600 hover:underline">로그인</a>
	        </p>
	    </div>
	    
	    <script>
		    function previewImage(event) {
		        const file = event.target.files[0];
		        const preview = document.getElementById("profilePreview");
		        const uploadText = document.getElementById("uploadText");
		
		        if (file) {
		            const reader = new FileReader();
		            reader.onload = (e) =>	 {
		                preview.src = e.target.result;
		                preview.classList.remove("hidden");
		                uploadText.style.display = "none";
		            };
		            reader.readAsDataURL(file);
		        }
		    }
		</script>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>