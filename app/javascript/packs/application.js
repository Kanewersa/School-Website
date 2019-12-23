require("@rails/activestorage").start();
require("channels");
require('bootstrap/dist/js/bootstrap');
import {} from 'jquery'
import {} from 'jquery-ujs'
import {} from 'jquery-ui'
require("trix");
require("@rails/actiontext");
//Import custom scripts
import {} from './carouselanimation'
import {} from './navbaranimation'
//var TurboLinks = require("turbolinks");
//TurboLinks.start();
//Allow jQuery
window.jQuery = $;
window.$ = $;