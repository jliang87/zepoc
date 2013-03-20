# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.fn.selectRange = (start, end) ->
  @each ->
    if @setSelectionRange
      @focus()
      @setSelectionRange start, end
    else if @createTextRange
      range = @createTextRange()
      range.collapse true
      range.moveEnd "character", end
      range.moveStart "character", start
      range.select()


$ ->
  $("#user_password_textfield").hide()

  $('.remove_avatar').on 'click', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $('#avatar').fadeOut('slow')
    $(this).fadeOut('slow')
    event.preventDefault

  $.fn.doIcons = ->
    $(this).hover (->
      id = $(this).data('id')
      profileuser = $(this).data('profileuser')
      currentuser = $(this).data('currentuser')
      unless $('#edit_picture_form-'+id).is(":visible")
        $('#icons-'+id).stop(true, true).hide().css(visibility: "visible").fadeIn "slow" if profileuser is currentuser
        return this
    ), ->
      id = $(this).data('id')
      unless $('#edit_picture_form-'+id).is(":visible")
        $('#icons-'+id).fadeOut "fast", ->
          $(this).show().css visibility: "hidden"

  $('#avatar').hover (->
    profileuser = $(this).data('profileuser')
    currentuser = $(this).data('currentuser')
    $('#avatar-crop').stop(true, true).hide().css(visibility: "visible").fadeIn "slow" if profileuser is currentuser
    return this
  ), ->
    $('#avatar-crop').delay(1000).fadeOut "fast", ->
      $(this).show().css visibility: "hidden"

  $('form').on 'click', '.show_photo_fields', (event) ->
    $(this).next('div').slideToggle('slow')
    $(this).next('div').css 'overflow', 'visible'
    event.preventDefault







##change modal size
#$(document).on 'show', '#myModal', (event)->
#  $(this).show()
#  h = $('.modal-body').outerHeight() + $('.modal-header').outerHeight() + $('.modal-footer').outerHeight()
#  $(this).hide()
#  $(this).css "margin-top": -Math.round(h / 2)


$(document).on "focus", 'input[type=text]', (event)->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222"

$(document).on "blur", 'input[type=text]', (event)->
  $(this).removeClass "textfieldtextcolorclick"
  $(this).css "color", "#B2B2B2"

$(document).on "focus", 'input[type=password]', (event)->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222"

$(document).on "blur", 'input[type=password]', (event)->
  $(this).removeClass "textfieldtextcolorclick"
  $(this).css "color", "#B2B2B2"

$(document).on "focus", 'textarea', (event)->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222"

$(document).on "blur", 'textarea', (event)->
  $(this).removeClass "textfieldtextcolorclick"
  $(this).css "color", "#B2B2B2"




#user_username_textfield
$(document).delegate "#user_username_textfield", "blur", ->
  $(this).val "Letters/Numbers/Underscores" if $(this).val() is ""
  $(this).css "color", "#B2B2B2"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#user_username_textfield", "keydown", ->
  $(this).css "color", "#222222"
  $(this).val "" if $(this).val() is "Letters/Numbers/Underscores"

$(document).delegate "#user_username_textfield", "focus", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#B2B2B2" if $(this).val() is "Letters/Numbers/Underscores"

$(document).delegate "#user_username_textfield", "click", ->
  $(this).selectRange 0, 0 if $(this).val() is "Letters/Numbers/Underscores"



#user_email_textfield
$(document).delegate "#user_email_textfield", "blur", ->
  $(this).val "A verification email will be sent to this inbox" if $(this).val() is ""
  $(this).css "color", "#B2B2B2"
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#user_email_textfield", "keydown", ->
  $(this).css "color", "#222222"
  $(this).val "" if $(this).val() is "A verification email will be sent to this inbox"

$(document).delegate "#user_email_textfield", "focus", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#B2B2B2" if $(this).val() is "A verification email will be sent to this inbox"

$(document).delegate "#user_email_textfield", "click", ->
  $(this).selectRange 0, 0 if $(this).val() is "A verification email will be sent to this inbox"



#user_passwordclear_textfield and user_password_textfield
$(document).delegate "#user_passwordclear_textfield", "blur", ->
  $(this).removeClass "textfieldtextcolorclick"

$(document).delegate "#user_passwordclear_textfield", "keydown", ->
  $(this).hide()
  $("#user_password_textfield").show()
  $("#user_password_textfield").focus()
  $("#user_password_textfield").addClass "textfieldtextcolorclick"

$(document).delegate "#user_passwordclear_textfield", "focus", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#B2B2B2" if $(this).val() is "Minimum 6 characters"
  $(this).selectRange 0, 0

$(document).delegate "#user_passwordclear_textfield", "click", ->
  $(this).selectRange 0, 0

$(document).delegate "#user_password_textfield", "blur", ->
  $(this).css "color", "#B2B2B2"
  $(this).removeClass "textfieldtextcolorclick"
  $(this).hide() if $(this).val() is ""
  $("#user_passwordclear_textfield").show() if $(this).val() is ""

$(document).delegate "#user_password_textfield", "keydown", ->
  $(this).css "color", "#222222"

$(document).delegate "#user_password_textfield", "focus", ->
  $(this).addClass "textfieldtextcolorclick"
  $(this).css "color", "#222222"




(($) ->
  $(document).on 'click', '.edit_picture_form_file_field', (event) ->
    id = $(this).data 'id'
    $('#edit_photo_'+id).fileupload
      dataType: "script"
      dropZone: null
      pasteZone: null
      replaceFileInput: false
      add: (e, data) ->
        $('#picture-update-button-'+id).on 'click', (event) ->
          event.preventDefault()
          types = /(\.|\/)(jpe?g|png)$/i
          file = data.files[0]
          if types.test(file.type) || types.test(file.name)
            data.context = $(tmpl("template-upload", file))
            $('#edit_photo_'+id).append(data.context)
            data.submit()
            $('#picture-update-button-'+id).attr 'disabled', 'disabled'
          else
            alert("#{file.name} is not a jpeg or png image file!")
      progress: (e, data) ->
        if data.context
#          progress = parseInt(data.loaded / data.total * 100, 10)
          data.context.find('.spin').fadeIn()

  $ ->
    $('#photo_photo').click ->
      $('#new_photo').fileupload
        dataType: "script"
        dropZone: null
        pasteZone: null
        add: (e, data) ->
          types = /(\.|\/)(jpe?g|png)$/i
          file = data.files[0]
          if types.test(file.type) || types.test(file.name)
#            data.context = $(tmpl("template-upload", file))
#            $('#new_photo').append(data.context)
            data.submit()
          else
            alert("#{file.name} is not a jpeg or png image file!")
        progress: (e, data) ->
#          if data.context
##            progress = parseInt(data.loaded / data.total * 100, 10)
#            data.context.find('.spin').fadeIn()
            $('.fakefile').addClass('icon-spin')
#
        done: (e, data) ->

          $('.fakefile').fadeTo()
          $('.fakefile').removeClass('icon-spin')




) jQuery


