const likeVal = document.getElementById("likeCount").value;
const id = document.getElementById("likeCountButVideoId").value;

fetch(`http://localhost:9002/likeCount?param=${likeVal}&id=${id}`, {
	method: "post"})
	.then(res => res.json())
	.then((data) => {
		document.getElementById("watchTheVideoLikes").textContent = data;
	})
	.catch((err) => {
		console.log(err);
	});

document.getElementById("likeAddForm").addEventListener("submit", (e) => {
	fetch(`http://localhost:9002/likeCount?param=${likeVal}&id=${id}`, {
		method: "post"})
		.then(res => res.json())
		.then((data) => {
			document.getElementById("watchTheVideounLikes").textContent = data;
		})
		.catch((err) => {
			console.log(err);
		});
});