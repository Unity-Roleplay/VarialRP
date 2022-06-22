function addDebtCars(vehData){
    if (Object.keys(vehData).length == 0){
        $('.asset-fee').css('display', 'none');
    }
    if (Object.keys(vehData).length >= 1){
        $('.asset-fee').css('display', 'block');
    }
    for (let vehicle of Object.keys(vehData)) {
        let price = 0 
        let payment = ""
        if (vehData[vehicle].price !== null){
            price = vehData[vehicle].price
        }
        if (vehData[vehicle].days_left === 0){
            payment = "Payments Overdue"
        }else{
            payment = vehData[vehicle].days_left+" Day(s) left"
        }
        // console.log("VEHICLE NAME",vehData[vehicle].name)
        var car =`<div class="DebtPaper" id="debt-${vehData[vehicle].id}">
        <div class="debtContainer clicked-function-container debt-count">
           <div class="image">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="receipt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" class="svg-inline--fa fa-receipt fa-w-12 fa-3x" style="padding-right: 10px; overflow: unset;"><path fill="currentColor" d="M499.99 176h-59.87l-16.64-41.6C406.38 91.63 365.57 64 319.5 64h-127c-46.06 0-86.88 27.63-103.99 70.4L71.87 176H12.01C4.2 176-1.53 183.34.37 190.91l6 24C7.7 220.25 12.5 224 18.01 224h20.07C24.65 235.73 16 252.78 16 272v48c0 16.12 6.16 30.67 16 41.93V416c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32v-32h256v32c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32v-54.07c9.84-11.25 16-25.8 16-41.93v-48c0-19.22-8.65-36.27-22.07-48H494c5.51 0 10.31-3.75 11.64-9.09l6-24c1.89-7.57-3.84-14.91-11.65-14.91zm-352.06-17.83c7.29-18.22 24.94-30.17 44.57-30.17h127c19.63 0 37.28 11.95 44.57 30.17L384 208H128l19.93-49.83zM96 319.8c-19.2 0-32-12.76-32-31.9S76.8 256 96 256s48 28.71 48 47.85-28.8 15.95-48 15.95zm320 0c-19.2 0-48 3.19-48-15.95S396.8 256 416 256s32 12.76 32 31.9-12.8 31.9-32 31.9z" class=""></path>
            </svg>
           </div>
           <div class="details ">
              <div class="title ">
                 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">${price.toLocaleString('en-US', { style: 'currency', currency: 'USD' })}</p>
              </div>
              <div class="description ">
                 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">Vehicle (${vehData[vehicle].name})</p>
              </div>
           </div>
        </div>
        <div class="debtDrawer">
           <div class="debtItem">
              <div class="icon">
                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="calendar" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-calendar fa-w-14 fa-1x"><path fill="currentColor" 
                    d="M512 32H64C28.65 32 0 60.65 0 96v320c0 35.35 28.65 64 64 64h448c35.35 0 64-28.65 64-64V96C576 60.65 547.3 32 512 32zM168.6 289.9c18.69 18.72 49.19 18.72 67.87 0c9.375-9.375 24.56-9.375 33.94 0s9.375 24.56 0 33.94c-18.72 18.72-43.28 28.08-67.87 28.08s-49.16-9.359-67.87-28.08C116.5 305.8 106.5 281.6 106.5 256s9.1-49.75 28.12-67.88c37.44-37.44 98.31-37.44 135.7 0c9.375 9.375 9.375 24.56 0 33.94s-24.56 9.375-33.94 0c-18.69-18.72-49.19-18.72-67.87 0C159.5 231.1 154.5 243.2 154.5 256S159.5 280.9 168.6 289.9zM360.6 289.9c18.69 18.72 49.19 18.72 67.87 0c9.375-9.375 24.56-9.375 33.94 0s9.375 24.56 0 33.94c-18.72 18.72-43.28 28.08-67.87 28.08s-49.16-9.359-67.87-28.08C308.5 305.8 298.5 281.6 298.5 256s9.1-49.75 28.12-67.88c37.44-37.44 98.31-37.44 135.7 0c9.375 9.375 9.375 24.56 0 33.94s-24.56 9.375-33.94 0c-18.69-18.72-49.19-18.72-67.87 0C351.5 231.1 346.5 243.2 346.5 256S351.5 280.9 360.6 289.9z" class=""></path></svg>
              </div>
              <div class="text">
                 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">${vehData[vehicle].license_plate}</p>
              </div>
           </div>
           <div class="debtItem">
              <div class="icon">
                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="calendar" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-calendar fa-w-14 fa-1x"><path fill="currentColor" 
                    d="M12 192h424c6.6 0 12 5.4 12 12v260c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V204c0-6.6 5.4-12 12-12zm436-44v-36c0-26.5-21.5-48-48-48h-48V12c0-6.6-5.4-12-12-12h-40c-6.6 0-12 5.4-12 12v52H160V12c0-6.6-5.4-12-12-12h-40c-6.6 0-12 5.4-12 12v52H48C21.5 64 0 85.5 0 112v36c0 6.6 5.4 12 12 12h424c6.6 0 12-5.4 12-12z" class=""></path></svg>
              </div>
              <div class="text">
                 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">${payment}</p>
              </div>
           </div>
            <div class="flex-space-around" style="align-items: center;display: flex; width: 100%;">
                <button
                cPayment="${price}" plate="${vehData[vehicle].license_plate}" class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall c-pawynow-button" id="c-pawynow-button"
                tabindex="0" type="button" debt-id="${vehData[vehicle].id}">
                <span class="MuiButton-label">PAY NOW</span>
                <span class="MuiTouchRipple-root"></span>
                </button>
            </div>
           </div>
     </div>`
     $('.cars-entries').append(car);
    }

    $('.c-pawynow-button').click(function(){
        plate = $(this).attr("plate")
        payment = $(this).attr("cPayment")
        $.post("https://np-phone/car_paid", JSON.stringify({
            plate:plate,
            payment:payment
        }))
        complateInputJustGreen();
        setTimeout(() => {
            $.post("https://np-phone/btnDebt", JSON.stringify({}))
        }, 2000);
   })

    $('.debtContainer').parent('.DebtPaper').children(".debtDrawer").css("display", "none");
}

