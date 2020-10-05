const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); //環境変数を読み込む
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form"); //idを元に要素を取得
        const tokenObj = `<input value = ${token} type="hidden" name='card_token'>`; //paramsの中にトークンを含める
        renderDom.insertAdjacentHTML("beforeend", tokenObj); //フォームの一番最後に要素を追加

        document.getElementById("number").removeAttribute("name");
        document.getElementById("cvc").removeAttribute("name");
        document.getElementById("exp_month").removeAttribute("name");
        document.getElementById("exp_year").removeAttribute("name");
      }
    });
  });
};