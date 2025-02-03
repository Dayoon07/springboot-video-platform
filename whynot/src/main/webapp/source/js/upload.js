function previewImage(event) {
    const fileInput = event.target;
    const previewImg = document.getElementById('previewImg');
    const maxSize = 1024 * 1024; // 1MB 제한

    if (fileInput.files && fileInput.files[0]) {
        let fileSize = fileInput.files[0].size;

        // 파일 크기 체크
        if (fileSize > maxSize) {
            alert("썸네일 이미지 업로드 최대 용량은 1MB 입니다");
            fileInput.value = ''; // 파일 선택 초기화
            previewImg.src = '';
            previewImg.classList.add('hidden');
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            previewImg.src = e.target.result; // 미리보기 설정
            previewImg.classList.remove('hidden'); // 이미지 표시
        };
        reader.readAsDataURL(fileInput.files[0]); // 파일을 읽어서 미리보기 설정
    } else {
        previewImg.src = '';
        previewImg.classList.add('hidden');
    }
}

// 파일 선택 시 실행
document.getElementById("imgPath").addEventListener("change", previewImage);

// 드래그 앤 드롭 영역 처리
const imgDropZone = document.getElementById('imgDropZone');
const imgInput = document.getElementById('imgPath');

imgDropZone.addEventListener('click', () => imgInput.click());

imgDropZone.addEventListener('dragover', (e) => {
	e.preventDefault();
	imgDropZone.classList.add('border-blue-400');
});

imgDropZone.addEventListener('dragleave', () => {
	imgDropZone.classList.remove('border-blue-400');
});

imgDropZone.addEventListener('drop', (e) => {
	e.preventDefault();
	imgDropZone.classList.remove('border-blue-400');

	if (e.dataTransfer.files && e.dataTransfer.files[0]) {
		imgInput.files = e.dataTransfer.files; // 드래그한 파일을 input에 설정
		const event = new Event('change');
		imgInput.dispatchEvent(event); // change 이벤트 트리거
	}
});

$("#videoPath").on("change", function() {
	let maxSize = 100 * 1024 * 1024;
	let fileSize = this.files[0].size;
	if (fileSize > maxSize) {
		alert("업로드 최대 용량은 100MB 입니다");
		$(this).val('');
		return;
	}
});