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
//var TurboLinks = require("turbolinks");
//TurboLinks.start();
//Allow jQuery
window.jQuery = $;
window.$ = $;

$(document).ready(function () {
    //TODO Can't add target="_blank" to link_to inside trix body
    $(".pdf").click(function(event) {
        event.preventDefault();
        window.open($(this).attr('href'));
    });
});
