require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap/dist/js/bootstrap'
import '../stylesheets/application'
import './map'
import './gallery'

var jQuery = require("jquery");
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

const images = require.context('../images', true)
