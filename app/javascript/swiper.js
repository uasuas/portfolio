const opt = {
  loop: true,
  slidesPerView: 'auto', // 1度に表示するスライドの数を自動設定
  centeredSlides: true, // 中央揃えにする
  spaceBetween: 50, // スライド間の余白を設定（必要に応じて変更）
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  }
}

// Swiperを実行(初期化)
$(document).on('turbolinks:load', function() {
    let swiper = new Swiper('.swiper',opt);
});