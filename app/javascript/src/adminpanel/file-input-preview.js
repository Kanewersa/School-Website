// Makes the name of the file appear on input
$(".custom-file-input").on("change", function () {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});

$("#browse").click(function() {
    $(this).parent().find('input[type=file]').click();
});

$("#image-name-preview").on("change", function(){
    $(this).parent().parent().find('.form-control').html($(this).val().split(/[\\\\|/]/).pop());
});