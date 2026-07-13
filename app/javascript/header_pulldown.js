const categoryButton = document.getElementById("category-nav-btn");
const brandButton = document.getElementById("brand-nav-btn");
const categoryList = document.getElementById("category-nav-list");
const brandList = document.getElementById("brand-nav-list");

if (categoryButton) {
  categoryButton.addEventListener("mouseover", function () {
    categoryList.style.display = "block";
  });
  categoryButton.addEventListener("mouseout", function () {
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
