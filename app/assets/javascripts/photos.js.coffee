# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    event.preventDefault()
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('div').hide()


  $('form').on 'click', '.add_fields', (event) ->
    event.preventDefault()
    $(this).prev('.icon-camera-retro').hide()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    if $('.icon-picture').length <= 1
      $(this).before "<i class='icon-camera-retro icon-black' style='margin-right: 4px'></i>"

