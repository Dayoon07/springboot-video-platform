function previewImage(event) {
    const file = event.target.files[0];
    const preview = document.getElementById("profilePreview");
    const uploadText = document.getElementById("uploadText");
    let maxSize = 1024 * 1024;

    if (file) {
        if (file.size > maxSize) {
            alert("프로필 이미지 업로드 최대 용량은 1MB 입니다");
            event.target.value = '';
            return;
        }

        const reader = new FileReader();
        reader.onload = (e) => {
            preview.src = e.target.result;
            preview.classList.remove("hidden");
            uploadText.style.display = "none";
        };
        reader.readAsDataURL(file);
    }
}

$("#profileImgPath").on("change", previewImage);
