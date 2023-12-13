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

document.addEventListener('turbolinks:load', () => {

  const sidebar = document.querySelector('.sidebar');

  // aタグは処理をキャンセル
  sidebar.addEventListener('click', function(event) {
    if (event.target.tagName === 'A' ) {
      return;
    }
    if (!sidebar.classList.contains('active')) {
      sidebar.classList.add('active');
    }
    event.stopPropagation();
  });

  document.addEventListener('click', function(event) {
    if (!sidebar.contains(event.target)) {
      sidebar.classList.remove('active');
    }
  });
});