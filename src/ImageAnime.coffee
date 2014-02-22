ImageAnimeState =
  stopped: 0
  pausing: 1
  loadingAndPausing: 2
  playing: 3

class ImageAnime
  index: 0
  frames: null
  times: null
  term_index: -1
  state: ImageAnimeState.stopped
  timer: null

  constructor: (@frame_urls, @times) ->
    @frames = new Array(@frame_urls.length)
    @term_index = @frame_urls.length - 1
    @loadFrame(@index)

  play: () ->
    @state = ImageAnimeState.playing
    @setTransitionTimer(@index + 1)
    @onStartAnime()

  pause: () ->
    clearTimeout @timer if @timer != null
    @state = ImageAnimeState.pausing

  stop: () ->
    clearTimeout @timer if @timer != null
    @state = ImageAnimeState.stopped
    @jumpFrame 0
    @onStopAnime()

  loadFrame: (index) ->
    if @frame_urls[index]?
      IAUtil.ajaxGetBlob @frame_urls[index], (frame) =>
        @onLoadFrame(frame, index)

  jumpFrame: (index) ->
    @index = index
    @onChangeFrame(@frames, index)
    if @state >= ImageAnimeState.loadingAndPausing
      @state = ImageAnimeState.playing
      @setTransitionTimer(index + 1)

  setTransitionTimer: (next_index) ->
    clearTimeout @timer if @timer != null

    if next_index > @term_index
      return

    @timer = setTimeout () =>
      if @frames[next_index] == undefined
        @state = ImageAnimeState.loadingAndPausing
        return
      @jumpFrame(next_index)
    , @times[next_index] - @times[next_index - 1]

  ###
  =============================================
   notification function
  =============================================
  ###

  onLoadFrame: (frame, index) ->
    @frames[index] = URL.createObjectURL(new Blob([frame], { type: "image/jpeg" })) # setting MIME type to image
    @loadFrame(index + 1)

    if @state == ImageAnimeState.loadingAndPausing && @index + 1 == index
      @jumpFrame(index)

  ###
   Notification function for Player
  =============================================
  ###

  onStartAnime: () ->
  onChangeFrame: (frames, current) ->
  onStopAnime: () ->