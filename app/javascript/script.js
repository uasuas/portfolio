$(document).on('turbolinks:load', function() {
  $('#tab-contents .tab[id != "tab1"]').hide();

  $('#tab-menu a').on('click', function(event) {
    $('.tab').hide(); // すべてのタブ内容を非表示にする
    $('.tab-title').hide(); // すべてのタブタイトルを非表示にする
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    var target = $(this).attr("href");
    $(target).show(); // クリックされたタブの内容を表示する
    var titleTarget = 'title' + target.substr(4);
    $('#' + titleTarget).show().html($(this).html()); // クリックされたタブのタイトルを表示する
    event.preventDefault();
  });
});

 // 非同期通信以外3秒フラッシュメッセージを非表示にする
$(document).ready(function() {
  setTimeout(function() {
    $('#flash').fadeOut('slow');
  }, 3000);
});