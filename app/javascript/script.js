$(document).on('turbolinks:load', function() {
  // tab-contents内のtabクラスを持つ要素で、そのidがtab1でないものを非表示。
  $('#tab-contents .tab[id != "tab1"]').hide();

  $('#tab-menu a').on('click', function(event) {
    // すべてのタブ内容を非表示にする
    $('.tab').hide();
    // すべてのタブタイトルを非表示にする
    $('.tab-title').hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    var target = $(this).attr("href");
    // クリックされたタブの内容を表示する
    $(target).show();
    // substrで4文字目から最後までの部分文字列を取得し、titleと連結したものを代入。
    var titleTarget = 'title' + target.substr(4);
    // クリックされたタブのタイトルを表示する
    $('#' + titleTarget).show().html($(this).html());
    event.preventDefault();
  });
});

// 非同期通信以外3秒フラッシュメッセージを非表示にする
$(document).ready(function() {
  setTimeout(function() {
    $('#flash').fadeOut('slow');
  }, 3000);
});

const swiper = new Swiper('.swiper', {
  //オプションの設定
  loop: true, //最後までスライドしたら最初の画像に戻る

  //ページネーション表示の設定
  pagination: {
    el: '.swiper-pagination', //ページネーションの要素
  },

  //ナビゲーションボタン（矢印）表示の設定
  navigation: {
    nextEl: '.swiper-button-next', //「次へボタン」要素の指定
    prevEl: '.swiper-button-prev', //「前へボタン」要素の指定
  }
});