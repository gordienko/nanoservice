require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

import "controllers"
import bootstrap from 'bootstrap/dist/js/bootstrap'
require("css/application.scss")
import "@fortawesome/fontawesome-free/js/all"

document.addEventListener("turbolinks:load", function() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })
})

if (window.NodeList && !NodeList.prototype.forEach) {
    NodeList.prototype.forEach = Array.prototype.forEach;
}

require("trix")
require("@rails/actiontext")
