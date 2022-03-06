document.addEventListener("turbo:load", function() {
  document.getElementById('nav-toggle').onclick = function() {
    document.getElementById("nav-content").classList.toggle("hidden");
  };
});
