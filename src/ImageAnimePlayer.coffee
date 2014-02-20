class ImageAnimePlayer
  el: null
  monitor: null
  prev_monitor: null
  next_monitor: null
  anime_backend: null

  constructor: (@el, image_urls, times) ->
    @monitor = document.createElement("img")
    @monitor.style.height = @monitor.style.width = "100%"
    @prev_monitor = @monitor.cloneNode(false)
    @next_monitor = @monitor.cloneNode(false)
    @prev_monitor.style.display = @next_monitor.style.display = "none"

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

  imageChange: (images, current) =>
    @monitor.src = images[current]
    @prev_monitor.src = images[current - 1] if current > 0
    @next_monitor.src = images[current + 1] if current < images.length - 1