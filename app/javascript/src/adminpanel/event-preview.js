$('form').on('ajax:success', function(event, data, status, xhr) {
    $('#preview-modal').modal('show');
});
$('form').on('ajax:error', function(event, data, status, xhr) {
    location.reload();
});