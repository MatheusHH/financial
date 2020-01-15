# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

//= require jquery-ui/widgets/datepicker
//= require jquery-ui/i18n/datepicker-pt-BR

$(document).on 'turbolinks:load', ->
  $('#invoice_date_card').datepicker
    locale: 'pt-br'
    format: 'YYYY-MM-DD hh:mm'
  return