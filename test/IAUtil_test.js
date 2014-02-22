/**
 * Created with IntelliJ IDEA.
 * User: katashin
 * Date: 2014/02/22
 */

var url = "http://www.example.com/";

describe("ajaxGetBlob Test", function() {
    it("returns a Blob object when the request is succeeded", function() {
        var success = jasmine.createSpy("success");

        runs(function() {
            IAUtil.ajaxGetBlob("images/01.jpg", success);
        });

        waitsFor(function() {
            return success.callCount > 0;
        });

        runs(function() {
            expect(success.mostRecentCall.args[0] instanceof Blob).toEqual(true);
        });
    });
});

describe("getURLWithParams Test", function() {
    it("returns original URL if the params object is undefined", function() {
        var res = IAUtil.getURLWithParams(url);
        expect(res).toEqual(url);
    });

    it("returns original URL if the params object has no property", function() {
        var res = IAUtil.getURLWithParams(url, {});
        expect(res).toEqual(url);
    });
});