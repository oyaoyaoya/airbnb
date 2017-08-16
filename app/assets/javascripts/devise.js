$(function() {
  $('#modal-signup').modal('show');
  $('#modal-signin').modal('show');
  $('.btn-submit').on('click', function() {
    $(this).parent().submit();
  })
})
