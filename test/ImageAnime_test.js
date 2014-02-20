/**
 * Created with IntelliJ IDEA.
 * User: katashin
 * Date: 2014/02/20
 */

var images = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];
var times = [0, 100, 200, 300, 400, 500, 600];
var anime = new ImageAnime(images, times);

describe('The test on event handler', function() {
    it('calls onStartAnime after calls play', function() {
        spyOn(anime, 'onStartAnime');
        anime.play();
        expect(anime.onStartAnime).toHaveBeenCalled();
    });

    it('calls onChangeFrame after calls jumpFrame', function() {
        spyOn(anime, 'onChangeFrame');
        anime.jumpFrame(3);
        expect(anime.onChangeFrame).toHaveBeenCalledWith(images[3]);
    });

    it('calls onStopAnime after calls stop', function() {
        spyOn(anime, 'onStopAnime');
        anime.stop();
        expect(anime.onStopAnime).toHaveBeenCalled();
    });

    it('calls onChangeFrame 3 times after 300ms when calls play', function() {
        spyOn(anime, 'onChangeFrame');
        var flag = false;

        runs(function() {
            anime.play();
            setTimeout(function() {
                flag = true;
            }, 310);
        });

        waitsFor(function() {
            return flag;
        });

        runs(function() {
            expect(anime.onChangeFrame.callCount).toEqual(3);
        });
    });

    it('calls onChangeFrame with correct arguments', function() {
        anime.stop();
        spyOn(anime, 'onChangeFrame');
        var flag = false;

        runs(function() {
            anime.play();
            setTimeout(function() {
                flag = true;
            }, 310);
        });

        waitsFor(function() {
            return flag;
        });

        runs(function() {
            var args = anime.onChangeFrame.argsForCall;
            for (var i = 0; i < args.length; i++) {
                expect(args[i][0]).toEqual(images[i + 1]);
            }
        });
    });
});