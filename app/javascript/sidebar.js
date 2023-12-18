document.addEventListener('turbolinks:load', () => {
  // sidebarのクラスを持つ要素を取得しsidebarに格納。
  const sidebar = document.querySelector('.sidebar');
  const open = document.querySelector('.open');
  sidebar.addEventListener('click', function(event) {
    // サイドバーの表示切り替え処理をスキップして、通常のリンクの挙動を維持する。
    if (event.target.tagName === 'A' ) {
      return;
    }
    if (!sidebar.classList.contains('active')) {
    // activeクラスを追加しサイドバーを表示。
      sidebar.classList.add('active');
      // マークを非表示。
      open.style.display = 'none';
    }
    event.stopPropagation();
  });

  document.addEventListener('click', function(event) {
    // sidebarの要素内のclickであればfalse、要素外ならクラスの削除とopenの表示。
    if (!sidebar.contains(event.target)) {
      sidebar.classList.remove('active');
      open.style.display = 'block';
    }
  });
});