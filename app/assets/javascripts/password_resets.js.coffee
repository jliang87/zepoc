# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).delegate "#passwordresettextfield", "blur", ->
  $(this).css "color", "#B2B2B2"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#passwordresettextfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222" 