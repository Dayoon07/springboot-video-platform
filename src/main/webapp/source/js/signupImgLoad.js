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