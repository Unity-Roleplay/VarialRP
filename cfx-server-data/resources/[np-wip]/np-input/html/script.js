var RowsData = {};
var Rows = {};

const OpenMenu = (data) => {
    $(`.main-wrapper`).fadeIn(0)

    $( ".body" ).empty();
    RowsData = {};
    Rows = {};

    AddRow(data)
}

const CloseMenu = () => {
    $(`.main-wrapper`).fadeOut(0);

    $( ".body" ).empty();
    RowsData = {};
    Rows = {};
};

function AddRow(data) {
    RowsData = data

    for (var i = 0; i < RowsData.length; i++) {
        let element

        element = `<div class="input-wrapper">`
        element += `<label>${RowsData[i].label}</label>`;
        element += `<input type="text" class="form-control" id="${RowsData[i].name}"/>`;
        element += `<span class="fas fa-${RowsData[i].icon} input-icon"></span>`;
        element += `</div>`

        $(".body").append(element);
        Rows[RowsData[i].name] = element
    }
}

$(`#submit`).click(() => {
    SubmitData();
})

function SubmitData() {
    const returnData = {};

    for (var i = 0; i < RowsData.length; i++) {
        var id = RowsData[i].name
        var data = document.getElementById(id)

        if (data.value) {
            returnData[id] = data.value;
        } else {
            returnData[id] = null;
        }
        $(Rows[id]).remove();
    }

    PostData({
        data: returnData
    })

    CloseMenu();
}

const PostData = (data) => {
    return $.post(`https://${GetParentResourceName()}/dataPost`, JSON.stringify(data))
}

const CancelMenu = () => {
    for (var i = 0; i < RowsData.length; i++) {
        var id = RowsData[i].id
        $(Rows[id]).remove();
    }
    $.post(`https://${GetParentResourceName()}/cancel`)
    return CloseMenu();
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const action = data.action
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(info);
        case "CLOSE_MENU":
            return CloseMenu();
        default:
            return;
    }
})

document.onkeyup = function (event) {
    event = event || window.event;
    var charCode = event.keyCode || event.which;
    if (charCode == 27) {
        CancelMenu();
    } else if (charCode == 13) {
        SubmitData()
    }
};