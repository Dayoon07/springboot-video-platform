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

    <div class="max-w-7xl mx-auto p-4">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
            <%
            	for (int i = 0; i < 10; i++) {
            %>
            <div class="flex flex-col gap-2 py-3">
                <div class="relative group">
                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
                        <img src="/api/placeholder/320/180" alt="Video thumbnail" class="w-full h-full object-cover">
                    </div>
                    <div class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity bg-black/20">
                        <i data-lucide="play-circle" class="w-12 h-12 text-white"></i>
                    </div>
                </div>
                <div class="flex gap-2">
                    <div class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0"></div>
                    <div class="flex-1 min-w-0">
                        <h3 class="font-medium text-sm line-clamp-2">Building a Modern Web Application from Scratch</h3>
                        <p class="text-sm text-gray-600">Tech Tutorials</p>
                        <div class="text-sm text-gray-600">125K views • 2 days ago</div>
                    </div>
                </div>
            </div>
            <%
            	}
            %>
        </div>
    </div>

    <jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>
