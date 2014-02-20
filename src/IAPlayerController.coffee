class IAPlayerController
  el: null
  player: null
  play_toggle_btn: null
  time_slider: null
  is_play: false

  constructor: (@player) ->
    @el = document.createElement("div")
    @el.className = "ia-controller"

    @play_toggle_btn = @createPlayToggleBtn()

    @el.appendChild(@play_toggle_btn)

    @player.el.appendChild(@el)

  setIsPlay: (is_play) ->
    @is_play = is_play
    if is_play
      @play_toggle_btn.classList.remove("ia-play")
      @play_toggle_btn.classList.add("ia-pause")
    else
      @play_toggle_btn.classList.remove("ia-pause")
      @play_toggle_btn.classList.add("ia-play")

  createPlayToggleBtn: () ->
    btn = document.createElement("button")
    btn.className = "ia-play-btn ia-pause"

    btn.onclick = () =>
      if @is_play
        @player.pause()
      else
        @player.play()
    btn