function addGaps(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
    }
    return x1 + x2;
}

$(document).ready(function () {
    window.addEventListener('message', function (event) {
        var item = event.data;

        /* View */
        if (item.viewcash == true) {
            $('.cash').html('<p id="cash"><span class="green"> $ </span>' + Number(event.data.amount).toLocaleString() + '</p>');
            $('.cash').show();
            setTimeout(function () {
                $('.cash').fadeOut(600)
            }, 8000)
        }
        if (item.viewbank == true) {
            $('.balance').html('<p id="balance"><img id="icon" src="bank-icon.png" alt=""/>' + Number(event.data.amount).toLocaleString() + '</p>');
            $('.balance').show();
            setTimeout(function () {
                $('.balance').fadeOut(600)
            }, 8000)
        }
        if (item.viewall == true) {
            $('.cash').html('<p id="cash"><span class="green"> $ </span>' + Number(event.data.amount).toLocaleString() + '</p>');
            $('.balance').html('<p id="balance"><img id="icon" src="bank-icon.png" alt=""/>' + Number(event.data.amount2).toLocaleString() + '</p>');
            $('.balance').show();
            $('.cash').show();
            setTimeout(function () {
                $('.balance').fadeOut(600)
                $('.cash').fadeOut(600)
            }, 8000)
        }

        /* Add */
        if (item.addcash == true) {
            $('.cash').html('<p id="cash"><span class="green"> $ </span>' + Number(event.data.amount2).toLocaleString() + '</p>');
            $('.cash').show();
            setTimeout(function () {
                $('.cash').fadeOut(600)
            }, 4000)

            $('.cashtransaction').show();
            var element = $('<p id="add-balance"><span class="pre">+</span><span class="green"> $ </span>' + addGaps(event.data.amount) + '</p>');
            $(".cashtransaction").append(element);

            setTimeout(function () {
                $(element).fadeOut(600, function () {
                    $(this).remove();
                })
            }, 2000)
        }
        if (item.addbank == true) {
            $('.balance').html('<p id="balance"><img id="icon" src="bank-icon.png" alt=""/>' + Number(event.data.amount2).toLocaleString() + '</p>');
            $('.balance').show();
            setTimeout(function () {
                $('.balance').fadeOut(600)
            }, 4000)

            $('.transaction').show();
            var element = $('<p id="add-balance"><span class="pre">+</span><span class="green"> $ </span>' + addGaps(event.data.amount) + '</p>');
            $(".transaction").append(element);

            setTimeout(function () {
                $(element).fadeOut(600, function () {
                    $(this).remove();
                })
            }, 2000)
        }

        /* Remove */
        if (item.removecash == true) {
            $('.cash').html('<p id="cash"><span class="green"> $ </span>' + Number(event.data.amount2).toLocaleString() + '</p>');
            $('.cash').show();
            setTimeout(function () {
                $('.cash').fadeOut(600)
            }, 4000)

            $('.cashtransaction').show();
            var element = $('<p id="add-balance"><span class="pre">-</span><span class="red"> $ </span>' + addGaps(event.data.amount) + '</p>');
            $(".cashtransaction").append(element);
            setTimeout(function () {
                $(element).fadeOut(600, function () {
                    $(this).remove();
                })
            }, 2000)
        }
        if (item.removebank == true) {
            $('.balance').html('<p id="balance"><img id="icon" src="bank-icon.png" alt=""/>' + Number(event.data.amount2).toLocaleString() + '</p>');
            $('.balance').show();
            setTimeout(function () {
                $('.balance').fadeOut(600)
            }, 4000)

            $('.transaction').show();
            var element = $('<p id="add-balance"><span class="pre">-</span><span class="red"> $ </span>' + addGaps(event.data.amount) + '</p>');
            $(".transaction").append(element);
            setTimeout(function () {
                $(element).fadeOut(600, function () {
                    $(this).remove();
                })
            }, 2000)
        }
    });
});