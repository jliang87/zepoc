$(document).delegate "#textfield", "blur", ->
  $(this).val "Correct format please" if $(this).val() is ""
  $(this).css "color", "#DDDDDD"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#textfield", "keydown", ->
  $(this).css "color", "#222222"
  $(this).val "" if $(this).val() is "Correct format please"

$(document).delegate "#textfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#333333" unless $(this).val() is "Correct format please"