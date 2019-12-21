$('form').on('ajax:success', function(event, data, status, xhr) {
    console.log(data);
    $('#testmodal').modal('show');
    var source = $("#image-name-preview");
    if(source[0].files.length > 0)
    {
        var getImagePath = URL.createObjectURL(source[0].files[0]);
        $('#jumbo').css('background', 'url(' + getImagePath + ')');
    }
});
$('form').on('ajax:error', function(event, data, status, xhr) {
    //location.reload();
    console.log(data);
});