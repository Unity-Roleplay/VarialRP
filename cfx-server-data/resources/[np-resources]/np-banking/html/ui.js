var firstname = {};
var lastname = {};
var bank = {};
var job = {};
var rtarget = {};
var ramount = {};
var rlabel = {};
var rsender = {};
var cash = {};
var bankid = {};
var iden = {};

var bizrtarget = {};
var bizramount = {};
var bizrlabel = {};
var bizrsender = {};
var bizriden = {};

var biz_name = {}
var biz_bank = {}
var biz_bank_id = {}

$(document).ready(function () {
    $("#bank-container").hide();
    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type == "bank") {
            if (item.boa == "atm") {
                if (item.toggle) {
                    $(".spinner").hide();
                    $("#bank-container").slideToggle(500);
                    $("#load-container").hide();
                    $(".deposit-button").hide();
                    $(".biz-deposit-button").hide();
                } else {
                    $(".deposit-button").show();
                    $(".biz-deposit-button").show();
                }
            } else {
                if (item.toggle) {
                    $(".spinner").hide();
                    $("#bank-container").slideToggle(500);
                    $("#load-container").hide();
                    $(".deposit-button").show();
                    $(".biz-deposit-button").show();
                } else {
                    $("#bank-container").hide();
                }
            }
        } else if (item.type == "refresh") {
        }

        if (item.type == "load") {
            $("#load-container").show();
            $(".spinner").show();
        }


        if (item.type == "infos") {
            firstname = item.firstname
            lastname = item.lastname
            bank = item.bank,
            cash = item.cash,
            bankid = item.bankid
            accountbox()

            if(item.hasbusiness) {
                biz_name = item.biz_name;
                biz_bank_id = item.biz_bank_id;
                biz_bank = item.biz_bank;
                
                bizbox()

                $("#transaction2").hide();
                $("#biz-withdraw-page").hide(); 
                $("#biz-transfer-page").hide();
                $("#biz-deposit-page").hide();
                
            }else{

                $(".second").hide();
                $("#transaction2").hide();
                $("#biz-withdraw-page").hide(); 
                $("#biz-transfer-page").hide();
                $("#biz-deposit-page").hide();
            }
        }


        if (item.type == "recent") {
            if (item.sender == "empty")
            {
                $("#transaction").hide();
            }else{
                $("#transaction").show();
                rtarget = item.target,
                ramount = item.amount,
                rlabel = item.label,
                rdate = item.date,
                rsender = item.sender,
                rtype = item.rtype,
                riden = item.iden,
                bankid = item.bankid,
                bank = item.bank
                minibox()
            }
        }

        if (item.type == "recentbiz") {
            if (item.sender == "empty")
            {
                $("#transaction2").hide();
            }else{
                $("#transaction2").show();
                bizrtarget = item.targetbiz;
                bizramount = item.amountbiz;
                bizrlabel = item.labelbiz;
                bizrdate = item.datebiz;
                bizrsender = item.senderbiz;
                bizrtype = item.rtypebiz;
                bizriden = item.idenbiz;
                bank = item.bank;
                minibox1()
            }
        }


        if (item.type == "ccon") {

            $(".spinner-co").show();
            $(".hide-co").hide();
            setTimeout(
                function () {
                    $("#withdraw-page").hide();
                    $("#transfer-page").hide();
                    $("#deposit-page").hide();
                    $("#biz-withdraw-page").hide(); 
                    $("#biz-transfer-page").hide();
                    $("#biz-deposit-page").hide();
                    $(".back-filter").hide();
                    $(".hide-co").show();
                      $(".spinner-co").hide();
                }, 1200);
                $("#transaction").empty();
               
        }
    })

});

var active = 1;

$('.accounts-box').click(function (e) {
    var theClass = this.className;

    if (theClass == "accounts-box second") {
        $(".second").addClass("active");
        $(".first").removeClass("active");
        $("#transaction").empty();
        $("#transaction").hide();
        $("#transaction2").show();
        $.post('https://np-banking/getRecentBiz', JSON.stringify({
            bizname: biz_name
        }));

    } else if (theClass == "accounts-box first") {
        $(".first").addClass("active");
        $(".second").removeClass("active");
        $("#transaction2").empty();
        $("#transaction2").hide();
        $("#transaction").show();
        $.post('https://np-banking/getRecent', JSON.stringify({
        }));
    }
});

var money = {};


function accountbox() {
    abank = Math.abs(bank).toLocaleString();
    acash = Math.abs(cash).toLocaleString();

    $(".account-f-name").html(firstname + " " + lastname);
    $(".account-f").html("Personal Account / " + bankid);
    $(".box-header").html("Personal Account / " + bankid);
    $(".account-f-balance").html('$' + abank + ".00");
    $(".cash").html('Cash: $' + acash + ".00");
}

