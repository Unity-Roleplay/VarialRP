function addVehicles(vehicleData) {
    $(".garage-entries").empty();

    for (let vehicle of Object.keys(vehicleData)) {
        let paymentString = "";
        let paymentDue = Math.ceil(7 - parseFloat(vehicleData[vehicle].lastPayment));
        if (paymentDue == 0) {
            paymentString = "Pague hoje";
        } else if (paymentDue < 0) {
            paymentString = `O pagamento foi a ${Math.abs(paymentDue)} dias atrás`
        } else {
            paymentString = `${paymentDue} dias até o pagamento.`
        }

        let carIconColor = "white";
        if (vehicleData[vehicle].payments > 0 && vehicleData[vehicle].lastPayment > 7) {
            carIconColor = "red";
        } else if (vehicleData[vehicle].payments > 0 && vehicleData[vehicle].lastPayment > 5) {
            carIconColor = "orange";
        }

        var vehicleElement = `
        <li style="margin-top: 1.5%;">
            <div class="collapsible-header garage-header left-align">
                <i class="fas fa-car ${carIconColor}-text" style="font-size: 2.5rem;"></i>
                <span style="margin-left: 5%; margin-top: 4%; text-overflow: ellipsis; overflow:hidden; max-width:15ch; white-space:nowrap; background-color:transparent" data-badge-caption="">${vehicleData[vehicle].name}</span>
                <span class="new badge" style="margin-top: 4%; text-overflow: ellipsis; overflow:hidden; max-width:15ch; white-space:nowrap; background-color:transparent" data-badge-caption="">${vehicleData[vehicle].state}</span>
            </div>
            <div class="collapsible-body garage-body left-align">
                <div class="row">
                    <div class="col s12">
                        <ul class="collection garage-collection">
                            <li class="collection-item">
                                <i class="fas fa-map-marker-alt"></i>
                                &nbsp;${vehicleData[vehicle].garage}
                            </li>
                            <li class="collection-item">
                                <i class="fas fa-closed-captioning"></i>
                                &nbsp;${vehicleData[vehicle].plate}
                            </li>
                            <li class="collection-item">
                                <i class="fas fa-oil-can"></i>
                                &nbsp;${vehicleData[vehicle].enginePercent}% Motor
                            </li>
                            <li class="collection-item">
                                <i class="fas fa-car-crash"></i>
                                &nbsp;${vehicleData[vehicle].bodyPercent}% Chassi
                            </li>`
                            if (vehicleData[vehicle].payments > 0) {
                                vehicleElement += `
                                <li class="collection-item">
                                    <i class="fas fa-hourglass-half" style="margin-left: 1%"></i>
                                    &nbsp;${paymentString}
                                </li>
                                <li class="collection-item">
                                    <i class="fas fa-credit-card"></i>
                                    &nbsp;${vehicleData[vehicle].payments} pagamentos restantes
                                </li>
                                <li class="collection-item">
                                    <i class="fas fa-dollar-sign"></i>
                                    &nbsp;Saldo Devedor $${(vehicleData[vehicle].amountDue * vehicleData[vehicle].payments)} (Cada Parcela $${vehicleData[vehicle].amountDue})
                                </li>`
                            }
                            vehicleElement += `<li class="collection-item"></li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col s12 center-align">`
                    if (vehicleData[vehicle].canSpawn) {
                        vehicleElement += `
                        <button class="btn-small garage-button garage-spawn" data-id="${vehicleData[vehicle].id}" aria-label="Spawn" data-balloon-pos="down">
                            <i class="fas fa-magic fa-2x" style="font-size: 2.0rem;"></i>
                        </button>`
                    }
                    if (vehicleData[vehicle].payments > 0) {
                        vehicleElement += `
                        <button class="btn-small garage-button garage-pay" data-id="${vehicleData[vehicle].id}" aria-label="Pay" data-balloon-pos="down">
                            <i class="fas fa-hand-holding-usd" style="font-size: 2.0rem;"></i>
                        </button> `
                    }
                    vehicleElement += `
                    <button class="btn-small garage-button garage-track" data-id="${vehicleData[vehicle].id}" aria-label="Track" data-balloon-pos="down">
                        <i class="fas fa-map-marker-alt" style="font-size: 2.0rem;"></i>
                    </button>
                    </div>
                </div>
            </div>
        </li>`

        $(".garage-entries").append(vehicleElement);
    }

    openContainer("garage");
}

$(".garage-entries").on("click", ".garage-spawn", function (e) {
    e.preventDefault();
    $.post("https://np-phone/vehspawn", JSON.stringify({ id: $(this).data("id") }));
});

$(".garage-entries").on("click", ".garage-track", function (e) {
    e.preventDefault();
    $.post("https://np-phone/vehtrack", JSON.stringify({ id: $(this).data("id") }));
});

$(".garage-entries").on("click", ".garage-pay", function (e) {
    e.preventDefault();
    $.post("https://np-phone/vehiclePay", JSON.stringify({ id: $(this).data("id") }));
});