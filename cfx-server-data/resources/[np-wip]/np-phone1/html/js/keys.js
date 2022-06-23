function addKeys(keys) {
    $('.keys-entries').empty();
    openContainer("keys");

    for (let keyType of Object.keys(keys)) {
        for (let i = 0; i < keys[keyType].length; i++) {
            let key = keys[keyType][i];

            let paymentString = "";
            let paymentDue = Math.ceil(7 - parseFloat(key.last_payment));
            if (paymentDue == 0) {
                paymentString = "Pagar hoje";
            } else if (paymentDue < 0) {
                paymentString = `Pagamento vencido a ${Math.abs(paymentDue)} dias`
            } else {
                paymentString = `${paymentDue} dias para pagar`
            }

            var keyElement = `
            <li data-key-type="${keyType}" style="margin-top: 1.5%;">
                <div class="collapsible-header keys-header">
                    <span class="left">
                    <i class="fas ${keyType === "sharedKeys" ? "fa-handshake" : "fa-key"}"> </i>
                    ${key.house_name}</span>
                    <div class="col s2 right-align">
                        <i class="fas fa-map-marker-alt gps-location-click" data-house-id="${key.house_id}"></i>
                    </div>
                </div>
                <div class="collapsible-body garage-body">
                    <div class="row">
                        <div class="col s12">
                            <ul class="collection garage-collection">
                                <li class="collection-item"><i class="fas fa-hourglass-half"></i>&nbsp;${paymentString}</li>
                                <li class="collection-item"><i class="fas fa-money-check-alt"></i>&nbsp;Aluguel: $${key.house_price}</li>
                                <li class="collection-item"></li>
                            </ul>
                        </div>
                    </div>`
            if (keyType === "ownedKeys") {
                keyElement += `
                        <div class="row no-padding">
                            <div class="col s12 center-align no-padding button-row" >
                                <button class="btn-small keys-button give-key" data-house-id="${key.house_id}" aria-label="Dar Chaves" data-balloon-pos="up"><i class="fas fa-key" style="font-size: 1.5rem;"></i></button>
                                <button class="btn-small keys-button manage-keys" data-house-id="${key.house_id}" aria-label="Gerenciar Chaves" data-balloon-pos="up"><i class="fas fa-user-slash" style="font-size: 1.5rem;"></i></button>
                                <button class="btn-small keys-button pay-mortgage" data-house-id="${key.house_id}" aria-label="Pagar Aluguel" data-balloon-pos="up-right"><i class="fas fa-hand-holding-usd" style="font-size: 1.5rem;"></i></button>
                            </div>
                        </div>
                        `
            } else if (keyType == "sharedKeys") {
                keyElement += `
                <div class="row no-padding">
                    <div class="col s12 center-align no-padding">
                        <button class="btn-small keys-button pay-mortgage" data-house-id="${key.house_id}" aria-label="Pagar Aluguel" data-balloon-pos="up-right"><i class="fas fa-hand-holding-usd" style="font-size: 1.5rem;"></i></button>
                        <button class="btn-small keys-button remove-shared-key" data-house-id="${key.house_id}" aria-label="Remover Chave" data-balloon-pos="up"><i class="fas fa-user-slash" style="font-size: 1.5rem;"></i></button>
                    </div>
                </div>
                `
            }

            keyElement += `
                </div>
            </li>
        `
            $('.keys-entries').append(keyElement);
        }
    }
}

function addManageKeys(keys) {
    $('.manage-keys-entries').empty();
    openContainer('manage-keys');

    for (let key in keys) {
        $('.manage-keys-house').text(keys[key].house_name);
        let manageHouseKey = `
            <li class="collection-item" style="margin-top: 1.5%; color: white; background-color: #253955; border: none;">
                <div class="row no-padding">
                    <div class="col s9" aria-label="${keys[key].player_name}" data-balloon-pos="down">
                        <span class="truncate" style="font-weight:bold">${keys[key].player_name}</span>
                    </div>
                    <div class="col s3 right-align">
                        <span class="btn-small keys-button manage-keys-remove" data-house-id="${keys[key].house_id}" data-player-id="${keys[key].player_cid}" aria-label="Remove Key" data-balloon-pos="left"><i class="fas fa-user-times fa-2x" style="font-size: 1.5rem;"></i></span>
                    </div>
                </div>
                <div class="row no-padding">
                    <div class="col s12">
                        <span>Citizen ID: ${keys[key].player_cid}</span>
                    </div>
                </div>
            </li>
        `

        $('.manage-keys-entries').append(manageHouseKey);
    }
}

function KeysFilter() {
    var filter = $('#keys-search').val();
    $("ul.keys-entries li").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            if (keyFilters.includes($(this).data('key-type')))
                $(this).hide();
            else
                $(this).show()
        }
    });
}

function ManageKeysFilter() {
    var filter = $('#manage-keys-search').val();
    $("ul.manage-keys-entries li").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

$('#keys-search').keyup(debounce(function () {
    KeysFilter();
}, 500));

$('#manage-keys-search').keyup(debounce(function () {
    ManageKeysFilter();
}, 500));

$('.keys-toggle-filter').click(function () {
    let filterData = $(this).data('filter');

    if ($(this).hasClass("grey-text")) {
        if (!keyFilters.includes(filterData))
            keyFilters.push(filterData);
    }
    else
        keyFilters = keyFilters.filter(filter => filter !== filterData);

    KeysFilter();
    $(this).toggleClass("grey-text white-text");
});

$('.keys-entries').on('click', '.manage-keys', function () {
    $.post('https://np-phone/retrieveHouseKeys', JSON.stringify({
        house_id: $(this).data('house-id')
    }));
});

$('.keys-entries').on('click', '.remove-shared-key', function(e) {
    $.post('https://np-phone/removeSharedKey', JSON.stringify({
        house_id: $(this).data('house-id')
    }))
    $(this).closest('li').remove()
});

$('.manage-keys-entries').on('click', '.manage-keys-remove', function () {
    $.post('https://np-phone/removeHouseKey', JSON.stringify({
        house_id: $(this).data('house-id'),
        player_id: $(this).data('player-id')
    }))
});

$('.keys-entries').on('click', '.pay-mortgage', function(e) {
    $.post('https://np-phone/btnMortgage', JSON.stringify({
        house_id: $(this).data('house-id'),
    }))
});

$('.keys-entries').on('click', '.give-key', function(e) {
    $.post('https://np-phone/btnGiveKey', JSON.stringify({
        house_id: $(this).data('house-id'),
    }))
});