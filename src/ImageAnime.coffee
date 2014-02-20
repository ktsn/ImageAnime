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

  constructor: (@frames, @times) ->
    @term_index = @frames.length - 1

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

  jumpFrame: (index) ->
    @index = index
    @onChangeFrame(@frames, index)
    @setTransitionTimer(index + 1) if @state >= ImageAnimeState.loadingAndPausing

  setTransitionTimer: (next_index) ->
    if next_index > @term_index
      @pause()
      return

    clearTimeout @timer if @timer != null

    @timer = setTimeout () =>
      @jumpFrame(next_index)
    , @times[next_index] - @times[next_index - 1]

  ###
   Notification function for Player
  =============================================
  ###

  onStartAnime: () ->
  onChangeFrame: (frames, current) ->
  onStopAnime: () ->