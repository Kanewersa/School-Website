var clicked = false;
$('[id="preview-button"]').click(function () {
    clicked = true;
});
$('#preview-modal').on('hidden.bs.modal', function () {
    clicked = false;
    $('#preview-body').empty();
});
$('form').on('ajax:success', function (event, data, status, xhr) {
    var body = $('#modal-response-body');
    var modal = $('#modal-response');
    var title = $('#modal-title');
    var icon = $('#modal-icon');
    if (clicked) {
        $('#preview-modal').modal('show');
    } else
    {
        var userRole = data.info.name;
        //Change response modal css for error
        if(modal.hasClass('modal-danger')){
            icon.removeClass("fas fa-fire");
            icon.addClass("far fa-thumbs-up");
            modal.removeClass('modal-danger');
            modal.addClass('modal-success');
            title.html("Sukces!");
        }
        //Change text based on user
        if(userRole === "admin") {
            body.empty();
            body.append("Twoje zmiany zostały zapisane.")
        } else {
            body.empty();
            body.append("Twoje zmiany zostały wysłane do administratora w celu ich zatwierdzenia.")
        }
        //Show modal
        modal.modal('show');
    }
});
$('form').on('ajax:error', function (event, data, status, xhr) {
    var body = $('#modal-response-body');
    var modal = $('#modal-response');
    var title = $('#modal-title');
    var icon = $('#modal-icon');
    //Change response modal css for error
    if(modal.hasClass('modal-success')){
        icon.removeClass('far fa-thumbs-up');
        icon.addClass('fas fa-fire');
        modal.removeClass('modal-success');
        modal.addClass('modal-danger');
        title.html("Wystąpił błąd");
    }
    //If response was "unprocessable entity"
    if (data.status === 422) {
                //Render bad inputs
        var errors = $.parseJSON(data.responseText).errors;
        //Append errors to modal
        body.empty();
        for (var error of errors) {
            body.append(error +'<br>');
        }
        //Show modal
        modal.modal('show');
    } else {
        body.empty();
        body.append('Wystąpił nieoczekiwany błąd ' + data.status);
    }
});