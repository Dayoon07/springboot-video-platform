const likeVal = document.getElementById("likeCount").value;
const id = document.getElementById("likeCountButVideoId").value;

document.addEventListener("DOMContentLoaded", () => {
	"use strict";
	
	writeLikeValue();
	setTimeout(writeLikeValue, 1500);
});

function writeLikeValue() {
	fetch(`http://localhost:9002/likeCount?param=${likeVal}&id=${id}`, {
			method: "post"})
			.then(res => res.json())
			.then((data) => {
				if (document.getElementById("watchTheVideoLikeVal") != null) {
					document.getElementById("watchTheVideoLikeVal").textContent = data;
				} else {
					console.log(data);	
				}
			})
			.catch((err) => {
				console.log(err);
			});
}

function addLike() {	
	fetch(`http://localhost:9002/likeCount?param=${likeVal}&id=${id}`, {method: "post"})
		.then(res => res.json())
		.then((data) => {
			document.getElementById("watchTheVideoLikeVal").textContent = data;
			console.log(data);
		})
		.catch((err) => {
			console.log(err);
		});
}
