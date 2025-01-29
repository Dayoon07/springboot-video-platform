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
