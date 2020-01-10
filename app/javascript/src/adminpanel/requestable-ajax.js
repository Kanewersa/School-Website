var clicked = false;
$('[id="preview-button"]').click(function () {
    clicked = true;
});
$('#preview-modal').on('hidden.bs.modal', function () {
    clicked = false;
});
$('form').on('ajax:success', function (event, data, status, xhr) {
    var modal = $('#modal-response');
    //Change response modal css for success
    if(modal.hasClass('modal-danger')){
        modal.removeClass('modal-danger');
        modal.addClass('modal-success');
    }
    if (clicked) {
        $('#preview-modal').modal('show');
    }
});
$('form').on('ajax:error', function (event, data, status, xhr) {
    var body = $('#modal-response-body');
    var modal = $('#modal-response');
    //Change response modal css for error
    if(modal.hasClass('modal-success')){
        modal.removeClass('modal-success');
        modal.addClass('modal-danger');
    }
    //If response was "unprocessable entity"
    if (data.status === 422) {
                //Render bad inputs
        var errors = $.parseJSON(data.responseText).errors;
        //Append errors to modal
        body.empty();
        for (var error of errors) {
            body.append('<p>' + error +'</p>');
        }
        //Show modal
        modal.modal('show');
    } else {
        body.empty();
        body.append('Wystąpił nieoczekiwany błąd o statusie ' + data.status);
    }
});