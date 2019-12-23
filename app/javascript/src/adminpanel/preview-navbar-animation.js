$('#preview-modal').scroll(function () {
    var scroll = $('#preview-modal').scrollTop();
    if (scroll > 157) {
        $(".navbar").addClass("scrolled");
        $(".btn").addClass("scrolled");
    } else {
        $(".navbar").removeClass("scrolled");
        $(".btn").removeClass("scrolled");
    }
});