var contactList = [];

function addContact(item) {
    if (contactList.some(function (e) { return e.name == item.name && e.number == item.number; })) {
        return;
    }

    contactList.push(item);

    var number = item.number.toString();
    var phoneNumber = "(" + number.slice(0, 3) + ") " + number.slice(3, 6) + "-" + number.slice(6, 10);

    var element = $(`
    <li id="${item.name}-${item.number}" style="margin-top: 1.5%;">
        <div class="collapsible-header contacts-collapsible-header">
            <i class="fas fa-user-circle fa-2x"></i>
            <span style="word-break: break-word">${item.name}</span>
            <span class="new badge number-badge" style="width:40%; background-color: transparent;" data-badge-caption="">${phoneNumber}</span>
        </div>
        <div class="collapsible-body center-align icon-spacing contacts-collapsible-body">
            <i class="fas fa-phone-alt fa-2x btn-contacts-call contacts-button" data-name="${item.name}" data-number="${item.number}"></i>
            <i class="fas fa-comment-medical fa-2x btn-contacts-send-message contacts-button" data-number="${item.number}"></i>
            <i class="fas fa-user-minus fa-2x btn-contacts-remove contacts-button" data-name="${item.name}" data-number="${item.number}"></i>
        </div>
    </li>`);

    $(".contacts-entries").append(element);
}

function removeContact(item) {
    $('#' + item.name + '-' + item.number).remove();
    contactList = contactList.filter(function (e) {
        return e.name != item.name && e.number != item.number;
    });
}

$(".contacts-add-new").click(function () {
    $("#contacts-add-new").modal("open");
});

$(".contacts-entries, .call-history-entries").on("click", ".btn-contacts-call", function () {
    $.post("https://np-phone/callContact", JSON.stringify({ name: $(this).data("name"), number: $(this).data("number") }));
});

$(".contacts-entries, .call-history-entries").on("click", ".btn-contacts-send-message", function (event) {
    $("#messages-send-modal").modal("open");
    $("#messages-send-modal #new-message-number").val($(this).data("number"));
    M.updateTextFields();
});

$(".contacts-entries-wrapper").on("click", ".btn-contacts-remove", function () {
    $("#confirm-modal-accept").data("name", $(this).data("name"));
    $("#confirm-modal-accept").data("number", $(this).data("number"));
    $("#confirm-modal").modal("open");
    $("#confirm-modal-question").text(`Are you sure you want to delete ${$(this).data("name")}?`);
});

function ContactsFilter() {
    var filter = $('#new-contact-search').val();
    $("ul.contacts-entries li").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

$('#new-contact-search').keyup(debounce(function () {
    ContactsFilter();
}, 500));