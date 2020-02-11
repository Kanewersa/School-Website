$('#preview-modal').on('hidden.bs.modal', function () {
    $('#preview-body').empty();
});

$(document).ready(function() {
    var elementsArray = document.querySelectorAll(".loading");
    if(elementsArray.length > 0)
    {
        elementsArray.forEach(function(elem) {
            elem.addEventListener("click", function() {
                //Show loader
                $('#loader').modal({
                    show: true,
                    keyboard: false,
                    backdrop: 'static'
                });
            });
        });
    }
});