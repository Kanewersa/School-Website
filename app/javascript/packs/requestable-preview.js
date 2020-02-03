require("@rails/activestorage").start();
require("channels");
require('bootstrap/dist/js/bootstrap');
require("jquery");
//Import custom scripts
window.baguetteBox = require('baguettebox.js');
require("application/navbar-animation");
import 'application/gallery-init'
import 'application/navbar-mobile.js'

//Allow jQuery
window.jQuery = $;
window.$ = $;

