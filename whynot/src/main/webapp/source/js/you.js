function createBio() {
	const m = document.createElement("div");
	m.id = "realModalCreateBioFuckShit";
	m.classList.add("fixed", "w-full", "h-full", "top-0", "left-0", "bg-white", "opacity-70", "text-right");
	m.innerHTML = "<h1 class='text-4xl m-4 cursor-pointer text-black' onclick='closeModal()'>&times;</h1>";

	const d = document.createElement("div");
	d.id = "dadsasdasdasdasd";
	d.classList.add("absolute", "top-20", "top-0", "w-full", "px-4", "py-8", "bg-white", "text-black", "border-t", "border-b", "shadow");
	d.innerHTML = `
		<form action="${location.origin}/createBio" method="post">
			<textarea oninput="autoResize(this)" id="myBio" name="bio" rows="3" class="w-full py-2 border focus:ring-2 
	        	focus:ring-black focus:outline-none resize-none overflow-y-hidden qwertyuio" required></textarea>
	        <div class="text-right">
	        	<button type="button" class="px-6 py-2 bg-black text-white rounded hover:opacity-70" onclick="cbl()">만들기</button>
	        </div>
		</form>
    `;

	document.querySelector("body").append(m);
	document.querySelector("body").append(d);
}

function closeModal() {
	document.getElementById("realModalCreateBioFuckShit").style.display = "none";
	document.getElementById("realModalCreateBioFuckShit").id = "";

	document.getElementById("dadsasdasdasdasd").style.display = "none";
	document.getElementById("dadsasdasdasdasd").id = "";
}

function autoResize(textarea) {
	textarea.style.height = "auto";
	textarea.style.height = textarea.scrollHeight + "px";
}

async function cbl() {
	const res = await fetch(`${location.origin}/createBio`, {
		method: "post",
		headers: { 'Content-Type': 'application/json' },
		body: JSON.stringify({ bio: document.querySelector("textarea[oninput='autoResize(this)']").value })
	});
	const data = await res.text();
	console.log(data);
	document.getElementById("myBio").textContent = data;
}

async function EditBio(pk) {
	const res = await fetch(`${location.origin}/myInfo?creatorId=${pk}`, {
		method: "post"
	});
	const abcdedf = await res.json();

	const m = document.createElement("div");
	m.id = "realModalCreateBioFuckShit";
	m.classList.add("fixed", "w-full", "h-full", "top-0", "left-0", "bg-white", "opacity-70", "text-right");
	m.innerHTML = "<h1 class='text-4xl m-4 cursor-pointer text-black' onclick='closeModal()'>&times;</h1>";

	const d = document.createElement("div");
	d.id = "dadsasdasdasdasd";
	d.classList.add("absolute", "top-20", "top-0", "w-full", "px-4", "py-8", "bg-white", "text-black", "border-t", "border-b", "shadow");
	d.innerHTML = `
			<form action="${location.origin}/EditBio" method="post">
				<textarea oninput="autoResize(this)" id="myBio" name="bio" rows="3" class="w-full py-2 border focus:ring-2 
		        	focus:ring-black focus:outline-none resize-none overflow-y-hidden qwertyuio" required>${abcdedf.bio}</textarea>
		        <div class="text-right">
		        	<button type="submit" class="px-6 py-2 bg-black text-white rounded hover:opacity-70">만들기</button>
		        </div>
			</form>        
	    `;

	document.querySelector("body").append(m);
	document.querySelector("body").append(d);
}

document.addEventListener("keydown", (e) => {
	if (e.key === "Escape") closeModal();
})