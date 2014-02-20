var ImageAnime, ImageAnimePlayer, ImageAnimeState,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

ImageAnimeState = {
  stopped: 0,
  pausing: 1,
  loadingAndPausing: 2,
  playing: 3
};

ImageAnime = (function() {
  ImageAnime.prototype.index = 0;

  ImageAnime.prototype.frames = null;

  ImageAnime.prototype.times = null;

  ImageAnime.prototype.term_index = -1;

  ImageAnime.prototype.state = ImageAnimeState.stopped;

  ImageAnime.prototype.timer = null;

  function ImageAnime(frames, times) {
    this.frames = frames;
    this.times = times;
    this.term_index = this.frames.length - 1;
  }

  ImageAnime.prototype.play = function() {
    this.state = ImageAnimeState.playing;
    this.setTransitionTimer(this.index + 1);
    return this.onStartAnime();
  };

  ImageAnime.prototype.pause = function() {
    if (this.timer !== null) {
      clearTimeout(this.timer);
    }
    return this.state = ImageAnimeState.pausing;
  };

  ImageAnime.prototype.stop = function() {
    if (this.timer !== null) {
      clearTimeout(this.timer);
    }
    this.state = ImageAnimeState.stopped;
    this.jumpFrame(0);
    return this.onStopAnime();
  };

  ImageAnime.prototype.jumpFrame = function(index) {
    this.index = index;
    this.onChangeFrame(this.frames, index);
    if (this.state >= ImageAnimeState.loadingAndPausing) {
      return this.setTransitionTimer(index + 1);
    }
  };

  ImageAnime.prototype.setTransitionTimer = function(next_index) {
    if (next_index > this.term_index) {
      this.pause();
      return;
    }
    if (this.timer !== null) {
      clearTimeout(this.timer);
    }
    return this.timer = setTimeout((function(_this) {
      return function() {
        return _this.jumpFrame(next_index);
      };
    })(this), this.times[next_index] - this.times[next_index - 1]);
  };


  /*
   Notification function for Player
  =============================================
   */

  ImageAnime.prototype.onStartAnime = function() {};

  ImageAnime.prototype.onChangeFrame = function(frames, current) {};

  ImageAnime.prototype.onStopAnime = function() {};

  return ImageAnime;

})();

ImageAnimePlayer = (function() {
  ImageAnimePlayer.prototype.el = null;

  ImageAnimePlayer.prototype.monitor = null;

  ImageAnimePlayer.prototype.prev_monitor = null;

  ImageAnimePlayer.prototype.next_monitor = null;

  ImageAnimePlayer.prototype.anime_backend = null;

  function ImageAnimePlayer(el, image_urls, times) {
    this.el = el;
    this.imageChange = __bind(this.imageChange, this);
    this.el.className = "ia-player";
    this.monitor = document.createElement("img");
    this.monitor.className = "ia-monitor";
    this.prev_monitor = this.monitor.cloneNode(false);
    this.next_monitor = this.monitor.cloneNode(false);
    this.monitor.classList.add("ia-monitor-current");
    this.el.appendChild(this.prev_monitor);
    this.el.appendChild(this.monitor);
    this.el.appendChild(this.next_monitor);
    this.anime_backend = new ImageAnime(image_urls, times);
    this.anime_backend.onChangeFrame = this.imageChange;
    this.jumpFrame(0);
  }

  ImageAnimePlayer.prototype.play = function() {
    return this.anime_backend.play();
  };

  ImageAnimePlayer.prototype.pause = function() {
    return this.anime_backend.pause();
  };

  ImageAnimePlayer.prototype.stop = function() {
    return this.anime_backend.stop();
  };

  ImageAnimePlayer.prototype.jumpFrame = function(index) {
    return this.anime_backend.jumpFrame(index);
  };


  /*
   Callback functions from backend
  ===============================================
   */

  ImageAnimePlayer.prototype.imageChange = function(images, current) {
    this.monitor.src = images[current];
    if (current > 0) {
      this.prev_monitor.src = images[current - 1];
    }
    if (current < images.length - 1) {
      return this.next_monitor.src = images[current + 1];
    }
  };

  return ImageAnimePlayer;

})();
