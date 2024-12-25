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
    <link rel="stylesheet" href="${ cl }/source/css/custom.css">
    <title>whynot!!!</title>
</head>
<body class="bg-gray-100">
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />

    <div class="flex">
        <main class="flex-1 p-4">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <div class="bg-white p-4 rounded shadow">
                    <img src="#" alt="Video Thumbnail" class="rounded-md" style="max-width: 280px; height: 185px;">
                    <h2 class="text-lg font-semibold mt-2">Sample Video Title</h2>
                    <p class="text-gray-600 mt-1">Channel Name</p>
                    <p class="text-sm text-gray-500">1M views • 1 week ago</p>
                </div>
            </div>
        </main>
    </div>

    <jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>
