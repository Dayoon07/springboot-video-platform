const sidebar = document.getElementById("sidebar");

function openSide() {
    sidebar.classList.remove("-translate-x-full");
    sidebar.classList.add("translate-x-0");
}

function closeSide() {
    sidebar.classList.remove("translate-x-0");
    sidebar.classList.add("-translate-x-full");
}