function addDebtHouse(houseData){
    if (Object.keys(houseData).length == 0){
        $('.h-loan').css('display', 'none');
    }
    if (Object.keys(houseData).length >= 1){
        $('.h-loan').css('display', 'block');
    }
    for (let house of Object.keys(houseData)) {
        let paymentString = "";
        let paymentDue = Math.ceil(7 - parseFloat(houseData[house].last_payment));
        if (paymentDue == 0) {
            paymentString = "Payments Overdue";
        } else {
            paymentString = `${paymentDue} Day(s) left`
        }
        let paymentReq = Math.ceil((houseData[house].price/paymentDue))
            var houses = `
            <div class="DebtPaper" id="debt-${houseData[house].id}">
            <div class="debtContainer clicked-function-container debt-count">
            <div class="image">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="receipt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" class="svg-inline--fa fa-receipt fa-w-12 fa-3x"><path fill="currentColor" d="M358.4 3.2L320 48 265.6 3.2a15.9 15.9 0 0 0-19.2 0L192 48 137.6 3.2a15.9 15.9 0 0 0-19.2 0L64 48 25.6 3.2C15-4.7 0 2.8 0 16v480c0 13.2 15 20.7 25.6 12.8L64 464l54.4 44.8a15.9 15.9 0 0 0 19.2 0L192 464l54.4 44.8a15.9 15.9 0 0 0 19.2 0L320 464l38.4 44.8c10.5 7.9 25.6.4 25.6-12.8V16c0-13.2-15-20.7-25.6-12.8zM320 360c0 4.4-3.6 8-8 8H72c-4.4 0-8-3.6-8-8v-16c0-4.4 3.6-8 8-8h240c4.4 0 8 3.6 8 8v16zm0-96c0 4.4-3.6 8-8 8H72c-4.4 0-8-3.6-8-8v-16c0-4.4 3.6-8 8-8h240c4.4 0 8 3.6 8 8v16zm0-96c0 4.4-3.6 8-8 8H72c-4.4 0-8-3.6-8-8v-16c0-4.4 3.6-8 8-8h240c4.4 0 8 3.6 8 8v16z" class=""></path></svg>
            </div>
            <div class="details ">
                <div class="title ">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                         style="word-break: break-word;">${paymentReq.toLocaleString('en-US', { style: 'currency', currency: 'USD' })}</p>
                </div>
                <div class="description ">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">House (${houseData[house].house_name})</p>
                </div>
            </div>
            </div>
            <div class="debtDrawer">
            <div class="debtItem">
                <div class="icon">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="calendar" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-calendar fa-w-14 fa-1x"><path fill="currentColor" d="M12 192h424c6.6 0 12 5.4 12 12v260c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V204c0-6.6 5.4-12 12-12zm436-44v-36c0-26.5-21.5-48-48-48h-48V12c0-6.6-5.4-12-12-12h-40c-6.6 0-12 5.4-12 12v52H160V12c0-6.6-5.4-12-12-12h-40c-6.6 0-12 5.4-12 12v52H48C21.5 64 0 85.5 0 112v36c0 6.6 5.4 12 12 12h424c6.6 0 12-5.4 12-12z" class=""></path></svg>
                </div>
                <div class="text">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">${paymentString}</p>
                </div>
            </div>
                <div class="flex-space-around" style="align-items: center;display: flex; width: 100%;">
                    <button
                        class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall h-pawynow-button"
                        hId="${houseData[house].house_id}" h-payment="${paymentReq}" tabindex="0" type="button" debt-id="${houseData[house].id}">
                    <span class="MuiButton-label">PAY NOW</span>
                    <span class="MuiTouchRipple-root"></span>
                    </button>
                </div>
            </div>
        </div>`

        $('.debt-house-entries').append(houses);
    }
   $('.h-pawynow-button').click(function(){
        hid = $(this).attr("hId")
        payment = $(this).attr("h-payment")
        $.post("https://np-phone/h_paid", JSON.stringify({
            hid:hid,
            payment:payment
        }))
        complateInputJustGreen();
        setTimeout(() => {
            $.post("https://np-phone/btnDebt", JSON.stringify({}))
        }, 2000);
   })
    $('.debtContainer').parent('.DebtPaper').children(".debtDrawer").css("display", "none");
}

