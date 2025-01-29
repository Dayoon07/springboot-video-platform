document.addEventListener("DOMContentLoaded", function() {
	const subscribeElement = document.getElementById("subscribeCount");

	async function fetchSubscribeCount() {
		try {
			const response = await fetch(`/subscribeCount`);
			if (!response.ok) throw new Error("서버 응답 오류");

			const count = await response.json();
			subscribeElement.textContent = count;
			console.log(count);
		} catch (error) {
			console.error("구독자 수 갱신 실패:", error);
		}
	}

	setInterval(fetchSubscribeCount, 5000);

	fetchSubscribeCount();
});