function bizbox() {
    abizbank = Math.abs(biz_bank).toLocaleString();
    $(".biz-f-name").html(firstname + " " + lastname);
    $(".biz-f").html(biz_name + " / " + biz_bank_id);
    $(".biz-box-header").html(biz_name + " / " + biz_bank_id);
    $(".biz-f-balance").html('$' + abizbank + ".00");
}

function minibox() {

    var timesences = humanized_time_span(rdate)
    var pos = ""
    if (rtype !== "pos") {
        color = "#eea06d"
        pos = "-"
        money = Math.abs(ramount).toLocaleString();

    } else {
        color = "#7bda78"
        money = ramount.toLocaleString();
    }
    $("#transaction").prepend('<div id="transaction-box"><div class="tr-head"><h3 > Personal Account / ' + bankid + ' [' + riden + ']</h3><h3 class="headr"></h3></div><div class="middle"><div class="money" style="color:' + color + ' ">' + pos + '$' + money + '.00</div><div class="name">' + rtarget + '</div><div class="clock">' + timesences + '</div></div><div class="middle-two"><div class="name-bottom">' + rsender + '</div></div><div class="bottom"><div class="msg-font">Message</div><div class="msg-ex">' + rlabel + '</div></div></div>');
}

function minibox1() {

    var biztimesences = humanized_time_span(bizrdate)
    var bizpos = ""
    if (bizrtype !== "pos") {
        bizcolor = "#eea06d"
        bizpos = "-"
        bizmoney = Math.abs(bizramount).toLocaleString();

    } else {
        bizcolor = "#7bda78"
        bizmoney = bizramount.toLocaleString();
    }
    $("#transaction2").prepend('<div id="transaction-box"><div class="tr-head"><h3 > ' + biz_name + ' / ' + biz_bank_id + ' [' + bizriden + ']</h3><h3 class="headr"></h3></div><div class="middle"><div class="money" style="color:' + bizcolor + ' ">' + bizpos + '$' + bizmoney + '.00</div><div class="name">' + bizrtarget + '</div><div class="clock">' + biztimesences + '</div></div><div class="middle-two"><div class="name-bottom">' + bizrsender + '</div></div><div class="bottom"><div class="msg-font">Message</div><div class="msg-ex">' + bizrlabel + '</div></div></div>');
}


$('.withdraw-button').click(function (e) {
    e.preventDefault();
    $("#w-number").val('');
    $("#w-comment").val('');
    $("#withdraw-page").fadeIn();
    $(".back-filter").show();
});

$('.deposit-button').click(function (e) {
    e.preventDefault();
    $("#d-number").val('');
    $("#d-comment").val('');
    $("#deposit-page").fadeIn();
    $(".back-filter").show();
});

$('.transfer-button').click(function (e) {
    e.preventDefault();
    $("#t-number").val('');
    $("#t-comment").val('');
    $("#t-target").val('');
    $("#transfer-page").fadeIn();
    $(".back-filter").show();
});

document.onkeyup = function (data) {
    if (data.which == 27) {
        $("#transaction").empty();
        $.post('https://np-banking/close', JSON.stringify({}));

    }
}

$('.cancel').click(function (e) {
    e.preventDefault();
    $("#withdraw-page").fadeOut();
    $("#deposit-page").fadeOut();
    $("#transfer-page").fadeOut();
    $(".back-filter").hide();
});


$('.w-okay').click(function (e) {
    var wvalue = document.getElementById("w-number").value;
    var wcomment = document.getElementById("w-comment").value;

    if (wvalue == "") {
    } else if (wvalue > bank) {
    } else {
        $.post('https://np-banking/withdraw', JSON.stringify({
            value: wvalue,
            comment: wcomment
        })
        );
    }
});

$('.d-okay').click(function (e) {
    var dvalue = document.getElementById("d-number").value;
    var dcomment = document.getElementById("d-comment").value;

    if (dvalue == "") {
    } else if (dvalue > cash) {
    } else {
        $.post('https://np-banking/deposit', JSON.stringify({
            value: dvalue,
            comment: dcomment
        })
        );
    }
});

$('.t-okay').click(function (e) {
    var tvalue = document.getElementById("t-number").value;
    var tcomment = document.getElementById("t-comment").value;
    var tid = document.getElementById("t-target").value;

    if (tvalue == "" && tcomment =="") {
    } else if (tvalue > bank) {
    } else {
        $.post('https://np-banking/transfer', JSON.stringify({
            value: tvalue,
            comment: tcomment,
            id: tid
        })
        );
        document.getElementById("t-number").value = "";
        document.getElementById("t-comment").value = "";
        document.getElementById("t-target").value = "";
    }
});

// 

$('.biz-withdraw-button').click(function (e) {
    e.preventDefault();
    $("#biz-w-number").val('');
    $("#biz-w-comment").val('');
    $("#biz-withdraw-page").fadeIn();
    $(".back-filter").show();
});

$('.biz-deposit-button').click(function (e) {
    e.preventDefault();
    $("#biz-d-number").val('');
    $("#biz-d-comment").val('');
    $("#biz-deposit-page").fadeIn();
    $(".back-filter").show();
});

