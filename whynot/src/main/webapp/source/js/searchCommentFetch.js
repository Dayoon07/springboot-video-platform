function searchComments() {
	let keyword = document.getElementById("keywordInput").value;

	fetch(`/searchComments?keyword=${keyword}`)
		.then(response => response.json())
		.then(data => {
			let resultDiv = document.getElementById('searchResults');
			resultDiv.innerHTML = "";

			if (data.length === 0) {
				resultDiv.innerHTML = "<p class='text-gray-500'>검색 결과가 없습니다.</p>";
				return;
			}

			data.forEach(comment => {
				console.log(comment);
				resultDiv.innerHTML += `
						<div class="border-b border-gray-300 py-4">
							<div class="flex items-start space-x-4">
								<img src="${comment.commenterProfilepath}" class="w-10 h-10 rounded-full">
										
								<div class="flex-1">
									<div class="flex justify-between">
										<span class="font-semibold">${comment.commenter}</span>
										<span class="text-sm text-gray-500">${comment.datetime}</span>
									</div>
										                
									<p class="mt-1 text-gray-700">${comment.commentContent}</p>
								</div>
							</div>
						</div>
					`;
			});
		});
}
function searchSubscrubeingUsername() {
	let name = document.getElementById("subscribingName").value;

	fetch(`/selectByMySubscribingUsername?name=${name}`)
		.then(response => response.json())
		.then(data => {
			let resultDiv = document.getElementById('subscribingUserSearchResults');
			resultDiv.innerHTML = "";

			if (!Array.isArray(data) || data.length === 0) {
				resultDiv.innerHTML = "<p class='text-gray-500'>검색 결과가 없습니다.</p>";
				return;
			}

			console.log("Fetched Data:", data);  // 데이터 구조 확인

			data.forEach(user => {
				resultDiv.innerHTML += `
                    <div class="border-b border-gray-300 py-4">
                        <div class="flex items-start space-x-4">
                            <img src="${user.profileImgPath || '/default-profile.png'}" class="w-10 h-10 rounded-full">
                            <div class="flex-1">
                                <div class="flex justify-between">
                                    <span class="font-semibold">${user.creatorName || '알 수 없음'}</span>
                                </div>
                                <p class="mt-1 text-gray-700">구독자 수: ${user.subscribe}</p>
                            </div>
                        </div>
                    </div>
                `;
			});
		})
		.catch(error => console.error("Error fetching data:", error));
}