jQuery(document).ready( function($){

  $(document).on('click', '*[data-tab-id]', function(e){

    e.preventDefault();

    var tabId = $(e.target).attr('data-tab-id');

    $('a.current[data-tab-id]').removeClass('current');
    $('div.current[data-tab]').removeClass('current');

    $(e.target).addClass('current');
    $('*[data-tab="' + tabId + '"]').addClass('current');

  });

}(jQuery));
