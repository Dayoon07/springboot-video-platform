<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
	<title>${ watchTheVideo.title } - whynot</title>
</head>
<body>
	<jsp:include page="${ cl }/WEB-INF/common/header.jsp" />
	
	<div class="container mx-auto py-10 px-5 flex justify-between">
	    <div class="w-10/12 px-4 mx-auto">
		    <div class="aspect-video bg-black rounded-lg overflow-hidden">
		        <video controls autoplay class="w-full h-full">
		            <source src="${ watchTheVideo.videoPath }" type="video/mp4">
		        </video>
		    </div>
		
		    <div class="mt-5">
		        <h1 class="text-2xl font-bold">${ watchTheVideo.title }</h1>
		        
		        <div class="flex mt-2">
		            <div>
		            	<a href="${ cl }/channel/${ videoCreatorProfileInfo.creatorName }" class="flex items-center">
			                <img src="${ videoCreatorProfileInfo.profileImgPath }" alt="${ videoCreatorProfileInfo.creatorName } 프로필" class="w-10 h-10 rounded-full border-2 border-gray-300">
			            </a>
		            </div>
					<div class="text-sm text-gray-600 px-3">
						<a href="${ cl }/channel/${ videoCreatorProfileInfo.creatorName }" class="text-sm font-semibold hover:underline text-gray-900">
							${ videoCreatorProfileInfo.creatorName }
						</a>
						<p>구독자 ${ videoCreatorProfileInfo.subscribe }명</p>
					</div>
		        </div>
		
		        <div class="flex items-center space-x-3 mt-3">
		            <button class="px-6 py-2 bg-gray-200 rounded-full hover:bg-gray-300 transition flex items-center space-x-2">
		                <span class="ml-1">좋아요 ${ watchTheVideo.likes }</span>
		            </button>
		            <button class="px-6 py-2 bg-gray-200 rounded-full hover:bg-gray-300 transition flex items-center space-x-2">
		                <span class="ml-1">싫어요 ${ watchTheVideo.unlikes }</span>
		            </button>
		            <c:if test="${ thisIsSubscribed }">
					    구독중
					</c:if>
					<c:if test="${ sessionScope.creatorSession != null }">
						<c:if test="${ !thisIsSubscribed }">
						    <form action="${ cl }/subscri?subscriberId=${ creator.creatorId }&subscribingId=${ sessionScope.creatorSession.creatorId }" method="post" autocomplete="off">
						        <button type="submit" class="px-6 py-2 mt-3 bg-black text-white rounded-full hover:bg-white hover:shadow-xl hover:text-black transition duration-300">
						            구독
						        </button>
						    </form>
						</c:if> 
					</c:if>
					<c:if test="${ sessionScope.creatorSession == null }">
						<h1>구독은 로그인 후 사용 하실 수 있습니다</h1>
					</c:if>
		        </div>
		    </div>
		
		    <div class="mt-5 p-4 bg-gray-100 rounded-lg">
			    <div class="text-sm text-gray-500 flex justify-start items-center mb-2">
			        <span>조회수: ${ watchTheVideo.views }</span>
			        <span class="px-5">업로드 날짜: ${ watchTheVideo.createAt.substring(0, 13) }</span>
			    </div>
			    <p class="text-md	 text-gray-700 mb-3">
			        <span class="font-semibold text-gray-900">태그</span>
			        <a href="${ cl }/tag/${ watchTheVideo.tag }" class="text-blue-600 hover:underline">
			            #${ watchTheVideo.tag }
			        </a>
			    </p>
			    <c:if test="${ watchTheVideo.more.length() > 10 }">
				    <details class="text-sm text-gray-700">
				        <summary class="cursor-pointer hover:text-blue-600">
				            ${ watchTheVideo.more.substring(0, 10) }...
				        </summary>
				        <p class="mt-1">
				            ${ watchTheVideo.more.substring(11, watchTheVideo.more.length()) }
				        </p>
				    </details>
			    </c:if>
			    <c:if test="${ watchTheVideo.more.length() < 10 }">
			    	<p class="mt-1">
						${ watchTheVideo.more }
					</p>
			    </c:if>
			</div>
		
		    <div class="mt-10">
		        <h2 class="text-lg font-bold mb-3">댓글 
		        	<c:if test="${ empty watchTheVideoCommentList }">
		        		없음
		        	</c:if>
		        	<c:if test="${ not empty watchTheVideoCommentList }">
		        		${ watchTheVideoCommentList.size() }개
		        	</c:if>
		        </h2>
				<div class="mb-10">
					<c:if test="${ not empty sessionScope.creatorSession }">
						<form action="${ cl }/commentAdd" method="post" autocomplete="off">
						    <div class="flex space-x-4 items-start">
						        <img src="${ sessionScope.creatorSession.profileImgPath }" class="w-10 h-10 rounded-full">
						        <input type="hidden" name="creatorId" value="${ sessionScope.creatorSession.creatorId }" required readonly>
						        <input type="hidden" name="commentVideo" value="${ watchTheVideo.videoId }" required readonly>
						        <textarea rows="1" name="commentContent" placeholder="댓글을 입력하세요..." class="w-full resize-none border-b 
						         p-2 focus:border-gray-400 focus:outline-none text-black" required></textarea>
						    </div>
						    <div class="text-right mt-3">
						        <button type="reset" class="px-4 py-2 text-sm font-medium text-gray-500 bg-gray-100 rounded-md hover:bg-gray-200 mr-2">
						            취소
						        </button>
						        <button type="submit" class="px-4 py-2 text-sm font-medium text-white bg-blue-500 rounded-md hover:bg-blue-600">
						            댓글 작성
						        </button>
						    </div>
						</form>
					</c:if>
					<c:if test="${ empty sessionScope.creatorSession }">
						<h1>댓글은 로그인 후 사용할 수 있습니다</h1>
					</c:if>
				</div>
						
		        <div class="space-y-4">
		        	<c:if test="${ not empty watchTheVideoCommentList }">
			        	<c:forEach var="comment" items="${ watchTheVideoCommentList }">
				            <div class="p-3 hover:bg-gray-100 flex">
				            	<div>
				            		<a href="${ cl }/channel/${ comment.commenter }">
				            			<img src="${ comment.commenterProfilepath }" class="w-10 h-10 rounded-full">
				            		</a>
				            	</div>
				            	<div class="px-3">
				            		<span class="text-md font-bold">
				            			<a href="${ cl }/channel/${ comment.commenter }" class="${ comment.commenter.equals(videoCreatorProfileInfo.creatorName) ? 'bg-gray-400 rounded-full text-white px-3 pb-1 mr-2' : '' }">
				            				${ comment.commenter }
				            			</a>
				            		</span>
				            		<span class="text-sm text-gray-400">날짜 : 
				            			${ comment.datetime.substring(0, 10) }
				            		</span>
				            		<p>${ comment.commentContent }</p>
				            	</div>
				            </div>
			            </c:forEach>
		            </c:if>
		        </div>
		    </div>
		</div>
		
	    <div class="w-96 border rounded-lg overflow-y-scroll" style="height: 800px;">
	    	<c:forEach var="rec" items="${ recentVideo }" varStatus="recentStatus">
	    		<c:if test="${ recentStatus.index < 20 }">
	    			<div class="flex flex-col gap-2 p-4 hover:bg-gray-200">
		                <div class="relative group">
		                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
		                        <a href="${ cl }/watch?v=${ rec.v }">
		                        	<img src="${ rec.imgPath }" alt="Video thumbnail" class="w-full h-full object-cover">
		                        </a>
		                    </div>
		                </div>
		                <div class="flex gap-2">
		                    <a href="${ cl }/channel/${ rec.creator }">
		                    	<img src="${ rec.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
		                    </a>
		                    <div class="flex-1 min-w-0">
		                        <a href="${ cl }/watch?v=${ rec.v }" class="font-medium text-sm line-clamp-2 hover:underline">
		                        	${ rec.title }
		                        </a>
		                        <a href="${ cl }/channel/${ rec.creator }" class="text-sm text-gray-600 hover:underline">
		                        	${ rec.creator }
		                        </a>
		                        <div class="text-sm text-gray-600">
		                        	조회수 ${ rec.views == 0 ? "없음" : rec.views } | 	${ rec.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
		                        	 ? rec.createAt.substring(6, 13) : rec.createAt.substring(0, 13) }
		                        </div>
		                    </div>
		                </div>
		            </div>
	    		</c:if>
	    	</c:forEach>
	    </div>
	</div>
	
	<jsp:include page="${ cl }/WEB-INF/common/footer.jsp" />
</body>
</html>