$('.biz-transfer-button').click(function (e) {
    e.preventDefault();
    $("#biz-t-number").val('');
    $("#biz-t-comment").val('');
    $("#biz-t-target").val('');
    $("#biz-transfer-page").fadeIn();
    $(".back-filter").show();
});

$('.biz-cancel').click(function (e) {
    e.preventDefault();
    $("#biz-withdraw-page").fadeOut();
    $("#biz-deposit-page").fadeOut();
    $("#biz-transfer-page").fadeOut();
    $(".back-filter").hide();
});


$('.biz-w-okay').click(function (e) {
    var bizwvalue = document.getElementById("biz-w-number").value;
    var bizwcomment = document.getElementById("biz-w-comment").value;

    if (bizwvalue == "") {
    } else if (bizwvalue > biz_bank) {
    } else {
        $.post('https://np-banking/withdrawBiz', JSON.stringify({
            value: bizwvalue,
            comment: bizwcomment,
            bizname: biz_name
        })
        );
    }
});

$('.biz-d-okay').click(function (e) {
    var bizdvalue = document.getElementById("biz-d-number").value;
    var bizdcomment = document.getElementById("biz-d-comment").value;

    if (bizdvalue == "") {
    } else if (bizdvalue > cash) {
    } else {
        $.post('https://np-banking/depositBiz', JSON.stringify({
            value: bizdvalue,
            comment: bizdcomment,
            bizname: biz_name
        })
        );
    }
});

$('.biz-t-okay').click(function (e) {
    var biztvalue = document.getElementById("biz-t-number").value;
    var biztcomment = document.getElementById("biz-t-comment").value;
    var biztid = document.getElementById("biz-t-target").value;

    if (biztvalue == "" && biztcomment =="") {
    } else if (biztvalue > biz_bank) {
    } else {
        $.post('https://np-banking/transferBiz', JSON.stringify({
            value: biztvalue,
            comment: biztcomment,
            id: biztid,
            bizname: biz_name
        })
        );
    }
});

//

function humanized_time_span(date, ref_date, date_formats, time_units) {
    //Date Formats must be be ordered smallest -> largest and must end in a format with ceiling of null
    date_formats = date_formats || {
        past: [
            { ceiling: 60, text: "$seconds seconds ago" },
            { ceiling: 3600, text: "$minutes minutes ago" },
            { ceiling: 86400, text: "$hours hours ago" },
            { ceiling: 2629744, text: "$days days ago" },
            { ceiling: 31556926, text: "$months months ago" },
            { ceiling: null, text: "$years years ago" }
        ],
        future: [
            { ceiling: 60, text: "in $seconds seconds" },
            { ceiling: 3600, text: "in $minutes minutes" },
            { ceiling: 86400, text: "in $hours hours" },
            { ceiling: 2629744, text: "in $days days" },
            { ceiling: 31556926, text: "in $months months" },
            { ceiling: null, text: "in $years years" }
        ]
    };
    //Time units must be be ordered largest -> smallest
    time_units = time_units || [
        [31556926, 'years'],
        [2629744, 'months'],
        [86400, 'days'],
        [3600, 'hours'],
        [60, 'minutes'],
        [1, 'seconds']
    ];

    date = new Date(date);
    ref_date = ref_date ? new Date(ref_date) : new Date();
    var seconds_difference = (ref_date - date) / 1000;

    var tense = 'past';
    if (seconds_difference < 0) {
        tense = 'future';
        seconds_difference = 0 - seconds_difference;
    }

    function get_format() {
        for (var i = 0; i < date_formats[tense].length; i++) {
            if (date_formats[tense][i].ceiling == null || seconds_difference <= date_formats[tense][i].ceiling) {
                return date_formats[tense][i];
            }
        }
        return null;
    }

    function get_time_breakdown() {
        var seconds = seconds_difference;
        var breakdown = {};
        for (var i = 0; i < time_units.length; i++) {
            var occurences_of_unit = Math.floor(seconds / time_units[i][0]);
            seconds = seconds - (time_units[i][0] * occurences_of_unit);
            breakdown[time_units[i][1]] = occurences_of_unit;
        }
        return breakdown;
    }

    function render_date(date_format) {
        var breakdown = get_time_breakdown();
        var time_ago_text = date_format.text.replace(/\$(\w+)/g, function () {
            return breakdown[arguments[1]];
        });
        return depluralize_time_ago_text(time_ago_text, breakdown);
    }

    function depluralize_time_ago_text(time_ago_text, breakdown) {
        for (var i in breakdown) {
            if (breakdown[i] == 1) {
                var regexp = new RegExp("\\b" + i + "\\b");
                time_ago_text = time_ago_text.replace(regexp, function () {
                    return arguments[0].replace(/s\b/g, '');
                });
            }
        }
        return time_ago_text;
    }

    return render_date(get_format());
}