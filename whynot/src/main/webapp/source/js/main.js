document.addEventListener("DOMContentLoaded", function() {
	const loadMoreBtn = document.getElementById("loadMoreBtn");
	const videoContainer = document.getElementById("videoContainer");

	loadMoreBtn.addEventListener("click", function() {
		let currentPage = parseInt(loadMoreBtn.getAttribute("data-page"));
		const totalPages = parseInt(loadMoreBtn.getAttribute("data-total"));

		if (currentPage + 1 >= totalPages) {
			loadMoreBtn.style.display = "none"; // 마지막 페이지면 버튼 숨기기
		}

		fetch(`${location.origin}?page=${currentPage + 1}`)
			.then(response => response.text())
			.then(html => {
				// 응답 HTML에서 동적으로 영상 리스트 부분 추출 (새로운 데이터만 가져오기)
				const parser = new DOMParser();
				const doc = parser.parseFromString(html, "text/html");
				const newVideos = doc.querySelectorAll(".video-item");

				newVideos.forEach(video => videoContainer.appendChild(video));
				loadMoreBtn.setAttribute("data-page", currentPage + 1);
			})
			.catch(error => console.error("Error loading more videos:", error));
	});
});