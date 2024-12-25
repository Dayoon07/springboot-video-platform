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
