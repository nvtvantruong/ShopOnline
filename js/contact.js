/// <reference path="jquery.min.js" />

function SendContact()
{
    $(".contact-button").html('<img src="/css/images/loading.gif" style="height: 15px;"/> Đang gửi thư ...');
    var fullName = $(".contact-full-name").val();
    var email = $(".contact-email").val();
    var mobi = $(".contact-mobi").val();
    var code = $(".contact-code").val();
    var content = $(".contact-content").val();

    var url = "/ServiceUtility.asmx/SendContact";
    var data = "{fullName: '{0}', email: '{1}', mobi: '{2}', code: '{3}', content: '{4}'}";
    data = data.replace("{0}", fullName);
    data = data.replace("{1}", email);
    data = data.replace("{2}", mobi);
    data = data.replace("{3}", code);
    data = data.replace("{4}", content);

    $.ajax({
        type: "POST",
        url: url,
        data: data,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var string = result.d.split('|');
            if(string[0] == "1")
            {
                MessageShowSuccess(string[1]);

                $(".contact-button").html("Đã gửi thư!");
            }
            else
            {
                MessageShowError(string[1]);

                $(".contact-button").html("Gửi thư");
            }
        },
        error: function (result, status, error) {
            var err = eval("(" + result.responseText + ")");
            MessageShowError(err.Message);
            $(".contact-button").html("Gửi thư");
        }
    });

    return false;
}

function MessageHideAll()
{
    $(".message-box").empty();
}

function MessageShowSuccess(value)
{
    MessageShow(value, "success");
}

function MessageShowError(value)
{
    MessageShow(value, "error");
}

function MessageShow(value, type) {
    MessageHideAll();

    var messageTemplate = '<div class="alert alert-{0} no-margin">';
    messageTemplate += '        <button type="button" class="close" data-dismiss="alert">&times;</button>';
    messageTemplate += '        <span>';
    messageTemplate += '            {1}';
    messageTemplate += '        </span>';
    messageTemplate += '   </div>';

    messageTemplate = messageTemplate.replace("{0}", type);
    messageTemplate = messageTemplate.replace("{1}", value);

    $(".message-box").html(messageTemplate);
}