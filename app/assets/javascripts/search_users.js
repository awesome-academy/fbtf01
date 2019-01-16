$(document).on('change', '#users_name_cont', function() {
  $.ajax({
    type: 'GET',
    url: '/users',
    data: {
      users: {name_cont: $(this).val()},
      commit: "Search"
    }
  });
});
