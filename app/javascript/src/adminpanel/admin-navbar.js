// Dropdown menu
$(document).on("click", ".sidebar-dropdown > a", function(e){
    e.preventDefault();
    e.stopPropagation();
    $(".sidebar-submenu").slideUp(200);
    if ($(this).parent().hasClass("active")) {
        $(".sidebar-dropdown").removeClass("active");
        $(this).parent().removeClass("active");
    } else {
        $(".sidebar-dropdown").removeClass("active");
        $(this).next(".sidebar-submenu").slideDown(200);
        $(this).parent().addClass("active");
    }
    return false;
});

//toggle sidebar
$("#toggle-sidebar").click(function () {
    $(".page-wrapper").toggleClass("toggled");
});

//Pin sidebar
$("#pin-sidebar").click(function () {
    if ($(".page-wrapper").hasClass("pinned")) {
        localStorage['pinnedSidebar'] = 'false';
        // unpin sidebar when hovered
        $(".page-wrapper").removeClass("pinned");
        $("#sidebar").unbind( "hover");
    } else {
        localStorage['pinnedSidebar'] = 'true';
        $(".page-wrapper").addClass("pinned");
        $("#sidebar").hover(
            function () {
                $(".page-wrapper").addClass("sidebar-hovered");
            },
            function () {
                $(".page-wrapper").removeClass("sidebar-hovered");
            }
        )
    }
});

var pinned = localStorage['pinnedSidebar'] || 'false';
if(pinned === "true")
{
    if (!$(".page-wrapper").hasClass("pinned"))
    {
        $(".page-wrapper").addClass("pinned");
        $("#sidebar").hover(
            function () {
                $(".page-wrapper").addClass("sidebar-hovered");
            },
            function () {
                $(".page-wrapper").removeClass("sidebar-hovered");
            }
        )
    }
}

//toggle sidebar overlay
$("#overlay").click(function () {
    $(".page-wrapper").toggleClass("toggled");
});

//switch between themes
var themes = "default-theme legacy-theme chiller-theme ice-theme cool-theme light-theme";
$('[data-theme]').click(function () {
    $('[data-theme]').removeClass("selected");
    $(this).addClass("selected");
    $('.page-wrapper').removeClass(themes);
    $('.page-wrapper').addClass($(this).attr('data-theme'));
    localStorage['dataTheme'] = $(this).attr('data-theme');
});
$('.page-wrapper').removeClass(themes);
$('.page-wrapper').addClass(localStorage['dataTheme'] || "default-theme");
// switch between background images
var bgs = "bg1 bg2 bg3 bg4";
$('[data-bg]').click(function () {
    $('[data-bg]').removeClass("selected");
    $(this).addClass("selected");
    $('.page-wrapper').removeClass(bgs);
    $('.page-wrapper').addClass($(this).attr('data-bg'));
    localStorage['dataBg'] = $(this).attr('data-bg');
});
$('.page-wrapper').removeClass(bgs);
$('.page-wrapper').addClass(localStorage['dataBg'] || "bg1");

// toggle background image
$("#toggle-bg").change(function (e) {
    e.preventDefault();
    $('.page-wrapper').toggleClass("sidebar-bg");
    if($('.page-wrapper').hasClass("sidebar-bg"))
        localStorage['toggleBg'] = "true";
    else
        localStorage['toggleBg'] = "false";
    console.log(localStorage['toggleBg']);
});
if(localStorage['toggleBg'] === "false")
    $('.page-wrapper').toggleClass("sidebar-bg");



// toggle border radius
$("#toggle-border-radius").change(function (e) {
    e.preventDefault();
    $('.page-wrapper').toggleClass("border-radius-on");
});