$(function(){
  if ($(".pagination a[rel=next]").length) {
    $('.infinite').infiniteScroll({
      path: ".pagination a[rel=next]",
      append: ".content_infinite",
      history: false,
      scrollThreshold: true,
    });
  };
})