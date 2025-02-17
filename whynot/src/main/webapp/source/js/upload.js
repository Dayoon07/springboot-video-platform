document.addEventListener("DOMContentLoaded", () => {
	const imgDropZone = document.getElementById("imgDropZone");
	const videoDropZone = document.getElementById("videoDropZone");
	const imgInput = document.getElementById("imgPath");
	const videoInput = document.getElementById("videoPath");

	const handleDragOver = (event) => {
		event.preventDefault();
		event.currentTarget.classList.add("border-blue-500", "bg-blue-100");
	};

	const handleDragLeave = (event) => {
		event.currentTarget.classList.remove("border-blue-500", "bg-blue-100");
	};

	const handleDrop = (event, input, type) => {
		event.preventDefault();
		event.currentTarget.classList.remove("border-blue-500", "bg-blue-100");

		const file = event.dataTransfer.files[0];
		if (!file) return;

		if (type === "image" && file.size > 3 * 1024 * 1024) {
			alert("이미지 파일 크기는 최대 3MB까지 가능합니다.");
			return;
		}

		if (type === "video" && file.size > 100 * 1024 * 1024) {
			alert("영상 파일 크기는 최대 100MB까지 가능합니다.");
			return;
		}

		input.files = event.dataTransfer.files;
		previewFile(input, type);
	};

	const previewFile = (input, type) => {
		const file = input.files[0];
		if (!file) return;

		const reader = new FileReader();
		reader.onload = (e) => {
			if (type === "image") {
				const previewImg = document.getElementById("previewImg");
				previewImg.src = e.target.result;
				previewImg.classList.remove("hidden");
			} else if (type === "video") {
				const previewVideo = document.getElementById("previewVideo");
				previewVideo.src = e.target.result;
				previewVideo.classList.remove("hidden");
			}
		};
		reader.readAsDataURL(file);
	};

	imgDropZone.addEventListener("click", () => imgInput.click());
	videoDropZone.addEventListener("click", () => videoInput.click());

	imgDropZone.addEventListener("dragover", handleDragOver);
	videoDropZone.addEventListener("dragover", handleDragOver);

	imgDropZone.addEventListener("dragleave", handleDragLeave);
	videoDropZone.addEventListener("dragleave", handleDragLeave);

	imgDropZone.addEventListener("drop", (event) => handleDrop(event, imgInput, "image"));
	videoDropZone.addEventListener("drop", (event) => handleDrop(event, videoInput, "video"));

	imgInput.addEventListener("change", () => previewFile(imgInput, "image"));
	videoInput.addEventListener("change", () => previewFile(videoInput, "video"));
});