const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); //環境変数を読み込む
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
  });
};