//require("turbolinks").start();
require("@rails/activestorage").start();
require('jquery');
require('jquery-ujs');
require('jquery-ui');
require('rails_sortable');
//require('malihu-custom-scrollbar-plugin');
require('bootstrap/dist/js/bootstrap');
require("trix");
require("@rails/actiontext");

jQuery(function ($) {
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

    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
    });

    //toggle sidebar
    $("#toggle-sidebar").click(function () {
        $(".page-wrapper").toggleClass("toggled");
    });
    //Pin sidebar
    $("#pin-sidebar").click(function () {
        if ($(".page-wrapper").hasClass("pinned")) {
            // unpin sidebar when hovered
            $(".page-wrapper").removeClass("pinned");
            $("#sidebar").unbind( "hover");
        } else {
            $(".page-wrapper").addClass("pinned");
            $("#sidebar").hover(
                function () {
                    console.log("mouseenter");
                    $(".page-wrapper").addClass("sidebar-hovered");
                },
                function () {
                    console.log("mouseout");
                    $(".page-wrapper").removeClass("sidebar-hovered");
                }
            )

        }
    });

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
    });

    // switch between background images
    var bgs = "bg1 bg2 bg3 bg4";
    $('[data-bg]').click(function () {
        $('[data-bg]').removeClass("selected");
        $(this).addClass("selected");
        $('.page-wrapper').removeClass(bgs);
        $('.page-wrapper').addClass($(this).attr('data-bg'));
    });

    // toggle background image
    $("#toggle-bg").change(function (e) {
        e.preventDefault();
        $('.page-wrapper').toggleClass("sidebar-bg");
    });

    // toggle border radius
    $("#toggle-border-radius").change(function (e) {
        e.preventDefault();
        $('.page-wrapper').toggleClass("border-radius-on");
    });

    $("#getToken").click(function() {
        var btn = $(this);
        btn.prop('disabled', true);
        var role = $("#role-select").find("option:selected").text();
        if(role === "Administrator") role = "admin";
        else role = "user";
        var name = $("#name-select").val();
        // #TODO Request should be POST, not GET (for sake of security)
        $.get("/admin/users/token?role="+role+"&name="+name,function(data){
            var showToken = $("#show-token");
            var tokenAlert = $("#token-info");
            showToken.html(data.value);
            tokenAlert.removeClass('alert-hidden');
            setTimeout(function(){
                btn.prop('disabled', false);
            }, 2000);
        });
    });

    // Makes the name of the file appear on select
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

    //custom scroll bar is only used on desktop
    /*if (!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
        $(".sidebar-content").mCustomScrollbar({
            axis: "y",
            autoHideScrollbar: true,
            scrollInertia: 300
        });
        $(".sidebar-content").addClass("desktop");

    }*/
});