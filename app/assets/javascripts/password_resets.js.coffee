# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).delegate "#textfield", "blur", ->
  $(this).val "Correct format please" if $(this).val() is ""
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#textfield", "keydown", ->
  $(this).val "" if $(this).val() is "Correct format please"

$(document).delegate "#textfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"