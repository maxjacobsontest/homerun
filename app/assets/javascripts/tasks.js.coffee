# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  params = get_params()

  $("th").click ->
    sort_by = $(this).text().toLowerCase()
    if params.sort? and params.sort is sort_by
      params.sort = "-#{sort_by}"
    else
      params.sort = sort_by
    set_params(params)

  $("td.points, td.course, td.category").click ->
    filter_by_key = $(this).attr('class')
    filter_by_value = $(this).text()
    if params[filter_by_key] isnt filter_by_value
      params[filter_by_key] = filter_by_value
      set_params(params)

  $(".clear-param").click ->
    param_to_clear = $(this).data('clear')
    delete params[param_to_clear]
    set_params(params)

