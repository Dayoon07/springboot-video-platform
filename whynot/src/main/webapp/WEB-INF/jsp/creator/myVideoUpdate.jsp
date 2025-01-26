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
    
    <div class="max-w-6xl mx-auto mt-10 p-8 bg-white rounded-lg">
        <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">영상 수정</h1>
        <form action="${ cl }/updateVideo" method="post" enctype="multipart/form-data" class="space-y-8">
            <input type="hidden" name="videoId" value="${ updatingVideo.videoId }">
            
            <div class="flex flex-wrap gap-6">    
                <div class="space-y-6 w-full lg:w-1/3 px-4">
                    <div>
                        <label for="imgPath" class="block text-lg font-semibold mb-2 text-gray-700">섬네일 이미지</label>
                        <div id="imgDropZone" class="w-full p-6 bg-gray-50 border-2 border-dashed border-gray-300 text-center rounded-lg cursor-pointer">
                            <p class="text-gray-600">새 이미지를 드래그 앤 드롭 <br> 하거나 클릭하여 선택하세요</p>
                            <input type="file" id="imgPath" name="imgPath" accept="image/*" class="hidden" onchange="previewImage(event)">
                        </div>
                        <div id="thumbnailPreview" class="mt-4 flex justify-center items-center">
                            <img id="previewImg" src="${ updatingVideo.imgPath }" class="w-3/5 object-cover border rounded-md">
                        </div>
                        <input type="hidden" name="currentImgPath" value="${ updatingVideo.imgPath }">
                    </div>
                    <div>
                        <label for="videoPath" class="block text-lg font-semibold mb-2 text-gray-700">영상 파일</label>
                        <div class="mb-2">
                            <p class="text-sm text-gray-600">현재 영상</p>
                            <video controls autoplay class="w-80 py-5">
					            <source src="${ updatingVideo.videoPath }" type="video/mp4">
					        </video>
                        </div>
                        <input type="file" id="videoPath" name="videoPath" accept="video/*" class="p-6 bg-gray-50 border-2 border-dashed border-gray-300 text-center rounded-lg cursor-pointer">
                        <!-- 기존 비디오 경로 보존 -->
                        <input type="hidden" name="currentVideoPath" value="${ updatingVideo.videoPath }">
                    </div>
                </div>
                
                <div class="space-y-6 w-full lg:w-2/3 px-4">
                    <div>
                        <label for="creatorName" class="block text-lg font-semibold mb-2 text-gray-700">제작자 이름</label>
                        <input type="text" id="creatorName" name="creatorName" class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
                        	value="${ updatingVideo.creator }" readonly required>
                    </div>
                    <div>
                        <label for="tag" class="block text-lg font-semibold mb-2 text-gray-700">영상 태그</label>
                        <input type="text" id="tag" name="tag" value="${ updatingVideo.tag }" class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                    </div>
                    <div>
                        <label for="title" class="block text-lg font-semibold mb-2 text-gray-700">영상 제목</label>
                        <input type="text" id="title" name="title" value="${ updatingVideo.title }" class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" required>
                    </div>
                    <div>
                        <label for="more" class="block text-lg font-semibold mb-2 text-gray-700">영상 설명</label>
                        <textarea id="more" name="more" rows="6" class="resize-none w-full p-3 bg-gray-50 rounded-lg border border-gray-300 
                        	text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400">${ updatingVideo.more }</textarea>
                    </div>
                </div>
            </div>

            <div class="text-right space-x-4">
                <button type="button" onclick="history.back()" class="bg-gray-500 hover:bg-gray-400 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-300">
                    취소
                </button>
                <button type="submit" class="bg-red-600 hover:bg-red-400 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-300">
                    수정하기
                </button>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${ cl }/source/js/upload.js"></script>
    <script src="${ cl }/source/js/script.js"></script>
    <script>
        const imgDropZone = document.getElementById('imgDropZone');
        const imgInput = document.getElementById('imgPath');
        const previewImg = document.getElementById('previewImg');

        imgDropZone.addEventListener('dragover', (e) => {
            e.preventDefault();
            imgDropZone.classList.add('border-blue-500');
        });

        imgDropZone.addEventListener('dragleave', () => {
            imgDropZone.classList.remove('border-blue-500');
        });

        imgDropZone.addEventListener('drop', (e) => {
            e.preventDefault();
            imgDropZone.classList.remove('border-blue-500');
            const file = e.dataTransfer.files[0];
            if (file && file.type.startsWith('image/')) {
                imgInput.files = e.dataTransfer.files;
                previewImage(e);
            }
        });

        imgDropZone.addEventListener('click', () => {
            imgInput.click();
        });

        function previewImage(event) {
            const file = event.target.files ? event.target.files[0] : event.dataTransfer.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewImg.classList.remove('hidden');
                }
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>