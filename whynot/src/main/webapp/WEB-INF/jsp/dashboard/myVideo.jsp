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
    <title>whynot studio - 업로드한 영상</title>
</head>
<body class="flex flex-col h-screen">
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <main class="flex flex-grow" style="height: calc(100% - 76px); overflow: scroll;">
        <div class="w-64 bg-gray-200">
            <ul>
                <li>
                    <a href="${ cl }/myVideo/dashboard" class="block p-4 rounded bg-gray-200 hover:bg-white transition">대시보드</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo" class="block p-4 rounded bg-gray-200 bg-white hover:bg-white transition">콘텐츠</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo/analysis" class="block p-4 rounded bg-gray-200 hover:bg-white transition">분석</a>
                </li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6" style="width: calc(100% - 256px);">
			<h2 class="text-2xl font-bold mb-4">업로드된 영상</h2>
			<c:forEach var="mvdos" items="${ myvideos }">
				<div class="w-full flex my-5">
					<div>
						<a href="${ cl }/watch?v=${ mvdos.v }">
							<img src="${ mvdos.imgPath }" class="w-72 h-auto rounded mr-4">
						</a>
					</div>
					<div class="px-4 py-2">
						<c:choose>
							<c:when test="${ mvdos.title.length() > 100}">
					        	<h3 class="font-medium">${ mvdos.title.substring(0, 100) += "..." }</h3>
					        </c:when>
							<c:otherwise>
					        	<h3 class="font-medium">${ mvdos.title }</h3>
					        </c:otherwise>
						</c:choose>
						<c:choose>
					    	<c:when test="${ mvdos.more.length() > 100 }">
					        	<p class="text-sm text-gray-400">
					        		${ mvdos.more.substring(0, 75) } <br>
					        		${ mvdos.more.substring(75, 125) += "..." }
					        	</p>
					        </c:when>
							<c:otherwise>
					        	<p class="text-sm text-gray-400">${ mvdos.more }</p>
					        </c:otherwise>
						</c:choose>
						<div class="w-96 mt-2 my-1">
				        	<p class="text-md text-black">
				        		조회수 : ${ mvdos.views } &nbsp; | &nbsp;
				       			좋아요 : ${ mvdos.likes } &nbsp; | &nbsp;
								댓글수 : ${ mvdos.commentCnt }
							</p>
				        </div>
				        <div class="flex justify-between items-center">
				        	<form action="${ cl }/myVideoUpdate" method="post" class="mt-2">
				        		<input type="hidden" name="videoId" value="${ mvdos.videoId }" required readonly>
					    		<button type="submit" class="text-blue-500 hover:underline">수정</button>
					    	</form>
					    	<form action="${ cl }/myVideoDelete" method="post" class="mt-2">
					    		<input type="hidden" name="videoId" value="${ mvdos.videoId }" required readonly>
					    	<button type="submit" class="text-red-500 hover:underline">삭제</button>
					    	</form>
				        </div>
					</div>
				</div>
			</c:forEach>
		</div>
    </main>

	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>
