function price (){
  const itemPrice  = document.getElementById("item-price");
  const addTaxPrice  = document.getElementById("add-tax-price");
  const proFit  = document.getElementById("profit");

  itemPrice.addEventListener('input', function(event) {
    const enteredValue = event.target.value;
    if (!isNaN(enteredValue) && enteredValue !== '') { // 入力が数字であることを確認
      const enteredAmount = Math.floor(parseFloat(enteredValue));
  
      // 手数料を計算（10%）
      const fee = enteredAmount * 0.1;
  
      // 手数料を表示
      addTaxPrice.innerHTML = `${Math.floor(fee)}円`;
  
      // 手数料を差し引いた金額を計算
      const finalAmount = enteredAmount - Math.floor(fee);
  
      // 結果を表示
      proFit.innerHTML = `${finalAmount}円`;
    } else if (enteredValue === '') { // 追加の条件
      addTaxPrice.innerHTML = '0円'; // 空欄にする
      proFit.innerHTML = '0円'; // 空欄にする
    } else {
      addTaxPrice.innerHTML = 'NaN';
      proFit.innerHTML = 'NaN';
    }
  });
};

window.addEventListener('input', price);