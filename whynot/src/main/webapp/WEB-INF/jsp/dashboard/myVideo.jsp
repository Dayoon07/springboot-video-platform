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
    <title>whynot - 업로드한 영상</title>
</head>
<body class="flex flex-col h-screen">
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <main class="flex flex-grow" style="height: calc(100% - 76px);">
        <div class="w-64 bg-gray-200">
            <ul>
            	<li>
                    <a href="${ cl }/myVideo" class="block p-4 bg-white hover:bg-white transition">콘텐츠</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo/dashboard" class="block p-4 bg-gray-200 hover:bg-white transition">대시보드</a>
                </li>
                <li>
                    <a href="${ cl }/myVideo/comment" class="block p-4 bg-gray-200 hover:bg-white transition">댓글</a>
                </li>
                <li>
	                <a href="${ cl }/myVideo/subscribe" class="block p-4 hover:bg-white transition">나를 구독한 유저</a>
	            </li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6 overflow-y-scroll" style="width: calc(100% - 256px);">
			<h2 class="text-2xl font-bold mb-4">업로드된 영상</h2>
			<c:if test="${ not empty myvideos }">
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
									<a href="${ cl }/watch?v=${ mvdos.v }" class="font-medium hover:underline">
										${ mvdos.title.substring(0, 100) += "..." }
									</a>
						        </c:when>
								<c:otherwise>
									<a href="${ cl }/watch?v=${ mvdos.v }" class="font-medium hover:underline">
										${ mvdos.title }
									</a>
						        </c:otherwise>
							</c:choose>
							<c:choose>
						    	<c:when test="${ mvdos.more.length() > 100 }">
						        	<a href="${ cl }/watch?v=${ mvdos.v }" class="block text-sm text-gray-400 hover:underline">
						        		${ mvdos.more.substring(0, 75) } <br>
						        		${ mvdos.more.substring(75, 125) += "..." }
						        	</a>
						        </c:when>
								<c:otherwise>
									<a href="${ cl }/watch?v=${ mvdos.v }" class="block text-sm text-gray-400 hover:underline">
										${ mvdos.more }
									</a>
						        </c:otherwise>
							</c:choose>
							<div class="w-96 mt-2 my-1">
					        	<p class="text-md text-black">
					        		조회수 : ${ mvdos.views }회 &nbsp; | &nbsp;
					       			좋아요 : ${ mvdos.likes } &nbsp; | &nbsp;
									댓글수 : ${ mvdos.commentCnt }
								</p>
					        </div>
					        <div class="w-96 mt-2 my-1">
					        	<p class="text-md text-black">업로드 날짜 : ${ mvdos.createAt.substring(0, 13) }</p>
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
			</c:if>
			<c:if test="${ empty myvideos }">
				<p class="text-xl text-gray-600">업로드한 영상이 없습니다</p>
			</c:if>
		</div>
    </main>

	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>
