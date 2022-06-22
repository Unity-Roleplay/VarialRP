function addStocks(stocksData) {
    $(".stocks-entries").empty();

    for (let stock of Object.keys(stocksData)) {
        let stockEntry = stocksData[stock];
        let stockElement = `
            <li style="margin-top: 1.5%;">
                <div class="collapsible-header stocks-header">
                    ${stockEntry.identifier} <span class="new ${stockEntry.change > -0.01 ? "green" : "red"} badge" data-badge-caption="">${stockEntry.change > -0.01 ? "▲" : "▼"} ${stockEntry.change}%</span>
                </div>
                <div class="collapsible-body garage-body stocks-body">
                    <ul class="collection stocks-collection">
                        <li class="collection-item">Name: ${stockEntry.name}</li>
                        <li class="collection-item">Shares: ${stockEntry.clientStockValue}</li>
                        <li class="collection-item">Float: ${stockEntry.available}</li>
                        <li class="collection-item">Value: ${stockEntry.value}</li>
                        <li class="collection-item center-align">`
                        stockElement += `<button class="btn-small stocks-button stocks-exchange" aria-label="Transfer" data-balloon-pos="up" data-stock-id="${stockEntry.identifier}"><i class="fas fa-exchange-alt"></i></button>`
                            if (stockEntry.identifier != "SHUNG") {
                                stockElement += `
                                &nbsp;<button class="btn-small stocks-button stocks-buy" aria-label="Buy" data-balloon-pos="up" data-stock-id="${stockEntry.identifier}"><i class="fas fa-plus"></i></button>
                                &nbsp;<button class="btn-small stocks-button stocks-sell" aria-label="Sell" data-balloon-pos="up" data-stock-id="${stockEntry.identifier}"><i class="fas fa-minus"></i></button>`
                            }
        stockElement += `</li>
                    </ul>
                </div>
            </li>
        `
        $(".stocks-entries").append(stockElement);
    }

    openContainer("stocks");
};

$(".stocks-entries").on("click", ".stocks-exchange", function (e) {
    $("#stock-modal").modal("open");
    $("#stock-modal #stock-id").val($(this).data("stock-id"));
    M.updateTextFields();
});

$(".stocks-entries").on("click", ".stocks-buy", function (e) {
    $("#stock-modal-buy").modal("open");
    $("#stock-modal-buy #stock-id").val($(this).data("stock-id"));
    M.updateTextFields();
})

$(".stocks-entries").on("click", ".stocks-sell", function (e) {
    $("#stock-modal-sell").modal("open");
    $("#stock-modal-sell #stock-id").val($(this).data("stock-id"));
    M.updateTextFields();
})

$("#stock-form").submit(function (event) {
    event.preventDefault();
    $.post("https://np-phone/stocksTradeToPlayer", JSON.stringify({
        identifier: escapeHtml($("#stock-form #stock-id").val()),
        playerid: escapeHtml($("#stock-form #stock-target-id").val()),
        amount: escapeHtml($("#stock-form #stock-amount").val()),
    }));
    $("#stock-form").trigger("reset");
    $("#stock-modal").modal("close");
});

$("#stock-form-buy").submit(function (event) {
    event.preventDefault();
    $.post("https://np-phone/stocksBuy", JSON.stringify({
        identifier: escapeHtml($("#stock-form-buy #stock-id").val()),
        amount: escapeHtml($("#stock-form-buy #stock-amount").val()),
    }));
    $("#stock-form-buy").trigger("reset");
    $("#stock-modal-buy").modal("close");
});

$("#stock-form-sell").submit(function (event) {
    event.preventDefault();
    $.post("https://np-phone/stocksSell", JSON.stringify({
        identifier: escapeHtml($("#stock-form-sell #stock-id").val()),
        amount: escapeHtml($("#stock-form-sell #stock-amount").val()),
    }));
    $("#stock-form-sell").trigger("reset");
    $("#stock-modal-sell").modal("close");
});