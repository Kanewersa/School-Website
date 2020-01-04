require("@rails/activestorage").start();
require("channels");
require('bootstrap/dist/js/bootstrap');
import {} from 'jquery'
import {} from 'jquery-ujs'
import {} from 'jquery-ui'
require("trix");
require("@rails/actiontext");
//Import custom scripts
require("carouselanimation");
require("navbaranimation");
window.baguetteBox = require('baguettebox.js');
import 'application/gallery-init'
//var TurboLinks = require("turbolinks");
//TurboLinks.start();
//Allow jQuery
window.jQuery = $;
window.$ = $;