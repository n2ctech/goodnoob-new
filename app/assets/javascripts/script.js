jQuery(document).ready(function($){

  $(document).on('mouseenter', '*[data-cat-id]', function(e){
    var catId = $(this).attr('data-cat-id');
    $('.active[data-cat-sub]').removeClass('active');
    $('*[data-cat-sub="' + catId + '"]').addClass('active');
  });

}(jQuery));
