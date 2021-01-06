require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

var jQuery = require("jquery");
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

import 'bootstrap/dist/js/bootstrap'
import '../stylesheets/application'
import './map'
import './gallery'

const images = require.context('../images', true)
