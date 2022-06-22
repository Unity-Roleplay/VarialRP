function loadBank(accounts) {
    $(".bank-entries").empty();

    for (let account of Object.keys(accounts)) {
        let accountEntry = accounts[account];

        let icon = "fas fa-piggy-bank"
        switch (accountEntry.account_type) {
            case "Group Account":
                icon = "fas fa-users"
                break;
        }

        let accountElement = `
            <li style="margin-top: 1.5%;">
                <div class="collapsible-header bank-header">
                    <i class="${icon} fa-2x"></i>
                    <span style="word-break: break-word">${accountEntry.account_name}</span>
                </div>
                <div class="collapsible-body garage-body bank-body">
                    <ul class="collection bank-collection">
                        <li class="collection-item">Account ID: ${accountEntry.account_id}</li>
                        <li class="collection-item">Account Type: ${accountEntry.account_type}</li>`
                        if (accountEntry.account_owner) {
                            accountElement += `<li class="collection-item">Account Owner: ${accountEntry.account_owner}</li>`
                        }
                        accountElement += `<li class="collection-item">Balance: $${accountEntry.account_balance.toLocaleString()}.00</li>
                        <li class="collection-item center-align">`
                        if (accountEntry.cantWithdraw !== true) {
                            accountElement += `<button class="btn-small bank-button bank-transfer" aria-label="Transfer" data-balloon-pos="up" data-bank-id="${accountEntry.account_id}"><i class="fas fa-exchange-alt"></i></button>`
                        }
        accountElement += `</li>
                    </ul>
                </div>
            </li>
        `
        $(".bank-entries").append(accountElement);
    }

    openContainer("bank");
};

$(".bank-entries").on("click", ".bank-transfer", function (e) {
    $("#bank-modal").modal("open");
    $("#bank-modal #bank-id").val($(this).data("bank-id"));
    M.updateTextFields();
});

$("#bank-form").submit(function (event) {
    event.preventDefault();

    $.post("https://np-phone/bankTransfer", JSON.stringify({
        bankid: escapeHtml($("#bank-form #bank-id").val()),
        targetid: escapeHtml($("#bank-form #bank-target-id").val()),
        amount: escapeHtml($("#bank-form #bank-amount").val()),
        comment: escapeHtml($("#bank-form #bank-comment").val()),
    }));

    $("#bank-form").trigger("reset");
    $("#bank-modal").modal("close");
});