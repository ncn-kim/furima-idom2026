window.addEventListener("turbo:load", function () {
  const itemDetail = document.getElementById("item-detail");

  if (!itemDetail) return;

  const itemId = itemDetail.dataset.itemId;
  const token = document.querySelector('meta[name="csrf-token"]').content;

  fetch(`/items/${itemId}/increment_view_count`, {
    method: "POST",
    headers: {
      "X-CSRF-Token": token,
    },
  });
});
