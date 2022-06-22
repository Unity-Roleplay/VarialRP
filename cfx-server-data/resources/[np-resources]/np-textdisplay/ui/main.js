var RowsData = [];
var Rows = [];
var saved = "";

const OpenMenu = (data) => {
    $(`.main-wrapper`).fadeIn(0)
    $(`.background`).fadeIn(0)
    SetHeader(data.header)
    AddRow(data.rows)
}

function SetHeader(header) {
    var element
    element = $('<h1>' + header + '<h1>');
    $('.heading').append(element);
    saved = element
}

const CloseMenu = () => {
    $(`.main-wrapper`).fadeOut(0);
    $(`.background`).fadeOut(0);
    $(saved).remove();
    RowsData = [];
    Rows = [];
    saved = "";
};

function AddRow(data) {
    RowsData = data
    for (var i = 0; i < RowsData.length; i++) {
        var message = RowsData[i].txt
        var id = RowsData[i].id
        var element

        element = $('<label for="usr">' + message + '</label>');
        $('.body').append(element);
        Rows[id] = element
    }
    
}

const CancelMenu = () => {
    for (var i = 0; i < RowsData.length; i++) {
        var id = RowsData[i].id
        $(Rows[id]).remove();
    }
    $.post(`https://np-textdisplay/cancel`)
    return CloseMenu();
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const action = data.action
    switch (action) {
        case "OPEN_MENU":
            CancelMenu()
            return OpenMenu(info);
        case "CLOSE_MENU":
            return CancelMenu();
        default:
            return;
    }
})