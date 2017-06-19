function set_rate(user, product, point){

  $.ajax({
    url: '/ajax_set_product_rating',
    method: "POST",
    data: {
      user_id: user,
      product_id: product,
      rating: point
    }
  }).done(function(data) {
    // change remark
    for (i = 1; i <= 5; i++)
    {
      if (i <= point)
      {
        $('#star-'+i+'-'+product).addClass('rating-point');
        $('#star-'+i+'-'+product).removeClass('rating-point-empty');
      }
      else
      {
        $('#star-'+i+'-'+product).removeClass('rating-point');
        $('#star-'+i+'-'+product).addClass('rating-point-empty');
      }
    }
  }).fail(function(jqXHR, textStatus){
    alert(jqXHR.error)
  });

  return false;
}