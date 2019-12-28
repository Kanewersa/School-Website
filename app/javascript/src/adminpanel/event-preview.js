var clicked = false;
$('#preview-button').click(function(){
    clicked = true;
});
$('#preview-modal').on('hidden.bs.modal', function () {
    clicked = false;
});
$('form').on('ajax:success', function(event, data, status, xhr) {
    if(clicked)
    {
        $('#preview-modal').modal('show');
    }
});
$('form').on('ajax:error', function(event, data, status, xhr) {
    console.log("There was an error running ajax request, here is the 'data':");
    console.log(data);
    // location.reload();
});