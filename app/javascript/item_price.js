window.addEventListener("load", function () {
  const item_price = document.getElementById("item-price");

  item_price.addEventListener("input", function () {
    const tax_price = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    // 入力された販売価格を値として受け取る
    const price = Number(item_price.value);
    // 販売金額の10％カツ小数点切り捨ての為、Math.floor
    const selling_tax = Math.floor(price * 0.1);
    const earn_price = price - selling_tax;

    tax_price.textContent = selling_tax;
    profit.textContent = earn_price;
  });
});
