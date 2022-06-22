function addCallHistoryEntries(callHistory) {
    $(".call-history-entries").empty();

    if (callHistory && Object.keys(callHistory).length > 0) {
        for (let callEntry of callHistory) {
            if (callEntry && callEntry.type && callEntry.number && callEntry.name) {
                let callIcon = (callEntry.type == 1 ? "call" : "phone_callback")
                let callIconColor = (callEntry.type == 1 ? "green" : "red")

                var number = callEntry.number.toString();
                var phoneNumber = "(" + number.slice(0, 3) + ") " + number.slice(3, 6) + "-" + number.slice(6, 10);

                var element = $(`<li style="margin-top: 1.5%;">
                    <div class="collapsible-header calls-collapsible-header" style="font-size:12px">
                        <span class="${callIconColor}-text">
                            <i class="material-icons">${callIcon}</i>
                        </span>
                        <span style="word-break: break-word">${callEntry.name}</span>
                        <span class="new badge number-badge" style="width:40%; background-color: transparent;" data-badge-caption="">${phoneNumber}</span>
                    </div>
                    <div class="collapsible-body calls-collapsible-body center-align icon-spacing">
                        <i class="fas fa-phone-alt fa-2x btn-contacts-call calls-button" data-name="${callEntry.name}" data-number="${callEntry.number}"></i>
                        <i class="fas fa-comment-medical fa-2x btn-contacts-send-message calls-button" data-number="${callEntry.number}"></i>
                        <i class="fas fa-user-plus fa-2x btn-call-history-add-contact calls-button" data-number="${callEntry.number}"></i>
                    </div>
                </li>`);
                element.data("receiver", number);
                $('.call-history-entries').append(element);
            }
        }
    }

    openContainer("call-history");
}

$('.call-history-entries').on('click', '.btn-call-history-add-contact', function () {
    $('#contacts-add-new').modal('open');
    $('#contacts-add-new #contacts-new-number').val($(this).data('number'));
    M.updateTextFields();
});