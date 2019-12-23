$('#testmodal').scroll(function () {
    var scroll = $('#testmodal').scrollTop();
    if (scroll > 157) {
        $(".navbar").addClass("scrolled");
        $(".btn").addClass("scrolled");
    } else {
        $(".navbar").removeClass("scrolled");
        $(".btn").removeClass("scrolled");
    }
});