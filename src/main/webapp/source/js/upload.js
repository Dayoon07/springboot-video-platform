function previewImage(event) {
    const file = event.target.files[0];
    const previewImg = document.getElementById("previewImg");

    if (file) {
        const reader = new FileReader();

        reader.onload = function(e) {
            previewImg.src = e.target.result;
            previewImg.classList.remove("hidden");
        };

        reader.readAsDataURL(file);
    } else {
        previewImg.src = "";
        previewImg.classList.add("hidden");
    }
}

const imgDropZone = document.getElementById('imgDropZone');
const videoDropZone = document.getElementById('videoDropZone');

[imgDropZone, videoDropZone].forEach(zone => {
    zone.addEventListener('dragover', function(event) {
        event.preventDefault();
        zone.classList.add('border-blue-500');
    });

    zone.addEventListener('dragleave', function(event) {
        event.preventDefault();
        zone.classList.remove('border-blue-500');
    });

    zone.addEventListener('drop', function(event) {
        event.preventDefault();
        zone.classList.remove('border-blue-500');

        const files = event.dataTransfer.files;

        if (zone === imgDropZone) {
            document.getElementById('imgPath').files = files;
            previewImage({ target: { files: files } });
        } else if (zone === videoDropZone) {
            document.getElementById('videoPath').files = files;
        }
    });

    zone.addEventListener('click', function() {
        if (zone === imgDropZone) {
            document.getElementById('imgPath').click();
        } else if (zone === videoDropZone) {
            document.getElementById('videoPath').click();
        }
    });
});