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
    <title>whynot studio - 분석</title>
</head>
<body class="flex flex-col h-screen">
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <main class="flex flex-grow" style="height: calc(100% - 76px);">
        <div class="w-64 bg-gray-200">
            <ul>
                <li>
                    <a href="${ cl }/myVideo/dashboard" class="block p-4 rounded bg-gray-200 hover:bg-white transition">대시보드</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo" class="block p-4 rounded bg-gray-200 hover:bg-white transition">콘텐츠</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo/analysis" class="block p-4 rounded bg-gray-200 bg-white hover:bg-white transition">분석</a>
                </li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6" style="width: calc(100% - 256px);"> <!-- Main Content -->
            <div class="border-b border-gray-200">
                <nav class="flex space-x-4" id="tabs">
                    <button class="py-2 px-4 text-blue-600 border-b-2 border-blue-600" onclick="showTab('dashboard')">대시보드</button>
                    <button class="py-2 px-4 text-gray-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('analytics')">분석</button>
                    <button class="py-2 px-4 text-gray-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('comments')">댓글</button>
                </nav>
            </div>

            <div id="dashboard" class="mt-6">
			    <h2 class="text-2xl font-bold mb-6">대시보드</h2>
			    
			    <div class="bg-white p-4 rounded-lg shadow-lg mb-6">
			        <h3 class="text-xl font-semibold mb-4">영상 통계</h3>
			        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
			            <div class="text-center p-4 border border-gray-200 rounded-lg">
			                <h4 class="text-lg font-semibold">총 업로드된 영상</h4>
			                <p class="text-3xl font-bold">23</p>
			            </div>
			            <div class="text-center p-4 border border-gray-200 rounded-lg">
			                <h4 class="text-lg font-semibold">총 조회수</h4>
			                <p class="text-3xl font-bold">1,540,234</p>
			            </div>
			            <div class="text-center p-4 border border-gray-200 rounded-lg">
			                <h4 class="text-lg font-semibold">총 좋아요</h4>
			                <p class="text-3xl font-bold">12,435</p>
			            </div>
			            <div class="text-center p-4 border border-gray-200 rounded-lg">
			                <h4 class="text-lg font-semibold">총 댓글 수</h4>
			                <p class="text-3xl font-bold">1,234</p>
			            </div>
			        </div>
			    </div>
			    
			    <div class="bg-white p-4 rounded-lg shadow-lg mb-6">
			        <h3 class="text-xl font-semibold mb-4">좋아요 관리</h3>
			        <table class="min-w-full table-auto">
			            <thead>
			                <tr class="bg-gray-100 text-left">
			                    <th class="py-2 px-4">영상 제목</th>
			                    <th class="py-2 px-4">좋아요 수</th>
			                    <th class="py-2 px-4">좋아요 한 사용자</th>
			                    <th class="py-2 px-4">날짜</th>
			                </tr>
			            </thead>
			            <tbody>
			                <tr>
			                    <td class="py-2 px-4 border-b">영상 제목 A</td>
			                    <td class="py-2 px-4 border-b">234</td>
			                    <td class="py-2 px-4 border-b">김민수</td>
			                    <td class="py-2 px-4 border-b">2025-01-15</td>
			                </tr>
			                <tr>
			                    <td class="py-2 px-4 border-b">영상 제목 B</td>
			                    <td class="py-2 px-4 border-b">125</td>
			                    <td class="py-2 px-4 border-b">이수진</td>
			                    <td class="py-2 px-4 border-b">2025-01-17</td>
			                </tr>
			                <tr>
			                    <td class="py-2 px-4 border-b">영상 제목 C</td>
			                    <td class="py-2 px-4 border-b">876</td>
			                    <td class="py-2 px-4 border-b">박철호</td>
			                    <td class="py-2 px-4 border-b">2025-01-18</td>
			                </tr>
			            </tbody>
			        </table>
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