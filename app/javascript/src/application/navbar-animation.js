var scroll;
$(document).on('turbolinks:load', function() {
    scroll = $(window).scrollTop();
    setNavbar(scroll);
});
$(window).scroll(function () {
    scroll = $(window).scrollTop();
    setNavbar(scroll);
});

function setNavbar(scroll)
{
    if (scroll > 127) {
        $(".navbar").addClass("scrolled");
        $(".btn").addClass("scrolled");
    } else {
        $(".navbar").removeClass("scrolled");
        $(".btn").removeClass("scrolled");
    }
}