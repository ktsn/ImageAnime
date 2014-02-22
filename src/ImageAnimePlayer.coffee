class ImageAnimePlayer
  el: null
  controller: null
  monitor: null
  anime_backend: null

  constructor: (@el, image_urls, times) ->
    while @el.childNodes.length > 0
      @el.removeChild(@el.lastChild)
    @el.classList.add("ia-player")

    @monitor = document.createElement("img")
    @monitor.src = "#"
    @monitor.className = "ia-monitor"
    @el.appendChild(@monitor)

    @anime_backend = new ImageAnime(image_urls, times)
    @anime_backend.onChangeFrame = @imageChange

    @controller = new IAPlayerController(this)

    @play()

  play: () ->
    @jumpFrame(0) if @anime_backend.index >= @anime_backend.term_index
    @anime_backend.play()
    @controller.setIsPlay(true)

  pause: () ->
    @anime_backend.pause()
    @controller.setIsPlay(false)

  stop: () ->
    @anime_backend.stop()
    @controller.setIsPlay(false)

  jumpFrame: (index) ->
    @anime_backend.jumpFrame(index)

  fitMonitor: () =>
    v_scale = @el.offsetHeight / @monitor.height
    h_scale = @el.offsetWidth / @monitor.width
    if v_scale < h_scale
      @monitor.classList.add("ia-monitor-v-fit")
      @monitor.classList.remove("ia-monitor-h-fit")
    else
      @monitor.classList.add("ia-monitor-h-fit")
      @monitor.classList.remove("ia-monitor-v-fit")

    ###
     Callback functions from backend
    ===============================================
    ###

  imageChange: (images, current) =>
    @monitor.src = images[current]
    @monitor.onload = @fitMonitor

    @pause() if current >= @anime_backend.term_index
