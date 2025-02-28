function createBio() {
	const bioDiv = document.getElementById("myBio");
	const createDiv = document.createElement("textarea");
	const lenDiv = document.getElementById("textLen");

	createDiv.classList.add("w-full", "py-2", "border", "focus:ring-2", "focus:ring-black",
		"focus:outline-none", "resize-none", "overflow-y-hidden");

	document.getElementById("cancelBtn").classList.remove("hidden");

	const createButton = document.querySelector("button[onclick='createBio()']");
	createButton.classList.add("mx-5");
	createButton.textContent = "만들기";

	createDiv.id = bioDiv.id;
	createDiv.name = "bio";
	createDiv.onclick = bioDiv.onclick;
	createDiv.textContent = "아직 자기소개말이 없습니다.";

	createDiv.addEventListener('input', autoResize);
	bioDiv.replaceWith(createDiv);

	lenDiv.textContent = createDiv.value.length;

	createButton.addEventListener("click", (e) => {
		if (document.querySelector("form")) {
			document.querySelector("form").submit();
		} else {
			e.preventDefault();
		}
	});
}
function cancelBio() {
	const bioDiv = document.getElementById("myBio");
	const lenDiv = document.getElementById("textLen");

	document.querySelector("button[onclick='createBio()']").classList.remove("mx-5");
	const createButton = document.querySelector("button[onclick='createBio()']");
	createButton.textContent = "자기소개말 만들기";
	createButton.setAttribute("type", "button");

	const createDiv = document.createElement("div");
	createDiv.id = bioDiv.id;
	createDiv.textContent = "아직 자기소개말이 없습니다.";

	document.getElementById("cancelBtn").classList.add("hidden");

	bioDiv.replaceWith(createDiv);

	lenDiv.textContent = "";
}

function EditBio() {
	const bioDiv = document.getElementById("myBio");
	const createDiv = document.createElement("textarea");
	const lenDiv = document.getElementById("textLen");

	createDiv.classList.add("w-full", "py-2", "border", "focus:ring-2", "focus:ring-black",
		"focus:outline-none", "resize-none", "overflow-y-hidden");

	// 취소 버튼 보이기
	document.getElementById("cancelBtn").classList.remove("hidden");

	// "수정하기" 버튼을 "저장하기"로 변경
	const createButton = document.querySelector("button[onclick='EditBio()']");
	createButton.classList.add("mx-5");
	createButton.textContent = "저장하기";

	// textarea에 기존 내용 넣기 (세션에 저장된 bio로 채운다)
	createDiv.id = bioDiv.id;
	createDiv.name = "bio";
	createDiv.value = bioDiv.textContent.trim() === "아직 자기소개말이 없습니다." ? "" : bioDiv.textContent.trim(); // 기존 bio가 없으면 빈 값으로 처리

	// 텍스트 입력 시 자동 크기 조절
	createDiv.addEventListener('input', autoResize);
	bioDiv.replaceWith(createDiv);

	// 글자 수 업데이트
	lenDiv.textContent = createDiv.value.length;

	// 수정 완료 버튼 클릭 시 폼 제출
	createButton.addEventListener("click", (e) => {
		if (document.querySelector("form")) {
			document.querySelector("form").submit();
		} else {
			e.preventDefault();
		}
	});
}

function EditVerCancelBio() {
	const bioDiv = document.getElementById("myBio");
	const lenDiv = document.getElementById("textLen");

	// "수정하기" 버튼을 원래대로 돌리기
	document.querySelector("button[onclick='EditBio()']").classList.remove("mx-5");
	document.querySelector("button[onclick='EditBio()']").textContent = "자기소개말 수정하기";

	// 기존 bioDiv 복원
	const createDiv = document.createElement("div");
	createDiv.id = bioDiv.id;

	// 취소 버튼 숨기기
	document.getElementById("cancelBtn").classList.add("hidden");

	bioDiv.replaceWith(createDiv);

	// 글자 수 초기화
	lenDiv.textContent = "";
}

function autoResize() {
	const textarea = document.getElementById("myBio");
	const lenDiv = document.getElementById("textLen");

	textarea.style.height = "auto";
	textarea.style.height = textarea.scrollHeight + "px";

	lenDiv.textContent = textarea.value.length;
}
