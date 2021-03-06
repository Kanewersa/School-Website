require("@rails/activestorage").start();
require('bootstrap/dist/js/bootstrap');
import {} from 'jquery'
import {} from 'jquery-ujs'
import {} from 'jquery-ui'
require('jquery.remotipart');
require('jquery.iframe-transport');
require("trix");
require("@rails/actiontext");
//Import custom scripts
import {} from 'adminpanel/image-uploader'
import {} from 'adminpanel/admin-navbar';
import {} from 'adminpanel/file-input-preview';
import {} from 'adminpanel/get-token-ajax';
import {} from 'adminpanel/tooltip';
import {} from 'adminpanel/events-datepicker';
import {} from 'adminpanel/address-translate';
import {} from 'adminpanel/requestable-ajax';
import {} from 'adminpanel/embedded-modals';
import {} from 'adminpanel/sortable-tabs';
import {} from 'adminpanel/preview-navbar-animation'
import './trix-overrides'

//= require jquery.infinite-pages
//Allow jQuery
window.jQuery = $;
window.$ = $;