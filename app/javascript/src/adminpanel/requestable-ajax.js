var clicked = false;
$('[id="preview-button"]').click(function () {
    clicked = true;
});
$('#preview-modal').on('hidden.bs.modal', function () {
    clicked = false;
    $('#preview-body').empty();
});
$('form').on('ajax:success', function (event, data, status, xhr) {
    if (clicked) {
        $('#preview-modal').modal('show');
    }
});
$('form').on('ajax:error', function (event, data, status, xhr) {
});