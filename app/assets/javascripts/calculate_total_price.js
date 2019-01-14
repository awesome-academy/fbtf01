$(document).on('change', '#booking_number_passengers', function() {
  var number_passengers = $(this).val();
  var price = $('#booking_price').val();
  $.ajax({
    type: 'POST',
    url: '/total_price',
    data: {
      number_passengers: number_passengers,
      price: price
    }
  });
});
