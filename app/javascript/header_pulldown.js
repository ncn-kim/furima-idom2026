document.addEventListener("turbo:load", function () {
  const categoryButton = document.getElementById("category-nav");
  const brandButton = document.getElementById("brand-nav");
  const categoryList = document.getElementById("category-nav-list");
  const brandList = document.getElementById("brand-nav-list");

  if (categoryButton) {
    categoryButton.addEventListener("mouseenter", function () {
      categoryList.style.display = "block";
    });
    categoryButton.addEventListener("mouseleave", function () {
      categoryList.style.display = "none";
    });
  }

  if (brandButton) {
    brandButton.addEventListener("mouseover", function () {
      brandList.style.display = "block";
    });
    brandButton.addEventListener("mouseout", function () {
      brandList.style.display = "none";
    });
  }
});
