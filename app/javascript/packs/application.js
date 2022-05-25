// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "@fortawesome/fontawesome-free/js/all";

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'jquery'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//ヘッダーの高さ分だけコンテンツを下げる
$(function() {
  let height=$(".header").height();
  $(".wrap").css("padding-top", height + 56);//10pxだけ余裕をもたせる
});
