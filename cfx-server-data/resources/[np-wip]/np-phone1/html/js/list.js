function addOutstandingPayments(payments) {
    $('.outstanding-payments-entries').empty();

    for (let payment in Object.keys(payments)) {
        $('.outstanding-payments-entries').append("<div class='col s12 outstanding-payment-entry'>" + payments[payment] + "<hr></div>");
    }

    openContainer('outstanding-payments');
}

function OutstandingFilter() {
    var filter = $('#outstanding-search').val();
    $(".outstanding-payments-entries .outstanding-payment-entry").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

$('#outstanding-search').keyup(debounce(function () {
    OutstandingFilter();
}, 500));