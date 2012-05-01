# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#sessiontextfield
$(document).delegate "#sessiontextfield", "blur", ->
  $(this).css "color", "#DDDDDD"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#sessiontextfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222" unless $(this).val() is "Correct format please"



#sessionpasswordfield
$(document).delegate "#sessionpasswordfield", "blur", ->
  $(this).css "color", "#DDDDDD"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#sessionpasswordfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222" 