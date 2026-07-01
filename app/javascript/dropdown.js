document.addEventListener("turbo:load", () => {
  const dropdown = document.querySelector(".dropdown");

  if (dropdown) {
    dropdown.addEventListener("click", (e) => {
      dropdown.classList.toggle("open");
    });

    // ドロップダウン外をクリックしたら閉じる
    document.addEventListener("click", (e) => {
      if (!dropdown.contains(e.target)) {
        dropdown.classList.remove("open");
      }
    });
  }
});
