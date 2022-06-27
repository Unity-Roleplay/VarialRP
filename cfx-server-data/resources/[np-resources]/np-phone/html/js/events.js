function btnHangUp(){
    $.post('https://np-phone/btnHangup', JSON.stringify({}))
}

function btnAnswer(){
    $.post('https://np-phone/btnAnswer', JSON.stringify({}))
}

function pingReject(){
    $.post('https://np-phone/np-ui:pingReject', JSON.stringify({}))
}

function pingAccept(){
    $.post('https://np-phone/np-ui:pingAccept', JSON.stringify({}))
}

function billDecline(){
}

function billAccept(data){
    if (data.pType == "car_sale") {   
        let price = data.amount
        let sID = data.sellerID
        let pType = data.pType
        $.post('https://np-phone/purchaseCar', JSON.stringify({amount: price, sID: sID, pType: pType}))
    } else if (data.pType == "gas_station") {
        let price = data.amount
        let sID = data.sellerID
        let pType = data.pType
        $.post('https://np-phone/purchase_gas', JSON.stringify({amount: price, sID: sID, pType: pType}))
    }
}