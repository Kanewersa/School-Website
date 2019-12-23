$('form').on('ajax:success', function(event, data, status, xhr) {
    $('#preview-modal').modal('show');
    var source = $("#image-name-preview");
    if(source[0].files.length > 0)
    {
        var getImagePath = URL.createObjectURL(source[0].files[0]);
        $('#jumbo').css({"background": 'url(' + getImagePath + ') no-repeat', "background-position-y": '45%',
                         "background-position-x": "center", "background-size": "cover"});
    }
});
$('form').on('ajax:error', function(event, data, status, xhr) {
    location.reload();
});