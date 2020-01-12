# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#closing_date').datepicker
    locale: 'pt-br'
    format: 'YYYY-MM-DD hh:mm'
  return

$(document).on 'turbolinks:load', ->
  $('#invoice_date').datepicker
    locale: 'pt-br'
    format: 'YYYY-MM-DD hh:mm'
  return