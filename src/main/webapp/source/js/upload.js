// 이미지 파일을 선택했을 때 미리보기를 생성하는 함수
function previewImage(event) {
    const fileInput = event.target;
    const previewImg = document.getElementById('previewImg');

    if (fileInput.files && fileInput.files[0]) {
        const reader = new FileReader();

        // FileReader가 파일을 읽는 동안 load 이벤트가 발생합니다.
        reader.onload = function (e) {
            previewImg.src = e.target.result; // 이미지 데이터를 미리보기로 설정
            previewImg.classList.remove('hidden'); // 이미지 엘리먼트 표시
        };

        reader.readAsDataURL(fileInput.files[0]); // 파일을 DataURL 형식으로 읽습니다.
    } else {
        // 파일 선택이 취소되었거나, 유효하지 않은 경우 미리보기 숨김
        previewImg.src = '';
        previewImg.classList.add('hidden');
    }
}

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
