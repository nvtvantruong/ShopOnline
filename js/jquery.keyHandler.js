/// <reference path="../../js/jquery.js" />
(function ($) {
    $.fn.extend({
        keyHandler: function (options) {
            var defaults = {
            };

            var options = $.extend(defaults, options);

            var linkTo = function(url) {
                window.location.href = url;
            };

            return this.each(function () {
                var $this = $(this);

                $this.on('keyup', function (event) {
                    var key = (event.which || event.keyCode);

                    if (key != 13 && key != 27)
                        return;

                    var onEnter = $.trim($this.data("on-enter"));
                    var onEsc = $.trim($this.data("on-esc"));
                    var url = $.trim($this.data("target-url"));
                    var text = this.value.replace(/ /g, "+");

                    if (key == 13) {
                        if(url != ""){
                            linkTo(url + text);
                        }
                        else if (onEnter != ""){
                            eval(onEnter);
                        }
                        return;
                    }

                    if (key == 27 && onEsc != "") {
                        eval(onEsc);
                        return;
                    }
                });
            });
        }
    });
})(jQuery);

$(function () {
    $(".keyhandler").keyHandler();
});