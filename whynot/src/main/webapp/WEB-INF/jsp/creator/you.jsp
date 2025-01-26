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
    <title>whynot - 마이페이지</title>
</head>
<body>
    <jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <div class="max-w-5xl mx-auto mt-12 p-6 bg-white rounded-xl shadow-lg">
        <c:choose>
            <c:when test="${ empty sessionScope.creatorSession }">
                <div class="text-center py-12">
                    <h1 class="text-2xl font-semibold text-gray-800">로그인이 필요합니다</h1>
                    <p class="text-gray-600 mt-2">마이페이지를 이용하려면 로그인하세요.</p>
                    <a href="${ cl }/login" class="mt-4 inline-block bg-blue-500 text-white px-5 py-2 rounded-lg hover:bg-blue-600">
                        로그인
                    </a>
                </div>
            </c:when>

            <c:otherwise>
                <div class="flex items-center space-x-8">
                    <div class="w-32 h-32 overflow-hidden rounded-full border-4 border-gray-300">
                        <img src="${ sessionScope.creatorSession.profileImgPath }" alt="Profile Image" class="w-full h-full object-cover">
                    </div>

                    <div>
                        <h1 class="text-3xl font-bold text-gray-800">${ sessionScope.creatorSession.creatorName }</h1>
                        <p class="text-gray-500 mt-1">${ sessionScope.creatorSession.creatorEmail }</p>
						<p class="text-gray-500 text-md my-2">구독자 : ${ sessionScope.creatorSession.subscribe }명</p>
						<p class="text-gray-400 text-sm">가입일 : ${ sessionScope.creatorSession.createAt }</p>
                    </div>
                </div>

                <div class="mt-8 p-6 bg-gray-50 rounded-lg shadow-inner">
                    <h2 class="text-xl font-semibold text-gray-800">채널</h2>
                    <p class="text-gray-700 mt-2 leading-relaxed">
                        ${ empty sessionScope.creatorSession.bio ? "아직 자기소개가 없습니다." : sessionScope.creatorSession.bio }
                    </p>
                </div>

                <div class="mt-6 bg-white p-6 rounded-lg border border-gray-200 shadow-sm">
                    <h2 class="text-xl font-semibold text-gray-800">내 정보</h2>
                    <ul class="mt-4 space-y-3 text-gray-700">
                        <li><span class="font-semibold">고유 ID:</span> ${ sessionScope.creatorSession.creatorId }</li>
                        <li><span class="font-semibold">전화번호:</span> ${ sessionScope.creatorSession.tel }</li>
                    </ul>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>
