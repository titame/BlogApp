$(document).on('page:load', function() {
  ajaxLoad()
});
$(document).on('page:change', function() {
  $('#blog_user_id').change(function() {
    ajaxLoad()
  });
});

function ajaxLoad() {
  $.ajax({
    url: "/blogs/populate_blogs",
    data: {
      id: $("#blog_user_id option:selected").val()
    },
  });
}
