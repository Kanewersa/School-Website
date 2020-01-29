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
require("application/navbar-animation");
window.baguetteBox = require('baguettebox.js');
import 'application/gallery-init'
import './trix-overrides'
import 'application/multi-carousel.js'
//Allow jQuery
window.jQuery = $;
window.$ = $;

$(document).on('turbolinks:load', function (){ alert("turbolinks on load event works") });
// Open all external links with new-tab class in a new window
addEventListener("click", function(event) {
    var el = event.target;

    if(el.classList.contains("new-tab")) {
        el.setAttribute("target", "_blank")
    }
}, true);
