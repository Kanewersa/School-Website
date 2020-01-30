function toggleNav() {
    var sidebar = document.getElementById("mySidebar");
    (sidebar.style.width === "0") ? sidebar.style.width = "64%" : sidebar.style.width = "0"
}

function openNav() {
    document.getElementById("mySidebar").style.width = "64%";
    console.log("opening navbar...");
}

function closeNav() {
    document.getElementById("mySidebar").style.width = "0";
    console.log("closing navbar...");
}

$(document).on("turbolinks:load", function () {
    console.log("loaded c:");

    var dim = $("#dim-cover");

    function toggleCover() {
        dim.toggleClass("coverall");
    }
    var toggler = document.getElementById("toggler");
    var closer = document.getElementById("sidebar-close");
    toggler.addEventListener("click", toggleCover);
    closer.addEventListener("click", toggleCover);
    toggler.addEventListener("click", openNav);
    closer.addEventListener("click", closeNav);

    dim.click(function () {
        toggleCover();
        toggleNav();
    });
});

$(document).on("click", ".sidebar-dropdown > a", function (e) {
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