window.get_params = ->
  params = {}
  window.location.search[1..-1].split("&").forEach (item) ->
    kvp = item.split("=")
    key = kvp[0]
    value = kvp[1]
    params[key] = value
  console.log "Initial params:"
  console.log params
  params

window.set_params = (params) ->
  str = "?" + Object.keys(params).map((key) -> "#{key}=#{params[key]}").join("&")
  window.location.search = str

