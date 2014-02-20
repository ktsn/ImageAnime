class IAPlayerController
  el: null
  player: null

  constructor: (@player) ->
    @el = document.createElement("div")
    @el.className = "ia-controller"

    @player.el.appendChild(@el)
