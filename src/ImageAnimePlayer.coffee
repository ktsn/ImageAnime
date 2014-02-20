class ImageAnimePlayer
  el: null
  monitor: null
  prev_monitor: null
  next_monitor: null
  anime_backend: null

  constructor: (@el, image_urls, times) ->
    @el.className = "ia-player"

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

    @jumpFrame(0)

  play: () ->
    @anime_backend.play()

  pause: () ->
    @anime_backend.pause()

  stop: () ->
    @anime_backend.stop()

  jumpFrame: (index) ->
    @anime_backend.jumpFrame(index)

  ###
   Callback functions from backend
  ===============================================
  ###

  imageChange: (images, current) =>
    @monitor.src = images[current]
    @prev_monitor.src = images[current - 1] if current > 0
    @next_monitor.src = images[current + 1] if current < images.length - 1