$(document).ready(function(){
  var date = new Date();
  $('.datepicker').datepicker({
    format: I18n.t('time.formats.datepicker_js'),
    orientation: 'bottom right',
    startDate: date
  });
});
