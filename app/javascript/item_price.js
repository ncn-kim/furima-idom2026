window.addEventListener("turbo:load", function () {
  const item_price = document.getElementById("item-price");

  if (!item_price) return;

  item_price.addEventListener("input", function () {
    const tax_price = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    let usage_fee = document.getElementById("system-usage-fee");

    const price = Number(item_price.value);
    let system_fee;
    if (price >= 10000) {
      system_fee = Math.floor(price * 0.05 + 100);
    } else if (price < 10000 && price >= 3000) {
      system_fee = Math.floor(price * 0.035);
    } else system_fee = 50;

    const selling_tax = Math.floor(price * 0.1);
    const earn_price = price - selling_tax - system_fee;

    usage_fee.textContent = system_fee;
    tax_price.textContent = selling_tax;
    profit.textContent = earn_price;
  });
});
