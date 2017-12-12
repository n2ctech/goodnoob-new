jQuery(document).ready(function($){

  $(document).on( 'mouseenter', '.labels-block label', function(e){

    var docWidth  = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
    var reqSpace  = 341;

    var $el       = $(e.target).parents('.labels-block');
    var $label    = $el.find('label');
    var $helper   = $el.find('.label__helper');

    if ( docWidth - ($label.offset().left + $label.outerWidth()) < reqSpace ){
      $helper.addClass('left');
    } else {
      $helper.removeClass('left');
    }

  });

  $(document).on('change', '.product__table input[type="radio"]', function(e){

    var $table = $(e.target).parents('.product__table');
    $table.find('tr.checked').removeClass('checked');
    $(e.target).parents('tr').addClass('checked');

  });

  window.onload = function() {

    var $shell  = $('.swiper-container.artwork');
    var prev    = $shell.find('.swiper-button-prev')[0];
    var next    = $shell.find('.swiper-button-next')[0];

    var mySwiper = new Swiper( $shell, {
      speed: 400,
      slidesPerView: 'auto',
      spaceBetween: 40,
      nextButton: next,
      prevButton: prev,
      centeredSlides: true,
      initialSlide: 1,
      threshold: 10
    });

    $shell.css('opacity', 1);
  }

}(jQuery));
