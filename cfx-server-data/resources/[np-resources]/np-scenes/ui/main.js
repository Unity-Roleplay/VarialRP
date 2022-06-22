const OpenKeyboard = () => {
    $(`.main-wrapper`).fadeIn(0);
    $(`.background`).fadeIn(0);
}

const CloseKeyboard = () => {
    $(`.main-wrapper`).fadeOut(0);
    $(`.background`).fadeOut(0);
    $.post(`https://np-scenes/closeDialog`, JSON.stringify())
};

$(`#submit`).click(() => {
    SubmitData();
})

const SubmitData = () => {
    const returnData = [];
    returnData.push({ 
        text: $("#txtText").val(), 
        colour: $('#optColour').find(":selected").val(),
        distance: $("#txtDistance").val(), 
        font: $('#optFont').find(":selected").val(),
        peekOnly: $("#cbkPeekOnly").is(":checked")
    });
    $.post(`https://np-scenes/newScene`, JSON.stringify({data: returnData}))
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const action = data.action
    switch (action) {
        case "OPEN":
            return OpenKeyboard();
        case "CLOSE":
            return CloseKeyboard();
        default:
            return;
    }
})

window.addEventListener("keyup", (ev) => {
    if (ev.which == 27) {
        CloseKeyboard();
    } else if (ev.which == 13) {
        SubmitData()
    }
})

$(document).click(function (event) {
    let $target = $(event.target);
    if (!$target.closest('.main-wrapper').length &&
        $('.main-wrapper').is(":visible")) {
        CloseKeyboard();
    }
});
