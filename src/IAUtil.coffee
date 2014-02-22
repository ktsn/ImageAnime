class IAUtil
  @ajaxGetBlob: (url, success, error) ->
    xhr = new XMLHttpRequest()
    xhr.open("get", url)
    xhr.responseType = "arrayBuffer"

    xhr.onload = (e) ->
      blob = new Blob([xhr.response])
      success(blob)

    xhr.onerror = error

    xhr.send()

  @getURLWithParams: (url, params) ->
    return url if !params || Object.keys(params).length == 0

    params_array = Object.keys(params).map((key) -> key + "=" + params[key])
    url + "?" + params_array.join("&")