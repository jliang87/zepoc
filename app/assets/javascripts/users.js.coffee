# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#user_password_textfield").hide()

#user_username_textfield
$(document).delegate "#user_username_textfield", "blur", ->
  $(this).val "Letters/Numbers/Underscores" if $(this).val() is ""
  $(this).css "color", "#B2B2B2"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#user_username_textfield", "keydown", ->
  $(this).css "color", "#222222"
  $(this).val "" if $(this).val() is "Letters/Numbers/Underscores"

$(document).delegate "#user_username_textfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222" unless $(this).val() is "Letters/Numbers/Underscores"



#user_email_textfield
$(document).delegate "#user_email_textfield", "blur", ->
  $(this).val "A verification email will be sent to this inbox" if $(this).val() is ""
  $(this).css "color", "#B2B2B2"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#user_email_textfield", "keydown", ->
  $(this).css "color", "#222222"
  $(this).val "" if $(this).val() is "A verification email will be sent to this inbox"

$(document).delegate "#user_email_textfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222" unless $(this).val() is "A verification email will be sent to this inbox"



#user_passwordclear_textfield and user_password_textfield
$(document).delegate "#user_passwordclear_textfield", "blur", ->
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#user_passwordclear_textfield", "keydown", ->
  $(this).hide()
  $("#user_password_textfield").show()
  $("#user_password_textfield").focus()
  $("#user_password_textfield").addClass "textfieldtextcolorclick"

$(document).delegate "#user_passwordclear_textfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"

$(document).delegate "#user_password_textfield", "blur", ->
  $(this).css "color", "#B2B2B2"
  $(this).removeClass "textfieldtextcolorclick"
  $(this).hide() if $(this).val() is ""
  $("#user_passwordclear_textfield").show() if $(this).val() is ""

$(document).delegate "#user_password_textfield", "keydown", ->
  $(this).css "color", "#222222"

$(document).delegate "#user_password_textfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222"



#user_passwordconfirm_textfield
$(document).delegate "#user_passwordconfirm_textfield", "blur", ->
  $(this).css "color", "#B2B2B2"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#user_passwordconfirm_textfield", "mousedown", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222"