class ImageAnimePlayer
  el: null
  controller: null
  monitor: null
  prev_monitor: null
  next_monitor: null
  anime_backend: null

  constructor: (@el, image_urls, times) ->
    while @el.childNodes.length > 0
      @el.removeChild(@el.lastChild)
    @el.classList.add("ia-player")

    @monitor = document.createElement("img")
    @monitor.className = "ia-monitor"

    # for pre-loading images
    @prev_monitor = @monitor.cloneNode(false)
    @next_monitor = @monitor.cloneNode(false)

    @monitor.classList.add("ia-monitor-current")

    @el.appendChild(@prev_monitor)
    @el.appendChild(@monitor)
    @el.appendChild(@next_monitor)

    @anime_backend = new ImageAnime(image_urls, times)
    @anime_backend.onChangeFrame = @imageChange

    @controller = new IAPlayerController(this)

    @jumpFrame(0)
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

    @prev_monitor.src = images[current - 1] if current > 0

    if current < images.length - 1
      @next_monitor.src = images[current + 1]
    else
      @pause()