function addDebtPlayer(playerDebt){
    if (Object.keys(playerDebt).length == 0){
        $('.player-debt').css('display', 'none');
    }
    if (Object.keys(playerDebt).length >= 1){
        $('.player-debt').css('display', 'block');
    }
    // console.log(JSON.stringify(playerDebt))
    for (let debt of Object.keys(playerDebt)) {
       
            let price = playerDebt[debt].price
            var houses = `
            <div class="DebtPaper" id="pdebt-${playerDebt[debt].id}">
            <div class="debtContainer clicked-function-container debt-count">
            <div class="image">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="receipt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" class="svg-inline--fa fa-receipt fa-w-12 fa-3x"><path fill="currentColor" d="M384 128h-128V0L384 128zM256 160H384v304c0 26.51-21.49 48-48 48h-288C21.49 512 0 490.5 0 464v-416C0 21.49 21.49 0 48 0H224l.0039 128C224 145.7 238.3 160 256 160zM64 88C64 92.38 67.63 96 72 96h80C156.4 96 160 92.38 160 88v-16C160 67.63 156.4 64 152 64h-80C67.63 64 64 67.63 64 72V88zM72 160h80C156.4 160 160 156.4 160 152v-16C160 131.6 156.4 128 152 128h-80C67.63 128 64 131.6 64 136v16C64 156.4 67.63 160 72 160zM197.5 316.8L191.1 315.2C168.3 308.2 168.8 304.1 169.6 300.5c1.375-7.812 16.59-9.719 30.27-7.625c5.594 .8438 11.73 2.812 17.59 4.844c10.39 3.594 21.83-1.938 25.45-12.34c3.625-10.44-1.891-21.84-12.33-25.47c-7.219-2.484-13.11-4.078-18.56-5.273V248c0-11.03-8.953-20-20-20s-20 8.969-20 20v5.992C149.6 258.8 133.8 272.8 130.2 293.7c-7.406 42.84 33.19 54.75 50.52 59.84l5.812 1.688c29.28 8.375 28.8 11.19 27.92 16.28c-1.375 7.812-16.59 9.75-30.31 7.625c-6.938-1.031-15.81-4.219-23.66-7.031l-4.469-1.625c-10.41-3.594-21.83 1.812-25.52 12.22c-3.672 10.41 1.781 21.84 12.2 25.53l4.266 1.5c7.758 2.789 16.38 5.59 25.06 7.512V424c0 11.03 8.953 20 20 20s20-8.969 20-20v-6.254c22.36-4.793 38.21-18.53 41.83-39.43C261.3 335 219.8 323.1 197.5 316.8z" class=""></path></svg>
            </div>
            <div class="details ">
                <div class="title ">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                         style="word-break: break-word;">${price.toLocaleString('en-US', { style: 'currency', currency: 'USD' })}</p>
                </div>
                <div class="description ">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">${playerDebt[debt].type}</p>
                </div>
            </div>
            </div>
            <div class="debtDrawer">
            <div class="debtItem">
                <div class="icon">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="calendar" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-calendar fa-w-14 fa-1x"><path fill="currentColor" d="M12 192h424c6.6 0 12 5.4 12 12v260c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V204c0-6.6 5.4-12 12-12zm436-44v-36c0-26.5-21.5-48-48-48h-48V12c0-6.6-5.4-12-12-12h-40c-6.6 0-12 5.4-12 12v52H160V12c0-6.6-5.4-12-12-12h-40c-6.6 0-12 5.4-12 12v52H48C21.5 64 0 85.5 0 112v36c0 6.6 5.4 12 12 12h424c6.6 0 12-5.4 12-12z" class=""></path></svg>
                </div>
                <div class="text">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">${playerDebt[debt].comment}</p>
                </div>
            </div>
            <div class="debtItem">
                <div class="icon">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="calendar" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-calendar fa-w-14 fa-1x"><path fill="currentColor" d="M224 256c70.7 0 128-57.31 128-128s-57.3-128-128-128C153.3 0 96 57.31 96 128S153.3 256 224 256zM274.7 304H173.3C77.61 304 0 381.6 0 477.3c0 19.14 15.52 34.67 34.66 34.67h378.7C432.5 512 448 496.5 448 477.3C448 381.6 370.4 304 274.7 304z" class=""></path></svg>
                </div>
                <div class="text">
                    <p aria-label="Biller" class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">${playerDebt[debt].name}</p>
                </div>
            </div>
            <div class="debtItem">
            <div class="icon">
                <svg  aria-hidden="true" focusable="false" data-prefix="fas" data-icon="calendar" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-calendar fa-w-14 fa-1x"><path fill="currentColor" d="M18.92 351.2l108.5-46.52c12.78-5.531 27.77-1.801 36.45 8.98l44.09 53.82c69.25-34 125.5-90.31 159.5-159.5l-53.81-44.04c-10.75-8.781-14.41-23.69-8.974-36.47l46.51-108.5c6.094-13.91 21.1-21.52 35.79-18.11l100.8 23.25c14.25 3.25 24.22 15.8 24.22 30.46c0 252.3-205.2 457.5-457.5 457.5c-14.67 0-27.18-9.968-30.45-24.22l-23.25-100.8C-2.571 372.4 5.018 357.2 18.92 351.2z" class=""></path></svg>
            </div>
            <div class="text">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                aria-label="Call" id="call-debt" phone_number="${playerDebt[debt].number}" style="word-break: break-word;">${playerDebt[debt].number}</p>
            </div>
        </div>
            <div class="debtItem">
                <div class="icon">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="calendar" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-calendar fa-w-14 fa-1x"><path fill="currentColor" d="M528 32h-480C21.49 32 0 53.49 0 80V96h576V80C576 53.49 554.5 32 528 32zM0 432C0 458.5 21.49 480 48 480h480c26.51 0 48-21.49 48-48V128H0V432zM368 192h128C504.8 192 512 199.2 512 208S504.8 224 496 224h-128C359.2 224 352 216.8 352 208S359.2 192 368 192zM368 256h128C504.8 256 512 263.2 512 272S504.8 288 496 288h-128C359.2 288 352 280.8 352 272S359.2 256 368 256zM368 320h128c8.836 0 16 7.164 16 16S504.8 352 496 352h-128c-8.836 0-16-7.164-16-16S359.2 320 368 320zM176 192c35.35 0 64 28.66 64 64s-28.65 64-64 64s-64-28.66-64-64S140.7 192 176 192zM112 352h128c26.51 0 48 21.49 48 48c0 8.836-7.164 16-16 16h-192C71.16 416 64 408.8 64 400C64 373.5 85.49 352 112 352z" class=""></path></svg>
                </div>
                <div class="text">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                     style="word-break: break-word;">${playerDebt[debt].biller}</p>
                </div>
            </div>
                <div class="flex-space-around" style="align-items: center;display: flex; width: 100%;">
                    <button
                        class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall p-pawynow-button"
                        dId="${playerDebt[debt].id}" pId="${playerDebt[debt].cid}" p-payment="${price}" tabindex="0" type="button">
                    <span class="MuiButton-label">PAY NOW</span>
                    <span class="MuiTouchRipple-root"></span>
                    </button>
                </div>
            </div>
        </div>`

        $('.player-entries').append(houses);
    }
   $('.p-pawynow-button').click(function(){
        pid = $(this).attr("pId")
        did = $(this).attr("dId")
        payment = $(this).attr("p-payment")
        $.post("https://np-phone/p_paid", JSON.stringify({
            pid:pid,
            did:did,
            payment:payment
        }))
        complateInputJustGreen();
        setTimeout(() => {
            $.post("https://np-phone/btnDebt", JSON.stringify({}))
        }, 2000);
   })
   $('#call-debt').click(function(e){
       $.post('http://np-phone/callContact', JSON.stringify({ 
           name: $(this).data('name'), 
           number: $(this).attr("phone_number")
        }));
   })
    $('.debtContainer').parent('.DebtPaper').children(".debtDrawer").css("display", "none");
}


// $('.cars-entries, .debtjss271711').on('click', '.c-pawynow-button',function(e){
//     e.preventDefault();
//     // console.log("PAYMENTS FOR CAR")
//     plate = $(this).attr("plate")
//     overid = $(this).attr("cPayment")
//     console.log("PRICE",overid,plate)
// })
