$(window).scroll(function () {
    var scroll = $(window).scrollTop();
    console.log(scroll);
    if (scroll > 127) {
        $(".navbar").addClass("scrolled");
        $(".btn").addClass("scrolled");
    } else {
        $(".navbar").removeClass("scrolled");
        $(".btn").removeClass("scrolled");
    }
});