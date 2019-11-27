$(window).scroll(function () {
    var scroll = $(window).scrollTop();
    if (scroll > 118) {
        $(".navbar").addClass("scrolled");
        $(".btn").addClass("scrolled");
    } else {
        $(".navbar").removeClass("scrolled");
        $(".btn").removeClass("scrolled");
    }
});