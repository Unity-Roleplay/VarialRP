let Entries = [];
let EntryOptions = [];
let IsPeakActive = false;
let Context = 0;

window.addEventListener('message', function (event) {
    let item = event.data;
    let response = item.response;
    switch (response) {
        case "openTarget":
            IsPeakActive = false;
            $(".target-label").html("");
            $('.target-wrapper').show();
            break;
        case "closeTarget":
            $("#eye2").show()
            $("#eye1").hide()
            $(".target-label").html("");
            $('.target-wrapper').hide();
            return;
        case "refresh":
            Entries = item.payload
            break;
        case "update":
            payload = item.payload;
            IsPeakActive = payload.active;
            EntryOptions = payload.options;
            break;
        case "interact":
            payload = item.payload;
            Context = payload.context;
            break;
    }

    if (IsPeakActive) {
        $(".target-label").html("");
        for (let Row in EntryOptions) {
            if (Entries[Row] && EntryOptions[Row] && Entries[Row].id && Row === Entries[Row].id) {
                $(".target-label").append("<div id='target-" + Row + "'<li><span class='target-icon'><i class='fas fa-" + Entries[Row].icon + "'></i></span>&nbsp" + Entries[Row].label + "</li></div>");
                $("#target-" + Row).hover((e) => {
                    $("#target-" + Row).css("color", e.type === "mouseenter" ? "rgba(0, 255, 171, 0.85)" : "white")
                })

                $("#target-" + Row + "").css("padding-top", "7px");

                $("#target-" + Row).data('TargetData', Entries[Row]);
            }
        }
        $("#eye1").show()
        $("#eye2").hide()
    } else {
        $(".target-label").html("");
        $("#eye2").show()
        $("#eye1").hide()
    }
});

$(document).on('mousedown', (event) => {
    let element = event.target;

    if (element.id.split("-")[0] === 'target') {
        let TargetData = $("#" + element.id).data('TargetData');

        $.post('https://np-interact/selectTarget', JSON.stringify({
            option: TargetData,
            context: Context,
        }));

        IsPeakActive = false;
        $(".target-label").html("");
        $('.target-wrapper').hide();
    }
});

$(document).on('keydown', function () {
    switch (event.keyCode) {
        case 27: // ESC
            IsPeakActive = false;
            $(".target-label").html("");
            $('.target-wrapper').hide();
            $.post('https://np-interact/closeTarget');
            break;
    }
});
