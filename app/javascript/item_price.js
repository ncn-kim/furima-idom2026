window.addEventListener("turbo:load", function () {
  const item_price = document.getElementById("item-price");

  if (!item_price) return;

  item_price.addEventListener("input", function () {
    const tax_price = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    const price = Number(item_price.value);
    const selling_tax = Math.floor(price * 0.1);
    const earn_price = price - selling_tax;

    tax_price.textContent = selling_tax;
    profit.textContent = earn_price;
  });
});
