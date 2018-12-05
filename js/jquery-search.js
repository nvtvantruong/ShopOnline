function InitAutoSearch(target, searchUrl, returnUrl) {
    $(target).autocomplete({
        source: function (request, response) {
            var url = searchUrl;
            var data = "{keyword: '{0}'}";
            data = data.replace("{0}", request.term);
            $.ajax({
                url: url,
                data: data,
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataFilter: function (data) { return data; },
                success: function (data) {
                    response($.map(data.d, function (item) {
                        return {
                            value: item.Title,
                            thumb: item.Thumb,
                        }
                    }))
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //alert(textStatus);
                }
            });
        },
        minLength: 1,
        highlightClass: "highlight-autocomplete",
        select: function (event, ui) {
            //var keyword = encodeURIComponent(ui.item.value);

            var keyword = ui.item.value.replace(/ /g, '+');
            returnUrl = returnUrl.replace("{0}", keyword);
            window.location.href = returnUrl;
        }
    }).data("ui-autocomplete")._renderItem = function (ul, item) {
        var regex = new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(this.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi");
        var highlightTitle = item.value.replace(regex, "<strong class='" + this.options.highlightClass + "'>$1</strong>");
        var html = "<a><img class='thumb-autocomplete' src='{0}' /> {1}</a>";
        html = html.replace("{0}", item.thumb);
        html = html.replace("{1}", highlightTitle);

        return $("<li>").append(html).appendTo(ul);
    };
}