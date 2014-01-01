window.get_params = ->
  params = {}
  window.location.search[1..-1].split("&").forEach (item) ->
    kvp = item.split("=")
    key = kvp[0]
    value = kvp[1]
    params[key] = value
  params

window.set_params = (params) ->
  kvps = []
  $.each params, (key, value) -> kvps.push [key, value].join("=") unless key is ""
  str = if kvps.length > 0 then "?" + kvps.join("&") else ""
  window.location.search = str

