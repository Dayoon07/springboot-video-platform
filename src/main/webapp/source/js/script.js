const sidebar = document.getElementById("sidebar");
const sidebarDrop = document.getElementById("sidebar-drop");

function openSide() {
    sidebar.classList.remove("-translate-x-full");
    sidebar.classList.add("translate-x-0");
	sidebarDrop.classList.remove("hidden");
}

function closeSide() {
    sidebar.classList.remove("translate-x-0");
    sidebar.classList.add("-translate-x-full");
	sidebarDrop.classList.add("hidden");
}

const profile = document.getElementById("profile");
const profileDropdown = document.getElementById("profileDropdown");
const profileDropdownMenu = document.getElementById("profileDropdownMenu");
profile.addEventListener("click", () => {
	profileDropdownMenu.classList.remove("hidden");
	profileDropdown.classList.remove("hidden");
});
profileDropdownMenu.addEventListener("click", () => {
	profileDropdownMenu.classList.add("hidden");
	profileDropdown.classList.add("hidden");
});