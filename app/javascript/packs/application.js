// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Raty導入時にBootstrapのレイアウト崩れ防止の為記述。
import jQuery from 'jquery';
window.jQuery = jQuery;
window.$ = jQuery;

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "script.js"
import "jquery";
import "popper.js";
// import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()
// Raty設定用記述。
window.$ = window.jQuery = require('jquery');

import Raty from "raty.js"
window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}