function previewImage(event) {
    const file = event.target.files[0];
    const preview = document.getElementById("profilePreview");
    const uploadText = document.getElementById("uploadText");

    if (file) {
        const reader = new FileReader();
        reader.onload = (e) =>	 {
            preview.src = e.target.result;
            preview.classList.remove("hidden");
            uploadText.style.display = "none";
        };
        reader.readAsDataURL(file);
    }
}
$("#profileImgPath").on("change", function(){
	let maxSize = 1024 * 1024;
	let fileSize = this.files[0].size;
	if (fileSize > maxSize) {
		alert("프로필 이미지 업로드 최대 용량은 1MB 입니다");
		$(this).val('');
		return; 
	}
});