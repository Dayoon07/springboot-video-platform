function model() {
	const div = document.createElement("div");
	div.classList.add("fixed", "top-0", "left-0", "w-full", "h-full", "bg-white", "z-10", "bg-opacity-50");
	div.id = "model";
	div.innerHTML = `
		<button type="button" onclick="closeModel()" class="text-4xl p-5">&times;</button>
        <div style="position: absolute; top: 200px; left: 50%; transform: translate(-50%, 0px); 
            border-radius: 8px; padding: 20px 30px; z-index: 30; background-color: white;" class="shadow-xl max-w-sm w-full">
            <h1 class="text-center text-2xl font-bold mb-4">자기소개말 만들기</h1>
            <form action="${location.origin}/createBio" method="post" autocomplete="off">
	            <textarea placeholder="자기소개말을 작성하세요..." rows="5" name="bio" class="w-full p-3 border border-gray-300 rounded-md mb-4 resize-none"></textarea>
	            <button type="submit" class="w-full bg-black text-white font-semibold py-2 rounded-md hover:opacity-70 
					focus:outline-none focus:ring-2 focus:ring-blue-500">
					작성
	            </button>
            </form>
		</div>
	`;
	document.querySelector("body").append(div);
}
function modelVer2() {
	const a = document.getElementById("youPk").value;
	const div = document.createElement("div");
	div.classList.add("fixed", "top-0", "left-0", "w-full", "h-full", "bg-white", "z-10", "bg-opacity-50");
	div.id = "model";
	
	fetch(`${location.origin}/myInfo?creatorId=${a}`, { method: "post" })
		.then((response) => response.json())
		.then((data) => {
			div.innerHTML = `
				<button type="button" onclick="closeModel()" class="text-4xl p-5">&times;</button>
			    <div style="position: absolute; top: 200px; left: 50%; transform: translate(-50%, 0px); 
			    	border-radius: 8px; padding: 20px 30px; z-index: 30; background-color: white;" class="shadow-xl max-w-sm w-full">
			        <h1 class="text-center text-2xl font-bold mb-4">자기소개말 만들기</h1>
			        <form action="${location.origin}/createBio" method="post" autocomplete="off">
				    	<textarea placeholder="자기소개말을 작성하세요..." rows="5" name="bio" class="w-full p-3 border border-gray-300 rounded-md mb-4 resize-none">${data.bio}</textarea>
				        <button type="submit" class="w-full bg-black text-white font-semibold py-2 rounded-md hover:opacity-70 
							focus:outline-none focus:ring-2 focus:ring-blue-500">
							작성
				        </button>
					</form>
				</div>
			`;
		})
	document.querySelector("body").append(div);
}
document.addEventListener("keydown", (e) => {
	if (e.key === "Escape" && document.getElementById("model") != null) {
		document.getElementById("model").classList.add("hidden");
		document.getElementById("model").id = "123456789";
	}
});

function closeModel() {
	document.getElementById("model").classList.add("hidden");
	document.getElementById("model").id = "123456789";
}