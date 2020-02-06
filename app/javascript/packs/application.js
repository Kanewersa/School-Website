require("@rails/activestorage").start();
require("channels");
require('bootstrap/dist/js/bootstrap');
require("jquery");
require("jquery-ujs");
require("jquery-ui");
require("trix");
require("@rails/actiontext");
require("turbolinks").start();
//Import custom scripts
require("application/carousel-animation");
window.baguetteBox = require('baguettebox.js');
import './trix-overrides'
require("application/navbar-animation");
import 'application/gallery-init'
import 'application/multi-carousel.js'
import 'application/navbar-mobile.js'

//= require jquery.infinite-pages
//Allow jQuery
window.jQuery = $;
window.$ = $;

// Open all external links with new-tab class in a new window
$(document).on("turbolinks:load", function() {
    addEventListener("click", function(event) {
        var el = event.target;

        if(el.classList.contains("new-tab")) {
            el.setAttribute("target", "_blank")
        }
    }, true);

    // $('#paginate').infinitePages({
    //     debug: true,
    //     buffer: 100,
    //     context: '.pane',
    //     loading: function() {
    //         console.log("Loading...");
    //     },
    //     success: function() {
    //         console.log("loaded more!");
    //     },
    //     error: function() {
    //         console.log("Failed to load :(");
    //     }
    // });
    window.loadingMore = false;
    var target = document.getElementById("load-more");
    function loadMoreOnScroll() {
        var link = document.getElementById("load-more-link");
        if(link)
        {
            //If user scrolled to the target element
            if(window.scrollY > (target.offsetTop + target.offsetHeight - window.innerHeight))
            {
                if(!window.loadingMore)
                {
                    link.click();
                    window.loadingMore = true;
                }
            }
        }
    }
    if(target)
    {
        addEventListener("scroll", loadMoreOnScroll);
    } else
    {
        removeEventListener("scroll", loadMoreOnScroll);
    }
});

