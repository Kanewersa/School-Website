require("@rails/activestorage").start();
require("channels");
require('bootstrap/dist/js/bootstrap');
import 'jquery'
import 'jquery-ujs'
import {} from 'jquery-ui'
require("trix");
require("@rails/actiontext");
//Import custom scripts
require("carouselanimation");
require("navbaranimation");
window.baguetteBox = require('baguettebox.js');
import 'application/gallery-init'
import './trix-overrides'
import 'application/multi-carousel.js'
//var TurboLinks = require("turbolinks");
//TurboLinks.start();
//Allow jQuery
window.jQuery = $;
window.$ = $;

// Open all external links with new-tab class in a new window
addEventListener("click", function(event) {
    var el = event.target;

    if(el.classList.contains("new-tab")) {
        el.setAttribute("target", "_blank")
    }
}, true);
