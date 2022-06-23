function addMessages(messages, clientNumber) {
    $(".messages-entries").empty();

    if (messages && Object.keys(messages).length > 0) {
        for (let message of messages) {
            if (message && message.receiver && message.message) {
                addMessage(message, clientNumber);
            }
        }
    }

    $(".notification-sms").fadeOut(150);

    openContainer("messages");
}

function addMessage(item) {
    var date = (item.date === undefined ? Date.now() : item.date);

    var element = $(`
    <div class="row messages-entry">
        <div class="col s2 white-text">
            <i class="fas fa-user-circle fa-2x"></i>
        </div>
        <div class="col s10 messages-entry-details">
            <div class="row no-padding">
                <div class="col s8 messages-entry-details-sender">${item.msgDisplayName}</div>
                <div class="col s4 messages-entry-details-date right-align">${moment(date).local().fromNow()}</div>
            </div>
            <div class="row ">
                <div class="col s12 messages-entry-body">${item.message}</div>
            </div>
        </div>
    </div>`);

    element.id = item.id;
    element.click(function () {
        $.post("https://np-phone/messageRead", JSON.stringify({
            sender: item.sender,
            receiver: item.receiver,
            displayName: item.msgDisplayName
        }));
    });

    $(".messages-entries").prepend(element);
}

function addMessagesRead(displayName, messages, clientNumber) {
    $(".message-entries").empty();
    $(".message-recipient").empty();
    $(".message-recipient").append(displayName);

    if (messages && Object.keys(messages).length > 0) {
        for (let message of messages) {
            if (message && message.receiver && message.message) {
                addMessageRead(message, clientNumber, displayName);
            }
        }
    }

    openContainer("message");
}

function addMessageRead(item, clientNumber, displayName) {
    var date = (item.date === undefined ? Date.now() : item.date);

    if (item.sender === clientNumber) {
        var element = $(`
        <div class="row message-entry">
            <div class="chat-bubble right">${item.message}
                <div class="message-details">
                    <span aria-label="${moment(date).local().calendar(null, calendarFormatDate)}" data-balloon-pos="left">${moment(date).local().fromNow()}</span>
                </div>
            </div>
        </div>`);

        element.id = item.id;
        $(".message-entries").append(element);
        $(".message-entries").data("sender", item.receiver);
    } else {
        var element = $(`
        <div class="row message-entry">
            <div class="chat-bubble left">${item.message}
                <div class="message-details">
                    <span aria-label="${moment(date).local().calendar(null, calendarFormatDate)}" data-balloon-pos="down">${moment(date).local().fromNow()}</span>
                </div>
            </div>
        </div>`);

        element.id = item.id;
        $(".message-entries").append(element);
        $(".message-entries").data("sender", item.sender);
        $(".message-entries").data("receiver", item.sender);
    }

    $(".message-entries").data("displayName", displayName);
    $(".message-entries").data("clientNumber", clientNumber);
}

function addMessagesOther(messages, clientNumber) {
    $(".messages-entries").empty();

    if (messages && Object.keys(messages).length > 0) {
        for (let message of messages) {
            if (message && message.receiver && message.message) {
                addMessageOther(message, clientNumber);
            }
        }
    }

    openContainer("messages");
}

function addMessageOther(item) {
    // Check if message is already added
    var receiver = item.name || item.receiver;
    var date = (item.date === undefined ? Date.now() : item.date);

    var element = $(`
    <div class="row messages-entry">
        <div class="col s2 white-text">
            <i class="fas fa-user-circle fa-2x"></i>
        </div>
        <div class="col s10 messages-entry-details">
            <div class="row no-padding">
                <div class="col s8 messages-entry-details-sender">${item.msgDisplayName}</div>
                <div class="col s4 messages-entry-details-date right-align">${moment(date).local().fromNow()}</div>
            </div>
            <div class="row ">
                <div class="col s12 messages-entry-body">${item.message}</div>
            </div>
        </div>
    </div>`);

    element.id = item.id;
    element.click(function () {
        $.post("https://np-phone/messageRead", JSON.stringify({
            sender: item.sender,
            receiver: item.receiver,
            displayName: receiver,
            clientPhone: item.clientNumber
        }));
    });

    $(".messages-entries").prepend(element);
}

$(".messages-new").click(function () {
    $("#messages-send-modal").modal("open");
});

$('.message-send-new').click(function () {
    $('#messages-send-modal').modal('open');
    let sender = $('.message-entries').data("sender");
    $('#messages-send-modal #new-message-number').val(sender);
    M.updateTextFields();
});

function MessagesFilter() {
    var filter = $("#messages-search").val();
    $(".messages-entries .messages-entry").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

$("#messages-search").keyup(debounce(function () {
    MessagesFilter();
}, 500));